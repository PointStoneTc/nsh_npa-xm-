var guarantee_table_index = 0; // 已经加载的模板数量
var subDlgIndex = null; //
var borrower_table_id = 'borrower_table'; // 借款人容器id

$(function() {
  $('#borrowerIdNumber').on('blur', {
    tableId: 'borrower_table'
  }, idNumberSet);

  // 查询借款人按钮事件
  $('#borrower_search').on('click', {
    title: '选择借款人',
    target: borrower_table_id,
    pre_fix: 'borrower\.'
  }, searchPerson);

  // 借款人清空按钮事件
  $('#borrower_clean').on('click', cleanPerson);

  // 选择所属商行
  $(':input[name="loanContract\.corporateOrgId"]').on('change', function(e) {
    var selectText = $(this).find('option:selected').text();
    $(':input[name="loanContract\.corporateOrgName"]').val(selectText.replace(/^\s+|\s+$/g, ''));
    e.stopPropagation();
    e.preventDefault();
  }).css('width', '145px');

  $(':input[name="loanContract\.corporateOrgId"] option:first').prop('selected', 'selected');
  var selectText = $(':input[name="loanContract\.corporateOrgId"]').find('option:selected').text();
  $(':input[name="loanContract\.corporateOrgName"]').val(selectText.replace(/^\s+|\s+$/g, ''));

  // 担保人新增
  $('#guarantee_add_btn').on('click', addGuaranteeTemplate);

  initBorrwer();
  intiGuarantees();
  initValidform();

  // 初始化法人组织机构选择框
  $(':input[name="loanContract\.corporateOrgId"] option[value=' + corporateOrgId + ']').attr('selected', 'selected');
  // 初始化诉讼状态选择框
  $(':input[name="loanContract\.litigationStat"] option[value=' + litigationStat + ']').attr('selected', 'selected');
  // 初始化担保方式选择框
  $(':input[name="loanContract\.guaranteeMode"] option[value=' + guaranteeMode + ']').attr('selected', 'selected');
  // 初始化处理方式选择框
  $(':input[name="loanContract\.disposeMode"] option[value=' + disposeMode + ']').attr('selected', 'selected');
});

/**
 * 初始化借款人
 * 
 * @returns
 */
function initBorrwer() {
  if ($('#brId').val() != '') {
    var pre_fix = 'borrower\.';
    setUserCommon(borrower_table_id, pre_fix, borrower);
    $('#' + borrower_table_id + ' :input[name="loanContract\.borrowerId"]').val(borrower.id_p);
    $('#' + borrower_table_id + ' :radio[name="loanContract\.isImpersonate"][value="' + borrower.isImpersonate + '"]').attr('checked', true);
    $('#' + borrower_table_id + ' :input[name="borrower\.id"]').val(borrower.id);
  }
}

/**
 * 初始化担保人
 * 
 * @returns
 */
function intiGuarantees() {
  if ($('#ctid').val() != '') {
    $.each(guaranteesArray, function(i, n) {
      var target = addGuaranteeTemplate();
      var pre_fix = 'loanContractGuarantees[' + i + ']\.guarantee\.';
      setUserCommon(target, pre_fix, n);
      $('#' + target + ' :input[name="' + pre_fix + 'id"]').val(n.id);
      $('#' + target + ' :radio[name="loanContractGuarantees[' + i + ']\.isImpersonate"][value="' + n.isImpersonate_p + '"]').attr('checked', true);
      $('#' + target + ' :input[name="loanContractGuarantees[' + i + ']\.id"]').val(n.id_p);
      $('#' + target + ' :input[name="loanContractGuarantees[' + i + ']\.loanContracId"]').val(n.loanContracId_p);
      $('#' + target + ' :input[name="loanContractGuarantees[' + i + ']\.guaranteeId"]').val(n.guaranteeId_p);
    });
  }
}

/**
 * 表单验证加载
 * 
 * @returns
 */
function initValidform() {
  $("#formobj").Validform({
    datatype: {
      numCode: function(gets, obj, curform, regxp) {
        var reg = /^\d{14}$/;
        if (!reg.test(gets)) { return false; }
        var result;
        $.ajax({
          url: 'register.do?checkNumCodeValid',
          data: {
            'id': $('#ctid').val(),
            'numCode': gets
          },
          dataType: 'json',
          type: 'post',
          async: false,
          success: function(data) {
            result = data.success;
          },
          error: function(data) {
          }
        });
        return result;
      }
    },
    tiptype: function(msg, o, cssctl) {
      if (o.type == 3) {
        ValidationMessage(o.obj, msg);
      } else {
        removeMessage(o.obj);
      }
    },
    btnSubmit: "#btn_sub",
    ajaxPost: true,
    beforeSubmit: function(curform) {
      var tag = false;
      subDlgIndex = $.dialog({
        content: '正在加载中',
        zIndex: 19910320,
        lock: true,
        width: 100,
        height: 50,
        opacity: 0.3,
        title: '提示',
        cache: false
      });
      var infoTable = subDlgIndex.DOM.t.parent().parent().parent();
      infoTable.parent().append('<div id="infoTable-loading" style="text-align:center;"><img src="plug-in/layer/skin/default/loading-0.gif"/></div>');
      infoTable.css('display', 'none');
    },
    callback: function(data) {
      if (subDlgIndex && subDlgIndex != null) {
        $('#infoTable-loading').hide();
        subDlgIndex.close();
      }
      var win = frameElement.api.opener;
      if (data.success == true) {
        frameElement.api.close();
        win.tip(data.msg);
        win.reloadTable();
      } else {
        if (data.responseText == '' || data.responseText == undefined) {
          $.messager.alert('错误', data.msg);
          $.Hidemsg();
        } else {
          try {
            var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'), data.responseText.indexOf('错误信息'));
            $.messager.alert('错误', emsg);
            $.Hidemsg();
          } catch (ex) {
            $.messager.alert('错误', data.responseText + "");
            $.Hidemsg();
          }
        }
        return false;
      }
    }
  });
}

/**
 * 添加自然人模板
 */
function addGuaranteeTemplate() {
  var existingGuarantees = $('#guarantee_div').children('div[id^=guarantee_table_]');
  $('#guarantee_div').append($('#guarantee_template').html());
  var index = guarantee_table_index; // 下标
  var tableTemplate = $('#guarantee_div div[name="guarantee_table_"]');
  tableTemplate.attr('id', tableTemplate.attr('name') + index).removeAttr('name'); // 修改div.id的名字
  tableTemplate.find('.circle').text(existingGuarantees.length + 1);
  tableTemplate.find('a[attr1]').attr('attr1', tableTemplate.attr('id')); // 修改circle的数字
  $.each(tableTemplate.find('input'), function(i, n) { // 修改所有的名字
    $(n).attr('name', $(n).attr('name').replace(/\[-\]/g, '[' + index + ']'));
  });

  // 增加新增担保人输入身份证号时的事件
  tableTemplate.find(':input[name$=".idNumber"]').on('blur', {
    tableId: 'guarantee_table_' + index
  }, idNumberSet);

  // 查询担保人的按钮事件
  tableTemplate.find('a[name="person_search_btn"]').on('click', {
    title: '选择担保人',
    target: tableTemplate.attr('id'),
    pre_fix: 'loanContractGuarantees[' + index + ']\.guarantee\.'
  }, searchPerson);

  // 清空担保人时的按钮事件
  tableTemplate.find('a[name="person_clean_btn"]').on('click', {
    pre_fix: 'loanContractGuarantees[' + index + ']\.guarantee\.'
  }, cleanPerson);

  // 删除担保人时的按钮事件
  tableTemplate.find('a[name="person_remove_btn"]').on('click', function() {
    var btn = $(this);
    var idx = 0;
    $.each($('#guarantee_div div[id^="guarantee_table_"]'), function(i, n) {
      if ($(this).attr('id') == btn.attr('attr1')) {
        idx = i;
        return false;
      }
    });

    $.each($(tableTemplate).nextAll().find('.circle'), function(i, n) {
      $(n).text(++idx);
    });
    tableTemplate.remove();
  });
  guarantee_table_index++;

  return tableTemplate.attr('id');
}

/**
 * 选择人弹出窗口
 * 
 * @param event
 * @returns
 */
function searchPerson(event) {
  var excludeIdNumbers = '';
  $.each($(':text[name$=".idNumber"]'), function(i, n) {
    if ($(this).val() != '') excludeIdNumbers += $(this).val() + ',';
  });

  if (excludeIdNumbers.length > 0 && excludeIdNumbers.substr(excludeIdNumbers.length - 1, 1) == ',') excludeIdNumbers = excludeIdNumbers.substr(0, excludeIdNumbers.length - 1);

  var url = 'naturalPerson/select.do?one&excludeIdNumbers=' + excludeIdNumbers;
  $.dialog({
    content: 'url:' + url,
    zIndex: 2100,
    title: event.data.title,
    lock: true,
    width: 550,
    height: 400,
    left: '50%',
    top: '30%',
    opacity: 0.4,
    button: [{
      name: '确定',
      callback: function() {
        iframe = this.iframe.contentWindow;
        var res = iframe.getAllBasic();
        if (res != '' && res != null) {
          setUserCommon(event.data.target, event.data.pre_fix, res);
          if (event.data.pre_fix.indexOf(']') > 0) {
            $('#' + event.data.target + ' :input[name="' + event.data.pre_fix.substr(0, event.data.pre_fix.indexOf(']') + 1) + '\.guaranteeId"]').val(res.id);
          }
          $('#' + event.data.target + ' :input[name="' + event.data.pre_fix + 'id"]').val(res.id);
          $('#' + event.data.target + ' :input[name="loanContract\.borrowerId"]').val(res.id);
          $('#' + event.data.target + ' :input[name="borrower\.id"]').val(res.id);
        }
      },
      focus: true
    }, {
      name: '取消',
      callback: function() {
      }
    }]
  });
}

/**
 * 清空人员信息
 */
function cleanPerson() {
  var target = $(this).attr('attr1')
  $('#' + target + ' input:hidden').val('');
  $('#' + target + ' :text').val('');
  $('#' + target + ' :radio[name$="\.sex"]').attr('checked', false)
  $('#' + target + ' :radio[name$="\.isImpersonate"][value=0]').attr('checked', true);
  $('#' + target + ' :text[name$="\.name"]').removeAttr("readonly").removeClass('inputLocked');
  $('#' + target + ' :text[name$="\.idNumber"]').removeAttr("readonly").removeClass('inputLocked');
  $('#' + target + ' :text[name$="\.birthday"]').removeClass('inputLocked');
  $('#' + target + ' :text[name$="\.age"]').removeClass('inputLocked');
  $('#' + target + ' :text[name$="\.phone"]').removeAttr("readonly").removeClass('inputLocked');
  $('#' + target + ' :text[name$="\.address"]').removeAttr("readonly").removeClass('inputLocked');
}

/**
 * 通过身份证信息获取生日、性别、年龄等信息
 */
function idNumberSet(event) {
  var idNumber = $(this).val();

  if (idNumber == '') return false;

  if (!validateIdNumber(idNumber)) {
    alert('身份证格式错误!');
    return false;
  }
  idNumber_other(idNumber, event.data.tableId);
}

function idNumber_other(idNumber, target) {
  var birthday, age, sex;
  if (idNumber.length == 18) {
    birthday = idNumber.substr(6, 4) + '-' + idNumber.substr(10, 2) + '-' + idNumber.substr(12, 2);
    sex = idNumber.substr(14, 3);
  } else {
    birthday = '19' + idNumber.substr(6, 2) + '-' + idNumber.substr(8, 2) + '-' + idNumber.substr(10, 2);
    sex = idNumber.substr(14, 1);
  }
  if (sex % 2 == 0)
    sex = 'f'
  else
    sex = 'm';
  age = getDateYearSub(birthday);

  $('#' + target + ' :text[name$="\.birthday"]').val(birthday);
  $('#' + target + ' :text[name$="\.age"]').val(age);
  $('#' + target + ' :radio[name$="\.sex"][value="' + sex + '"]').attr('checked', true);
}

/**
 * 用户通用的信息设置
 * 
 * @param target
 * @param name_prefix
 * @returns
 */
function setUserCommon(target, name_prefix, user) {
  $('#' + target + ' :text[name="' + name_prefix + 'name"]').val(user.name).attr("readonly", "readonly").addClass('inputLocked');
  $('#' + target + ' :text[name="' + name_prefix + 'idNumber"]').val(user.idNumber).attr("readonly", "readonly").addClass('inputLocked');
  $('#' + target + ' :text[name="' + name_prefix + 'birthday"]').val(user.birthday).addClass('inputLocked');
  $('#' + target + ' :text[name="' + name_prefix + 'age"]').val(user.age).addClass('inputLocked');
  $('#' + target + ' :radio[name="' + name_prefix + 'sex"][value="' + user.sex + '"]').attr('checked', true);
  $('#' + target + ' :text[name="' + name_prefix + 'phone"]').val(user.phone).attr("readonly", "readonly").addClass('inputLocked');
  $('#' + target + ' :text[name="' + name_prefix + 'address"]').val(user.address).attr("readonly", "readonly").addClass('inputLocked');
}