var datagridId = "recoverylList";
var recoveryPrincipal, recoveryInterest, hangInteres, interestDate, index;

$(function() {
  initValidform();
});

/**
 * 刷新列表
 * 
 * @returns
 */
function reloadTable() {
  $('#' + datagridId).datagrid('reload');
}

/**
 * 操作按钮加载
 * 
 * @param value
 * @param rec
 * @param index
 * @returns
 */
function operate_formatter(value, rec, index) {
  var rows = $('#' + datagridId).datagrid("getRows");
  res = '';
  if (rows.length == (index + 1)) {
    res = '<a href="#" class="ace_button" alt="删除(请慎用)" onclick="del(' + index + ')" style="background-color:#ff0000;"><i class="fa fa-flash"></i>此数据可删除(请慎用),先点击,后提交</a>';
  }

  return res;
}

/**
 * 删除
 * 
 * @param index
 * @returns
 */
function del(index, url, param) {
  $('#' + datagridId).datagrid('selectRow', index);
  var row = $('#' + datagridId).datagrid('getSelected');
  recoveryPrincipal = row.recoveryPrincipal;
  recoveryInterest = row.recoveryInterest;
  hangInteres = row.hangInterest;
  interestDate = $('#interestDate').val();
  $('#id').val(row.id);
}

/**
 * 表单验证加载
 * 
 * @returns
 */
function initValidform() {
  $("#formobj").Validform({
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