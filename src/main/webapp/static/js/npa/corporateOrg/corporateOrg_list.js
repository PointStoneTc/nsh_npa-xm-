var datagridId1 = "corporateOrgList";
var datagridId2 = "corporateOrgOperatorList";

$(function() {
});

/**
 * 刷新列表
 * 
 * @returns
 */
function reloadTable() {
    $('#' + datagridId2).datagrid('reload');
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
    return '<a href="#" class="ace_button" alt="查看操作员" onclick="viewOperator(' + index + ')" style="background-color:#2f3c45e6;"><i class="fa fa-users"></i>查看操作员</a> '
        + '<a href="#" class="ace_button" alt="新增操作员" onclick="addOperator(' + index + ')" style="background-color:#63c91a;"><i class="fa fa-user-plus"></i>新增操作员</a>';
}

/**
 * 操作员操作按钮加载
 * 
 * @param value
 * @param rec
 * @param index
 * @returns
 */
function operate_opt_formatter(value, rec, index) {
    var selectHtml = '<select name="orgId"><option value="-1">----请选择----</option>';
    for (i = 0; i < orgArray.length; i++) {
        var temp = orgArray[i].split(":");
        if (temp[0] == rec.corporateOrgId) continue;
        selectHtml += '<option value="' + temp[0] + '">' + temp[1] + "</option>";
    }
    selectHtml += '</select>';
    return selectHtml + ' <a href="#" class="ace_button" alt="调动" onclick="depOperator(this,' + index + ')" style="background-color:#63c91a;"><i class="fa fa-trash-o"></i>调动</a> '
        + '<a href="#" class="ace_button" alt="删除" onclick="delOperator(' + index + ')" style="background-color:#f5270f;"><i class="fa fa-trash-o"></i>删除</a>';
}

/**
 * 查看操作员
 * 
 * @param index
 * @returns
 */
function viewOperator(index) {
    $('#' + datagridId1).datagrid('selectRow', index);
    var row = $('#' + datagridId1).datagrid('getSelected');
    $('#' + datagridId2).datagrid('reload', {
        id: row.id
    });

    $('#parentId').val(row.id);
}

/**
 * 新增操作员
 * 
 * @param index
 * @returns
 */
function addOperator(index) {
    $('#' + datagridId1).datagrid('selectRow', index);
    var row = $('#' + datagridId1).datagrid('getSelected');
    if ($("#parentId").val() != row.id) {
        $('#' + datagridId2).datagrid('reload', {
            id: row.id
        });
        $('#parentId').val(row.id);
    }

    var url = 'corporateOrg/operator/select.do?one&orgId=' + row.id;
    $.dialog({
        content: 'url:' + url,
        zIndex: 2100,
        title: '新增操作员',
        lock: true,
        width: 550,
        height: 300,
        left: '50%',
        top: '30%',
        opacity: 0.4,
        button: [{
            name: '确定',
            callback: function() {
                iframe = this.iframe.contentWindow;
                var res = iframe.getAllBasic();
                if (res != '' && res != null) {
                    addOperatorCallback(row.id, res);
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
 * 添加用户回调
 * 
 * @param orgId
 * @param res
 * @returns
 */
function addOperatorCallback(orgId, res) {
    $.ajax({
        url: 'corporateOrg/operator.do?saveOrUpdate',
        type: 'post',
        data: {
            corporateOrgId: orgId,
            userid: res.id
        },
        cache: false,
        success: function(data) {
            var d = $.parseJSON(data);
            if (d.success) {
                var msg = d.msg;
                tip(msg);
                $('#' + datagridId2).datagrid('reload');
            }
        }
    });
}

/**
 * 删除操作员
 * 
 * @param index
 * @returns
 */
function delOperator(index) {
    $('#' + datagridId2).datagrid('selectRow', index);
    var row = $('#' + datagridId2).datagrid('getSelected');
    delObj('corporateOrg/operator.do?del&id=' + row.id, datagridId2);
}

/**
 * 调动操作员
 * 
 * @param obj
 * @param index
 * @returns
 */
function depOperator(obj, index) {
    $('#' + datagridId2).datagrid('selectRow', index);
    var row = $('#' + datagridId2).datagrid('getSelected');
    
    var selectObj = $(obj).prev().val();
    
    if(selectObj == '-1'){
        alert('请选择要调动的支行!');
        return false;
    }
    
    var selectedIndex = index;
    createDialogWithCallback('确认', '确认调动', 'corporateOrg/operator.do?dep', {
        id: row.id,
        orgId: selectObj
      }, function() {
          reloadTable();
      });
}