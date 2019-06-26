var datagridId = "personList";

$(function() {
});

function getAllBasic() {
  var row = $('#personList').datagrid('getSelected');
  if (row == null) return '';
  return row;
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