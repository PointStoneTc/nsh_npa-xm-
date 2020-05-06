var datagridId = "registerList";

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
  if (rec.isSubmit == '1') {
    if (rec.stat == 'e' || rec.stat == 't') {
      return '<a href="#" class="ace_button" alt="查看回款记录" onclick="recallList(' + index + ')" style="background-color:#9e123e;"><i class="fa fa-eye"></i>查看回款记录</a>';
    } else if (rec.stat = 'n') { return '<a href="#" class="ace_button" alt="收回款期初值设置" onclick="initRecoveryMoney(' + index
        + ')" style="background-color:#2f3c45e6;"><i class="fa fa-balance-scale"></i>收回款期初值设置</a> ' + '<a href="#" class="ace_button" alt="借冒名设置" onclick="impersonate(' + index
        + ')" style="background-color:#e3402d;"><i class="fa fa-frown-o"></i>借冒名设置</a> '; }
  } else {
    return '<a href="#" class="ace_button" alt="修改" onclick="edit(' + index + ')" style="background-color:#63c91a;"><i class="fa fa-pencil"></i>修改</a> '
        + '<a href="#" class="ace_button" alt="提交" onclick="commit(' + index + ')" style="background-color:#1a7bb9;"><i class="fa fa-check"></i>提交</a> '
        + '<a href="#" class="ace_button" alt="删除" onclick="del(' + index + ')" style="background-color:#f5270f;"><i class="fa fa-trash-o"></i>删除</a>';
  }
}

/**
 * 新增
 * 
 * @returns
 */
function addContract() {
  add('借款合同登记', 'loancontract/register.do?toAdd', datagridId, 1000, 600);
}

/**
 * 详情
 * 
 * @returns
 */
function detailContract() {
  detail('借款合同详情', 'loancontract/register.do?toDetail', datagridId, 1000, 600);
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
    numCode: $('#numCode').val(),
    officer: $('#officer').val(),
    stat: $('#stat').val()
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
  $('#officer').textbox('clear');
  $('#stat').val('');
}

/**
 * 修改
 * 
 * @returns
 */
function edit(index) {
  $('#' + datagridId).datagrid('selectRow', index);
  $('#' + datagridId).datagrid('getSelected');
  update('借款合同修改', 'loancontract/register.do?toUpdate', datagridId, 1000, 600);
}

/**
 * 查看回款记录
 * 
 * @param index
 * @returns
 */
function recallList(index) {
  $('#' + datagridId).datagrid('selectRow', index);
  var row = $('#' + datagridId).datagrid('getSelected');
  openwindow('收回款记录', 'recoveryMoney.do?list&id=' + row.id, datagridId, 800, 500);
}

/**
 * 更新收回款初始化
 * 
 * @param index
 * @returns
 */
function initRecoveryMoney(index) {
  $('#' + datagridId).datagrid('selectRow', index);
  var row = $('#' + datagridId).datagrid('getSelected');
  createWindowWithCallBack('更新收回款', 'loancontract/register.do?toInitRecoveryMoney&id=' + row.id + '&index=' + index, 400, 250);
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
 * 设置借冒名
 * 
 * @param index
 * @returns
 */
function impersonate(index) {
  $('#' + datagridId).datagrid('selectRow', index);
  var row = $('#' + datagridId).datagrid('getSelected');
  var selectedIndex = index;
  createDialogWithCallback('确认', '确认修改借款人借冒名为' + (row.isImpersonate == 0 ? '是' : '否'), 'register.do?updateImpersonate', {
    id: row.id,
    isImpersonate: row.isImpersonate == 0 ? 'true' : 'false'
  }, function() {
    $('#' + datagridId).datagrid('updateRow', {
      index: selectedIndex,
      row: {
        isImpersonate: row.isImpersonate == 0 ? 1 : 0
      }
    });
  });
}

/**
 * 提交
 * 
 * @param index
 * @returns
 */
function commit(index) {
  $('#' + datagridId).datagrid('selectRow', index);
  var row = $('#' + datagridId).datagrid('getSelected');
  var selectedIndex = index;
  createDialogWithCallback('确认', '确认提交', 'register.do?commit', {
    id: row.id
  }, function() {
    $('#' + datagridId).datagrid('updateRow', {
      index: selectedIndex,
      row: {
        isSubmit: 1
      }
    });
  });
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
  delObj('register.do?del&id=' + row.id, datagridId);
}

/**
 * 保存文件
 * 
 * @returns
 */
function exportAll() {
  var url = 'export.do?all';
  var form = $('<form></form>').attr('action', url).attr('method', 'post');
  form.appendTo('body').submit().remove();
}