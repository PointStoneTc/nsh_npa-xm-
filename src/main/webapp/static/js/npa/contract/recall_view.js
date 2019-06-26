var form_obj, datagridId = 'recoveryMoney';

$(function() {
  $('#' + datagridId).datagrid({
    rownumbers: true,
    singleSelect: true,
    fitColumns: true
  });

  $('#b1').val(formatNull(contract_obj.amount - contract_obj.recoveryPrincipal));
  initValidform();
});

/**
 * 表单验证加载
 * 
 * @returns
 */
function initValidform() {
  form_obj = $("#formobj").Validform({
    datatype: {
      custom1: function(gets, obj, curform, regxp) {
        var reg = /^(0|(0{1}\.\d{1,2}|([1-9]{1}\d{0,6}\.{1}\d{1,2})|([1-9]{1}\d{0,6})))$/;
        return reg.test(gets) && parseInt(gets) != 0;
      },
      custom2: function(gets, obj, curform, regxp) {
        var reg = /^(0|(0{1}\.\d{1,2}|([1-9]{1}\d{0,6}\.{1}\d{1,2})|([1-9]{1}\d{0,6})))$/;
        return reg.test(gets.replace(/,/g, ''));
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
      if ($('#lixika').datagrid('getData').total == 0) {
        tip('请先计算!');
        return false;
      }

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
        reloadFormAndTable(win);
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
 * 刷新表单及列表
 * 
 * @returns
 */
function reloadFormAndTable(opener) {
  // 更新回款明细
  $('#' + datagridId).datagrid('appendRow', {
    recoveryDate: $('#recoveryDate').val(),
    recoveryPerson: $('#recoveryPerson').val(),
    interestDate: $('#interestDate').val(),
    interestRate: $('#interestRate').val(),
    interestBearingPrincipal: $('#interestBearingPrincipal').val(),
    recoveryPrincipal: $('#recoveryPrincipal').val(),
    recoveryInterest: $('#recoveryInterest').val(),
    hangInterest: $('#hangInterest').val(),
    recoveryMode: $("#recoveryMode").val()
  });

  $('#' + datagridId).datagrid('resize', {
    width: '100%',
    height: '100%'
  });

  // 更新obj的收回本金,利息,挂息金额, 起息日
  contract_obj.recoveryPrincipal = parseFloat(contract_obj.recoveryPrincipal + parseFloat($('#recoveryPrincipal').val()));
  contract_obj.recoveryInterest = parseFloat(contract_obj.recoveryInterest + parseFloat($('#recoveryInterest').val()));
  contract_obj.hangInterest = parseFloat(contract_obj.hangInterest + parseFloat($('#hangInterest').val()));
  contract_obj.interestDate = $('#interestDate').val();

  // 更新表单及详情
  $('#recoveryDate').val('');
  $('#recoveryPerson').val('');
  $('#recoveryPrincipal').val('0.0');
  $('#interestRate').val(contract_obj.interestRate);
  $('#interestDate').val('');
  $('#hangInterest').val('0.0');
  $('#recoveryMode').val('');
  $('#b1').val(formatNull(contract_obj.amount - contract_obj.recoveryPrincipal));
  $('#b2').val('0.0');
  $('#recoveryInterest').val('');

  $('#lixika').datagrid('loadData', {
    total: 0,
    rows: []
  });

  $('#y1').text('');
  $('#y2').text('');
  $('#y3').text('');
  $('#y4').text('');

  // 更新合同中的金额信息
  $('#htxq td[id="qxr"]').text(contract_obj.interestDate);
  $('#htxq td[id="hsbj"]').text('￥' + formatNull(contract_obj.recoveryPrincipal));
  $('#htxq td[id="hslx"]').text('￥' + formatNull(contract_obj.recoveryInterest));
  $('#htxq td[id="gx"]').text('￥' + formatNull(contract_obj.hangInterest));

  opener.updateRowAmount(contract_obj.recoveryPrincipal, contract_obj.recoveryInterest, contract_obj.hangInterest, contract_obj.interestDate, selectRowIndex);
  tip('保存成功!');
}

/**
 * 利息计算器
 * 
 * @returns
 */
function calculator() {
  $('#b2').val('0.0');
  if (!form_obj.check()) { return true; }
  var recoveryPrincipal = parseFloat($('#recoveryPrincipal').val());
  var interestRate = $('#interestRate').val();
  var interestDate = new Date($('#interestDate').val());

  var res = calInterest(recoveryPrincipal, interestDate, contract_obj.dueDate, interestRate, 'm', true, 0.5);

  $('#lixika').datagrid('loadData', {
    total: res.length,
    rows: res,
    footer:[{"interest":'￥' + formatNull(res[0].interest + res[1].interest),"rate":"总计:", "isFooter":true}]
  });

  $('#y1').text(res[1].days + '天');  // 逾期罚息
  $('#y2').text(formatNull(res[1].interest * 1 / 3));  // 罚息金额
  $('#y3').text(formatNull(res[0].interest + res[1].interest * 2 / 3));  // 利息合计
  $('#y4').text(formatNull(recoveryPrincipal + res[0].interest + res[1].interest));  // 计息本金(显示)
  var sybj = contract_obj.amount - contract_obj.recoveryPrincipal - parseFloat($('#recoveryPrincipal').val());
  if(Math.abs(sybj.toFixed(2)) == 0) sybj = 0;
  $('#b2').val(formatNull(sybj));  // 剩余本金
  $('#recoveryInterest').val(res[0].interest + res[1].interest);  // 利息合计(表单用)
  $('#interestBearingPrincipal').val(recoveryPrincipal + res[0].interest + res[1].interest); // 计息本金(表单)
}

/**
 * 计算利息
 * 
 * @param principal
 *          本金
 * @param startDate
 *          开始时间
 * @param endDate
 *          结束时间
 * @param interestRate
 *          利率
 * @param rateBase
 *          利率基数(m: 月, y:年)
 * @param isPercent
 *          是否千分比,如果是需要除以1000
 * @param penaltyInterest
 *          罚息率
 * @returns
 */
function calInterest(principal, startDate, endDate, interestRate, rateBase, isPercent, penaltyInterest) {
  var interest_obj3 = new interest_obj(); // 第3段利息
  var interestArray = new Array();
  var interestRate_real = interestRate * (isPercent ? 0.001 : 1) / (rateBase == 'm' ? 30 : 365);

  for (var i = 0; i < 2; i++) {
    var interest_obj_temp = new interest_obj();
    var d1, d2, r;
    if (i == 0) {
      d1 = new Date(startDate);
      d2 = new Date(endDate);
      r = 1;
    } else if (i == 1) {
      d1 = new Date(endDate);
      d1.setDate(d1.getDate() + 1);
      d2 = new Date();
      r = 1 + 0.5;
    }

    interest_obj_temp.sdate = d1;
    interest_obj_temp.edate = d2;
    interest_obj_temp.amount = principal;
    interest_obj_temp.days = getDaysByDateString(interest_obj_temp.sdate, d2, true);
    interest_obj_temp.rate = interestRate_real * r;
    interest_obj_temp.interest = interest_obj_temp.amount * interest_obj_temp.rate * interest_obj_temp.days;

    interestArray.push(interest_obj_temp);
  }

  interest_obj3.sdate = new Date();
  interest_obj3.edate = new Date();
  interest_obj3.amount = principal;
  interest_obj3.days = 0;
  interest_obj3.rate = 0;
  interest_obj3.interest = 0;

  interestArray.push(interest_obj3);
  return interestArray;
}

/**
 * 全额还款
 * 
 * @returns
 */
function allRecall() {
  $('#recoveryPrincipal').val((contract_obj.amount - contract_obj.recoveryPrincipal).toFixed(2));
}

/**
 * 利息卡对象
 * 
 * @param sdate
 *          开始时间
 * @param edate
 *          结束时间
 * @param amount
 *          金额
 * @param days
 *          天数
 * @param rate
 *          利率
 * @param interest
 *          利息
 * @returns
 */
function interest_obj(sdate, edate, amount, days, rate, interest) {
  this.sdate = sdate;
  this.edate = edate;
  this.amount = amount;
  this.balance = 0;
  this.days = days;
  this.rate = rate;
  this.interest = interest;
  this.isFooter = false;
}

/**
 * easy-ui渲染利率
 * 
 * @param val
 * @param row
 * @returns
 */
function formatRate1(val, row) {
  if (row.isFooter) { // 判断出是否footer
    return val;
  }
  
  if (isNaN(val)) return 'NaN';
  return '<span>' + (val * 1000 * 30).toFixed(3) + '</span>';
}

function test() {
  var win = frameElement.api.opener.updateRowAmount(1, 1, 1);
}