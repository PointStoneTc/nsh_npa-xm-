var datagridId = "borrowerList";

$(function() {
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
  return '<a href="#" class="ace_button" alt="修改" onclick="edit(' + index + ')" style="background-color:#63c91a;"><i class="fa fa-pencil"></i>修改</a>';
}

/**
 * 修改
 * 
 * @returns
 */
function edit(index) {
  $('#' + datagridId).datagrid('selectRow', index);
  $('#' + datagridId).datagrid('getSelected');
  update('借款人修改', 'naturalPerson/borrower.do?toUpdateDetail', datagridId, 350, 300);
}

/**
 * 查询
 * 
 * @returns
 */
function doQuery() {
  $('#' + datagridId).datagrid('load', {
    name: $('#name').val(),
    idNumber: $('#idNumber').val()
  });
}

/**
 * 清空
 * 
 * @returns
 */
function doClear() {
  $('#name').textbox('clear');
  $('#idNumber').textbox('clear');
}