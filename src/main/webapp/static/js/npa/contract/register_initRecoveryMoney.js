var recoveryPrincipal, recoveryInterest, hangInteres, interestDate, index;

$(function() {
  initValidform();
});

/**
 * 表单验证加载
 * 
 * @returns
 */
function initValidform() {
  $("#formobj").Validform({
    datatype: {
      currency: function(gets, obj, curform, regxp) {
        var reg = /^(0|(0{1}\.\d{1,2}|([1-9]{1}\d{0,6}\.{1}\d{1,2})|([1-9]{1}\d{0,6})))$/;
        return reg.test(gets);
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
      recoveryPrincipal = $('#recoveryPrincipal').val();
      recoveryInterest = $('#recoveryInterest').val();
      hangInteres = $('#hangInteres').val();
      interestDate = $('#interestDate').val();
      index = $('#index').val();
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
        win.initRecoveryMoneyCallBack(index, recoveryPrincipal, recoveryInterest, hangInteres, interestDate);
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