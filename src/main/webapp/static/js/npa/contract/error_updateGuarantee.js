$(function() {
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
                                        datatype: {
                                            idNumber: function(gets, obj, curform, regxp) {
                                                var idNumber = gets;
                                                if (idNumber == '' || !validateIdNumber(idNumber))
                                                    return false;
                                                else {
                                                    var birthday, age, sex;
                                                    if (idNumber.length == 18) {
                                                        birthday = idNumber.substr(6, 4) + '-' + idNumber.substr(10, 2)
                                                                        + '-' + idNumber.substr(12, 2);
                                                        sex = idNumber.substr(14, 3);
                                                    } else {
                                                        birthday = '19' + idNumber.substr(6, 2) + '-'
                                                                        + idNumber.substr(8, 2) + '-'
                                                                        + idNumber.substr(10, 2);
                                                        sex = idNumber.substr(14, 1);
                                                    }
                                                    if (sex % 2 == 0)
                                                        sex = 'f'
                                                    else
                                                        sex = 'm';
                                                    age = getDateYearSub(birthday);

                                                    $('#birthday').val(birthday);
                                                    $('#sex').val(sex);
                                                }
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
                                                var idNumber = $('#idNumber').val();
                                                var indexs = $('#indexs').val();
                                                win.updateBorrowerCallBack(indexs, idNumber);
                                            } else {
                                                if (data.responseText == '' || data.responseText == undefined) {
                                                    $.messager.alert('错误', data.msg);
                                                    $.Hidemsg();
                                                } else {
                                                    try {
                                                        var emsg = data.responseText.substring(data.responseText
                                                                        .indexOf('错误描述'), data.responseText
                                                                        .indexOf('错误信息'));
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