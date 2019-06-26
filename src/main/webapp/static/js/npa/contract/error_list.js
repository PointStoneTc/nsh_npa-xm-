var datagridId = "errorList";

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
 * 查询
 * 
 * @returns
 */
function doQuery() {
  $('#' + datagridId).datagrid('load', {
    borrowerName: $('#borrowerName').val(),
    errorType: $('#errorType').val()
  });
}

/**
 * 清空
 * 
 * @returns
 */
function doClear() {
  $('#borrowerName').textbox('clear');
  $('#errorType').val('');
}

/**
 * 修改借款人
 * 
 * @returns
 */
function updateBorrower() {
  var rows = $('#' + datagridId).datagrid('getSelections');
  // 判断是否选择了数据
  if (rows.length == 0) {
    alert('请选择数据!');
    return false;
  }

  // 不允许选择名字不同的用户
  if (rows.length > 1) {
    var borrowerName;
    var hasRepetitive = false;
    $.each(rows, function(i, n) {
      if (i == 0)
        borrowerName = n.borrowerName;
      else {
        if (n.borrowerName != '' && n.borrowerName != borrowerName) {
          hasRepetitive = true;
          return false;
        }
      }
    });

    if (hasRepetitive) {
      alert('不允许选择借款人名字不同的数据!');
      return false;
    }
  }

  var ids = '';
  var name = '';
  var idNumber = '';
  var indexs = '';
  $.each(rows, function(i, n) {
    ids += n.id + ',';
    name = n.borrowerName;
    idNumber = n.idNumber;
    indexs += $('#' + datagridId).datagrid('getRowIndex', n) + ',';
  });

  ids = ids.substring(0, ids.length - 1);
  indexs = indexs.substring(0, indexs.length - 1);

  createWindowWithCallBack('更新借款人', 'loancontract/error.do?toUpdateBorrower&ids=' + ids + '&name=' + name + '&idNumber=' + idNumber + '&indexs=' + indexs, 400, 150);
}

/**
 * 修改借款人回调函数
 * 
 * @param indexs
 * @param idNumber
 * @returns
 */
function updateBorrowerCallBack(indexs, idNumber) {

  $.each(indexs.split(","), function(i, n) {
    $('#' + datagridId).datagrid('updateRow', {
      index: parseInt(n),
      row: {
        idNumber: idNumber
      }
    });
  });
}

/**
 * 修改发放日、到期日
 * 
 * @returns
 */
function updateIssueDueDate() {
  var rows = $('#' + datagridId).datagrid('getSelections');
  // 判断是否选择了数据
  if (rows.length == 0) {
    alert('请选择数据!');
    return false;
  }

  // 不允许选择多条数据
  if (rows.length > 1) {
    alert('不允许选择多条数据!');
    return false;
  }

  var id = '';
  var issueDate = '';
  var dueDate = '';
  var indexs = '';

  id = rows[0].id;
  issueDate = rows[0].issueDate;
  dueDate = rows[0].dueDate;
  index = $('#' + datagridId).datagrid('getRowIndex', rows[0]);

  createWindowWithCallBack('更新贷款发放日、到期日', 'loancontract/error.do?toUpdateIssueDueDate&ids=' + id + '&issueDate=' + issueDate + '&dueDate=' + dueDate + '&index=' + index, 400, 150);
}

/**
 * 修改修改发放日、到期日回调函数
 * 
 * @param index
 * @param issueDate
 * @param dueDate
 * @returns
 */
function updateIssueDueDateCallBack(index, issueDate, dueDate) {
  $('#' + datagridId).datagrid('updateRow', {
    index: parseInt(index),
    row: {
      issueDate: issueDate,
      dueDate: dueDate
    }
  });
}

/**
 * 提交
 * 
 * @returns
 */
function commit() {
  var rows = $('#' + datagridId).datagrid('getSelections');
  // 判断是否选择了数据
  if (rows.length == 0) {
    alert('请选择数据!');
    return false;
  }

  var ids = '';
  var indexs = '';
  var hasError = false;
  $.each(rows, function(i, n) {
    if (n.idNumber == '' || n.issueDate == '' || n.dueDate == '' || getDaysByDateString(new Date(n.dueDate), new Date(n.issueDate), false) > 0) {
      hasError = true;
      return false;
    }
    ids += n.id + ',';
    indexs += $('#' + datagridId).datagrid('getRowIndex', n) + ',';
  });

  ids = ids.substring(0, ids.length - 1);
  indexs = indexs.substring(0, indexs.length - 1);

  if (hasError) {
    alert('错误数据,不能提交(请检查身份证号,贷款发放日、到期日是否为空和逻辑性)!');
    return false;
  }

  createDialogWithCallback('确认', '确认提交', 'error.do?commit', {
    ids: ids,
    indexs: indexs
  }, function() {
    reloadTable();
  });
}