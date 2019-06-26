var datagridId = "recallList";

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
  return '<a href="#" class="ace_button" alt="还款登记" onclick="addRecall(' + index + ')" style="background-color:#63c91a;"><i class="fa fa-list"></i>还款登记</a> '
          + '<a href="#" class="ace_button" alt="结束" onclick="endCommit(' + index + ')" style="background-color:#1a7bb9;"><i class="fa fa-handshake-o"></i>结束</a> '
          + '<a href="#" class="ace_button" alt="终止" onclick="termCommit(' + index + ')" style="background-color:#f5270f;"><i class="fa fa-ban"></i>终止</a>';
}

/**
 * 还款登记
 * 
 * @returns
 */
function addRecall(index) {
  $('#' + datagridId).datagrid('selectRow', index);
  var row = $('#' + datagridId).datagrid('getSelected');
  var sybj = row.amount - row.recoveryPrincipal;
  if (Math.abs(sybj.toFixed(2)) == 0){
    tip("欠款已完全收回!");
    return false;
  }
  openwindow('收回款登记', 'loancontract/recall.do?toAdd&id=' + row.id + '&selectRowIndex=' + index, datagridId, 1600, 700);
}

/**
 * 结束
 * 
 * @returns
 */
function endCommit(index) {
  $('#' + datagridId).datagrid('selectRow', index);
  var row = $('#' + datagridId).datagrid('getSelected');
  createDialogWithCallback('确认', '确认结束合同', 'register.do?endCommit', {
    id: row.id
  }, function() {
    reloadTable();
  });
}

/**
 * 终止
 * 
 * @returns
 */
function termCommit(index) {
  $('#' + datagridId).datagrid('selectRow', index);
  var row = $('#' + datagridId).datagrid('getSelected');
  createDialogWithCallback('确认', '确认终止合同', 'register.do?termCommit', {
    id: row.id
  }, function() {
    reloadTable();
  });
}

/**
 * 详情
 * 
 * @returns
 */
function detailContract() {
  detail('收回款明细详情', 'loancontract/recall.do?toDetail', datagridId, 800, 500);
}

/**
 * 查询
 * 
 * @returns
 */
function doQuery() {
  $('#' + datagridId).datagrid('load', {
    borrowerName: $('#borrowerName').val(),
    idNumber: $('#idNumber').val(),
    numCode: $('#numCode').val()
  });
}

/**
 * 清空
 * 
 * @returns
 */
function doClear() {
  $('#borrowerName').textbox('clear');
  $('#idNumber').textbox('clear');
  $('#numCode').textbox('clear');
}

/**
 * 更新回款信息
 */
function updateRowAmount(recoveryPrincipal, recoveryInterest, hangInterest, interestDate, index) {
  var row = $('#' + datagridId).datagrid('getSelected');
  $('#' + datagridId).datagrid('updateRow', {
    index: parseInt(index),
    row: {
      recoveryPrincipal: recoveryPrincipal,
      recoveryInterest: recoveryInterest,
      hangInteres: hangInterest,
      interestDate: interestDate
    }
  });
}

/**
 * easy-ui渲染剩余金额(自动计算)
 * 
 * @param val
 * @param row
 * @returns
 */
function amountSurplus(val, row) {
  var sybj = row.amount - row.recoveryPrincipal;
  if (Math.abs(sybj.toFixed(2)) == 0) sybj = 0;
  return '<span class="easyui-formatter-money rmb" style="color:#0c0c0c;font-weight: bold">' + formatNull(sybj, row) + '</span>';
}
