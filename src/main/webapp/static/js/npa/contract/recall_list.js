var datagridId = "recallList";
var hasBtnSettle = false;

$(function() {
  $.ajax({
    url: '../autority/btn.do?settle',
    dataType: 'json',
    type: 'post',
    async: false,
    success: function(data) {
      hasBtnSettle = data.success;
    },
    error: function(data) {
    }
  });
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
  var res = '<a href="#" class="ace_button" alt="还款登记" onclick="addRecall(' + index + ')" style="background-color:#63c91a;"><i class="fa fa-list"></i>还款登记</a> '
      + '<a href="#" class="ace_button" alt="查看登记明细" onclick="listRem(' + index + ')" style="background-color:#f5270f;"><i class="fa fa-trash-o"></i>查看登记明细</a> ';

  if (hasBtnSettle) {
    res += '<a href="#" class="ace_button" alt="结清" onclick="endCommit(' + index + ')" style="background-color:#1a7bb9;"><i class="fa fa-handshake-o"></i>结清</a> ';
    res += '<a href="#" class="ace_button" alt="删除(请慎用)" onclick="deleteTemp(' + index + ')" style="background-color:#ff0000;"><i class="fa fa-flash"></i>删除(请慎用)</a>';
  }
  return res;
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
  if (Math.abs(sybj.toFixed(2)) == 0) {
    tip("欠款已完全收回!");
    return false;
  }
  openwindow('收回款登记', 'loancontract/recall.do?toAdd&id=' + row.id + '&selectRowIndex=' + index, datagridId, 1600, 700);
}

/**
 * 查看还款登记
 * 
 * @returns
 */
function listRem(index) {
  $('#' + datagridId).datagrid('selectRow', index);
  var row = $('#' + datagridId).datagrid('getSelected');
  console.info(row);
  createWindowWithCallBack('查看还款登记', 'recoveryMoney.do?list1&id=' + row.id + '&index=' + index, 1000, 500);
}

/**
 * 更新收回款初始化回调函数
 * 
 * @param index
 * @param recoveryPrincipal
 * @param recoveryInterest
 * @param hangInteres
 * @param interestDate
 * @returns
 */
function initRecoveryMoneyCallBack(index, recoveryPrincipal, recoveryInterest, hangInteres, interestDate) {
  console.info(index);
  var row = $('#' + datagridId).datagrid('getSelected');
  $('#' + datagridId).datagrid('updateRow', {
    index: parseInt(index),
    row: {
      recoveryPrincipal: recoveryPrincipal,
      recoveryInterest: recoveryInterest,
      hangInteres: hangInteres,
      interestDate: interestDate
    }
  });
}

/**
 * 结清
 * 
 * @returns
 */
function endCommit(index) {
  $('#' + datagridId).datagrid('selectRow', index);
  var row = $('#' + datagridId).datagrid('getSelected');
  createDialogWithCallback('确认', '确认结清合同', 'register.do?endCommit', {
    id: row.id
  }, function() {
    reloadTable();
  });
}

/**
 * 临时删除
 * 
 * @returns
 */
function deleteTemp(index) {
  $('#' + datagridId).datagrid('selectRow', index);
  var row = $('#' + datagridId).datagrid('getSelected');
  createDialogWithCallback('确认', '相关借款人,担保人,和回款明细都会级联删除,确认删除合同?', 'recall.do?deleteTemp', {
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

/**
 * 保存文件
 * 
 * @returns
 */
function exportAll() {
  if ('' == $('#startDate').val()) {
    alert('请选择开始时间!');
    return false;
  }

  if ('' != $('#endDate').val()) {
    // 2把字符串格式转换为日期类
    var startTime = new Date(Date.parse($('#startDate').val()));
    var endTime = new Date(Date.parse($('#endDate').val()));
    // 3进行比较
    if (startTime >= endTime) {
      alert('结束时间不能小于开始时间!');
      return false;
    }
  }

  var url = 'export.do?recovery';
  var form = $('<form></form>').attr('action', url).attr('method', 'post');
  form.append($('<input></input>').attr('type', 'hidden').attr('name', 'start').attr('value', $('#startDate').val()));
  form.append($('<input></input>').attr('type', 'hidden').attr('name', 'end').attr('value', $('#endDate').val()));
  form.appendTo('body').submit().remove();
}
