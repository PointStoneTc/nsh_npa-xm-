$(function() {
    // 初始化诉讼状态选择框
    $(':input[name="litigationStat"] option[value=' + litigationStat + ']').attr('selected', 'selected');
    // 初始化担保方式选择框
    $(':input[name="guaranteeMode"] option[value=' + guaranteeMode + ']').attr('selected', 'selected');
    // 初始化处理方式选择框
    $(':input[name="disposeMode"] option[value=' + disposeMode + ']').attr('selected', 'selected');
    initValidform();
});

/**
 * 表单验证加载
 * 
 * @returns
 */
function initValidform() {
    $("#formobj")
        .Validform(
            {
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
                    infoTable
                        .parent()
                        .append(
                            '<div id="infoTable-loading" style="text-align:center;"><img src="plug-in/layer/skin/default/loading-0.gif"/></div>');
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
                        var interestRate = $('#interestRate').val();
                        var officer = $('#officer').val();
                        var litigationStat = $('#litigationStat').val();
                        var guaranteeMode = $('#guaranteeMode').val();
                        var disposeMode = $('#disposeMode').val();
                        var index = $('#index').val();
                        win.updateOtherCallBack(index, interestRate, officer, litigationStat, guaranteeMode,
                            disposeMode);
                    } else {
                        if (data.responseText == '' || data.responseText == undefined) {
                            $.messager.alert('错误', data.msg);
                            $.Hidemsg();
                        } else {
                            try {
                                var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'),
                                    data.responseText.indexOf('错误信息'));
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