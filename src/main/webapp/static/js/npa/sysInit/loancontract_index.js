var lt_datagrid = 'ltList';
var litigationStat_s = 'n_未诉讼,l_立案,f_一审,s_二审,g_再审,t_调解,e_诉讼终结,i_申请执行,a_执行,b_中止执行,c_终止本次执行,d_执行终结';
var guaranteeMode_s = 'x_信用,b_保证,d_抵押,f_复合';
var disposeMode_s = 'h_核销贷款,t_土地置换,y_央票置换';
var stat_s = 'n_正常,e_结束,p_终止';
var corporateOrgId = 'corporateOrgId';

$(function() {
  $('#' + corporateOrgId).on('change',
  function(e) {
    var selectVal = $(this).find('option:selected').val();
    if (selectVal == '') {
      $('#upload').linkbutton('disable');
      $('#step1_state').hide();
    } else {
      $('#upload').linkbutton('enable');
      $('#step1_state').show();
    }
  });

  validater.eventInit(lt_datagrid, corporateOrgId, litigationStat_s, guaranteeMode_s, disposeMode_s, stat_s);

  $('#' + lt_datagrid).datagrid({
    onBeforeLoad: function(param){
      validater.reset();
      return true;
    },
    
    onLoadSuccess: function(data) {
      validater.main();
    }
  });

});

/**
 * 刷新主表数据
 * 
 * @returns
 */
function reloadTable() {
  $('#' + lt_datagrid).datagrid('reload');
}

/**
 * Excel导入
 * 
 * @returns
 */
function upload() {
  openuploadwin('Excel导入', 'sysInit.do?upload');
}

/**
 * 生成数据
 * 
 * @returns
 */
function createResult() {
  createDialogWithCallback('确认', '确认生成数据', 'loancontract.do?createResult', '',  function(){
    $('#brList').datagrid('reload');
    $('#guList').datagrid('reload');
    $('#idFixList').datagrid('reload');
    $('#insertDataBase').linkbutton('enable');
  });
}


/**
 * 插入到数据库
 * 
 * @returns
 */
function insertDataBase() {
  
}

/**
 * 验证
 * 
 * @returns
 */
function validate() {
  validater.main();
}

/**
 * 效验方法的辅助类
 * 
 * @param lt_datagrid
 * @param errorMsgDomId
 * @returns
 */
function vt_param(lt_datagrid, errorMsgDomId) {
  this.lt_datagrid = lt_datagrid;
  this.errorCount = 0;
  this.errorMsgDomId = errorMsgDomId;
  this.errorRowList = [];

  $('#' + this.errorMsgDomId + ' a').on('click', {
    lt_datagrid: this.lt_datagrid,
    errorRowList: this.errorRowList
  },
  function(event) {
    if (event.data.errorRowList.length == 0) return false;

    $('#' + event.data.lt_datagrid).datagrid('unselectAll');
    for (var i = 0; i < event.data.errorRowList.length; i++) $('#' + event.data.lt_datagrid).datagrid('selectRow', event.data.errorRowList[i]);

    $(this).parent().siblings().find('a').removeClass('selected');
    $(this).addClass('selected');
    $('#' + event.data.lt_datagrid).datagrid('scrollTo', event.data.errorRowList[0]);
  });

  this.showErrorMsg = function() {
    if (this.errorCount == 0) $('#' + this.errorMsgDomId + ' .check_ok').show();
    $('#' + this.errorMsgDomId + ' .error_msg').html(this.errorCount);
  }

  this.addError = function(index) {
    this.errorCount++;
    this.errorRowList.push(index);
    return {
      class: 'error_cell'
    };
  }
  
  this.reset = function(){
    this.errorCount = 0;
    this.errorRowList.splice(0, this.errorRowList.length);
  }
}

var validater = {
  lt_datagrid: '',
  rows: [],
  litigationStatMap: new Map(),
  guaranteeModeMap: new Map(),
  disposeModeMap: new Map(),
  statMap: new Map(),
  /**
   * 初始化方法
   */
  eventInit: function(lt_datagrid, corporateOrgId, litigationStat_s, guaranteeMode_s, disposeMode_s, stat_s) {
    this.lt_datagrid = lt_datagrid;
    
    this.val_numCode.init(lt_datagrid, 'step1');
    this.val_louNo.init(lt_datagrid, 'step2');
    this.val_borrowerName.init(lt_datagrid, 'step3');
    this.val_borrowerNumber.init(lt_datagrid, 'step4');
    this.val_guarantees.init(lt_datagrid, 'step5');
    this.val_amount.init(lt_datagrid, 'step6');
    this.val_issueDate.init(lt_datagrid, 'step7');
    this.val_dueDate.init(lt_datagrid, 'step8');
    this.val_interestRate.init(lt_datagrid, 'step9');
    this.val_officer.init(lt_datagrid, 'step10');
    this.val_interestDate.init(lt_datagrid, 'step15');
    this.val_recoveryPrincipal.init(lt_datagrid, 'step16');

    // 所属支行初始化
    this.val_corporateOrg.init(lt_datagrid, 'step11', corporateOrgId);

    // 诉讼状态初始化
    var litigationStat_split = litigationStat_s.split(',');
    for (var i = 0; i < litigationStat_split.length; i++) {
      var temp = litigationStat_split[i].split('_');
      this.litigationStatMap.put(temp[0], temp[1]);
    }
    this.val_litigationStat.init(lt_datagrid, 'step12', this.litigationStatMap);

    // 担保状态初始化
    var guaranteeMode_split = guaranteeMode_s.split(',');
    for (var i = 0; i < guaranteeMode_split.length; i++) {
      var temp = guaranteeMode_split[i].split('_');
      this.guaranteeModeMap.put(temp[0], temp[1]);
    }
    this.val_guaranteeMode.init(lt_datagrid, 'step13', this.guaranteeModeMap);

    // 处理方式初始化
    var disposeMode_split = disposeMode_s.split(',');
    for (var i = 0; i < disposeMode_split.length; i++) {
      var temp = disposeMode_split[i].split('_');
      this.disposeModeMap.put(temp[0], temp[1]);
    }
    this.val_disposeMode.init(lt_datagrid, 'step14', this.disposeModeMap);

    // 状态初始化
    var stat_split = stat_s.split(',');
    for (var i = 0; i < stat_split.length; i++) {
      var temp = stat_split[i].split('_');
      this.statMap.put(temp[0], temp[1]);
    }
    this.val_stat.init(lt_datagrid, 'step17', this.statMap);
  },

  /**
   * 验证主函数
   */
  main: function() { 
    this.val_numCode.vt.showErrorMsg();
    this.val_louNo.vt.showErrorMsg();
    this.val_borrowerName.vt.showErrorMsg();
    this.val_borrowerNumber.vt.showErrorMsg();
    this.val_guarantees.vt.showErrorMsg();
    this.val_amount.vt.showErrorMsg();
    this.val_issueDate.vt.showErrorMsg();
    this.val_dueDate.vt.showErrorMsg();
    this.val_interestRate.vt.showErrorMsg();
    this.val_officer.vt.showErrorMsg();
    this.val_corporateOrg.vt.showErrorMsg();
    this.val_litigationStat.vt.showErrorMsg();
    this.val_guaranteeMode.vt.showErrorMsg();
    this.val_disposeMode.vt.showErrorMsg();
    this.val_interestDate.vt.showErrorMsg();
    this.val_recoveryPrincipal.vt.showErrorMsg();
    this.val_stat.vt.showErrorMsg();

    var allCount = 0;
    allCount += this.val_numCode.vt.errorCount;
    allCount += this.val_louNo.vt.errorCount;
    allCount += this.val_borrowerName.vt.errorCount;
    allCount += this.val_borrowerNumber.vt.errorCount;
    allCount += this.val_guarantees.vt.errorCount;
    allCount += this.val_amount.vt.errorCount;
    allCount += this.val_issueDate.vt.errorCount;
    allCount += this.val_dueDate.vt.errorCount;
    allCount += this.val_interestRate.vt.errorCount;
    allCount += this.val_officer.vt.errorCount;
    allCount += this.val_corporateOrg.vt.errorCount;
    allCount += this.val_litigationStat.vt.errorCount;
    allCount += this.val_guaranteeMode.vt.errorCount;
    allCount += this.val_disposeMode.vt.errorCount;
    allCount += this.val_interestDate.vt.errorCount;
    allCount += this.val_recoveryPrincipal.vt.errorCount;
    allCount += this.val_stat.vt.errorCount;

    this.rows.splice(0, this.rows.length);
    this.rows = $('#' + lt_datagrid).datagrid('getRows');

    if (allCount == 0 && this.rows.length > 0) {
      // 并且有数据
      $('#createResult').linkbutton('enable');
    }
  },
  
  /**
   * 清除历史验证结果
   */
  reset: function(){
    this.val_numCode.reset();
    this.val_louNo.reset();
    this.val_borrowerName.reset();
    this.val_borrowerNumber.reset();
    this.val_guarantees.reset();
    this.val_amount.reset();
    this.val_issueDate.reset();
    this.val_dueDate.reset();
    this.val_interestRate.reset();
    this.val_officer.reset();
    this.val_corporateOrg.reset();
    this.val_litigationStat.reset();
    this.val_guaranteeMode.reset();
    this.val_disposeMode.reset();
    this.val_interestDate.reset();
    this.val_recoveryPrincipal.reset();
    this.val_stat.reset();
    $('#createResult').linkbutton('disable');
    $('#insertDataBase').linkbutton('disable');
  },

  /**
   * 档案编号效验
   */
  val_numCode: {
    vt: '',
    init: function(lt_datagrid, errorMsgDomId) {
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function() {},
    formatter: function(val, row) {
      if ('' == val) return '不可为空';
      if (row.numCodeCountSelf > 1) return val + '(有重复值)';
      if ('' != row.realNumCode) return val + '(编号已存在)';
      else return val;
    },
    cellStyler: function(value, row, index) {
      if ('' == value || row.numCodeCountSelf > 1 || '' != row.realNumCode) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 借据号效验
   */
  val_louNo: {
    vt: '',
    init: function(lt_datagrid, errorMsgDomId) {
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function() {},
    formatter: function(val, row) {
      if (row.louNoCountSelf > 1) return val + '(有重复值)';
      else return val;
    },
    cellStyler: function(value, row, index) {
      if (row.louNoCountSelf > 1) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 借款人姓名效验
   */
  val_borrowerName: {
    vt: '',
    init: function(lt_datagrid, errorMsgDomId) {
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function() {},
    formatter: function(val, row) {
      if ('' == val) return '不可为空';
      else return val;
    },
    cellStyler: function(value, row, index) {
      if ('' == value) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 借款人身份证号码效验
   */
  val_borrowerNumber: {
    vt: '',
    init: function(lt_datagrid, errorMsgDomId) {
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function() {},
    formatter: function(val, row) {
      if ('' == val) return '不可为空';
      else if (!validateIdNumber(val)) return val + '(格式非法)';
      else return val;
    },
    cellStyler: function(value, row, index) {
      if ('' == value || !validateIdNumber(value)) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 担保人效验
   */
  val_guarantees: {
    vt: '',
    init: function(lt_datagrid, errorMsgDomId) {
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function() {},
    formatter: function(val, row) {
      if (val != '') {
        if (val.indexOf(';') == val.length - 1) return val + '(最后一个字符不能是;)';
        var temp = val.split(';');
        var reg = /^[\u4e00-\u9fa5]{2,5},.{15,18}$/;
        for (var i = 0; i < temp.length; i++) {
          if (reg.test(temp[i]) === false) return val + '(姓名或身份证数字错误)';
          var ct = temp[i].split(',');
          if (isCardNo(ct[1]) == false) return val + '(身份证错误)';
        }
      }
      return val;
    },
    cellStyler: function(value, row, index) {
      var hasError = false;
      if (value != '') {
        if (value.indexOf(';') == value.length - 1) hasError = true;
        var temp = value.split(';');
        var reg = /^[\u4e00-\u9fa5]{2,5},.{15,18}$/;
        for (var i = 0; i < temp.length; i++) {
          if (reg.test(temp[i]) === false) {
            hasError = true;
            break;
          }
          var ct = temp[i].split(',');
          if (isCardNo(ct[1]) == false) {
            hasError = true;
            break;
          }
        }
      }
      if (hasError) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 贷款金额效验
   */
  val_amount: {
    vt: '',
    init: function(lt_datagrid, errorMsgDomId) {
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function() {},
    formatter: function(val, row) {
      if ('' == val) return '不可为空';
      else if (isNaN(val)) return val + '(非数字格式)';
      else return '<span class="easyui-formatter-money rmb">' + val + '</span>';
    },
    cellStyler: function(value, row, index) {
      if ('' == value || isNaN(value)) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 贷款发放日效验
   */
  val_issueDate: {
    vt: '',
    init: function(lt_datagrid, errorMsgDomId) {
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function() {},
    formatter: function(val, row) {
      if ('' == val) return '不可为空';
      else return val;
    },
    cellStyler: function(value, row, index) {
      if ('' == value) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 贷款到期日效验
   */
  val_dueDate: {
    vt: '',
    init: function(lt_datagrid, errorMsgDomId) {
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function() {},
    formatter: function(val, row) {
      if ('' == row.issueDate) {
        return val + '(无法比较发放日)';
      } else {
        if ('' == row.dueDate) return '不可为空';
        else if (dateCompare(row.issueDate, row.dueDate)) return val + '(小于或等于发放日)';
        else return val;
      }
    },
    cellStyler: function(value, row, index) {
      if ('' == row.issueDate || '' == value || ('' != row.issueDate && '' != value && dateCompare(row.issueDate, row.dueDate))) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 利率效验
   */
  val_interestRate: {
    vt: '',
    init: function(lt_datagrid, errorMsgDomId) {
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function() {},
    formatter: function(val, row) {
      if ('' == val) return '不可为空';
      else if (isNaN(val)) return val + '(非数字格式)';
      else return val;
    },
    cellStyler: function(value, row, index) {
      if ('' == value || isNaN(value)) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 信贷员效验
   */
  val_officer: {
    vt: '',
    init: function(lt_datagrid, errorMsgDomId) {
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function() {},
    formatter: function(val, row) {
      return '' != val ? val: val + '不可为空';
    },
    cellStyler: function(value, row, index) {
      if ('' == value) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 所属支行效验
   */
  val_corporateOrg: {
    vt: '',
    orgNameDomId: '',
    init: function(lt_datagrid, errorMsgDomId, orgNameDomId_s) {
      this.orgNameDomId_s = orgNameDomId_s;
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function() {},
    formatter: function(val, row) {
      if ('' == val) return '不可为空';
      else if ($('#' + this.orgNameDomId_s).find("option:selected").text() != val) return val + '(与所选支行不同)';
      else return val;
    },
    cellStyler: function(value, row, index) {
      if ('' == value || $('#' + this.orgNameDomId_s).find("option:selected").text() != value) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 诉讼状态校验
   */
  val_litigationStat: {
    vt: '',
    map: new Map(),
    init: function(lt_datagrid, errorMsgDomId, map_s) {
      this.map = map_s;
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function(map, lt_datagrid) {},
    formatter: function(val, row) {
      if ('' == val) return '不可为空';
      else if (this.map.containsKey(val)) return this.map.get(val);
      else return val + '(非法值)';
    },
    cellStyler: function(value, row, index) {
      if (value == '' || !this.map.containsKey(value)) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 担保方式校验
   */
  val_guaranteeMode: {
    vt: '',
    map: new Map(),
    init: function(lt_datagrid, errorMsgDomId, map_s) {
      this.map = map_s;
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function(map, lt_datagrid) {},
    formatter: function(val, row) {
      if ('' == val) return '不可为空';
      else if (this.map.containsKey(val)) return this.map.get(val);
      else return val + '(非法值)';
    },
    cellStyler: function(value, row, index) {
      if ('' == value || !this.map.containsKey(value)) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 处理方式校验
   */
  val_disposeMode: {
    vt: '',
    map: new Map(),
    init: function(lt_datagrid, errorMsgDomId, map_s) {
      this.map = map_s;
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function(map, lt_datagrid) {},
    formatter: function(val, row) {
      if ('' == val) return '不可为空';
      else if (this.map.containsKey(val)) return this.map.get(val);
      else return val + '(非法值)';
    },
    cellStyler: function(value, row, index) {
      if ('' == value || !this.map.containsKey(value)) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 起息日校验
   */
  val_interestDate: {
    vt: '',
    init: function(lt_datagrid, errorMsgDomId) {
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function(lt_datagrid) {},
    formatter: function(val, row) {
      if ('' == row.issueDate) {
        return val + '(无法比较发放日)';
      } else {
        if ('' != row.interestDate && dateCompare(row.issueDate, row.interestDate)) return val + '(小于或等于发放日)';
        else return val;
      }
    },
    cellStyler: function(value, row, index) {
      if (('' == row.issueDate && '' != value) || ('' != row.issueDate && '' != value && dateCompare(row.issueDate, row.interestDate))) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 收回本金校验
   */
  val_recoveryPrincipal: {
    vt: '',
    init: function(lt_datagrid, errorMsgDomId) {
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function(lt_datagrid) {},
    formatter: function(val, row) {
      if (isNaN(val)) return val + '(非数字格式)';
      if ('' == row.amount && '' != val) {
        return val + '(无法比较贷款金额)';
      }
      if ('' != row.amount && (parseFloat(row.amount) < parseFloat(val))) return val + '(大于贷款金额)';
      return '<span class="easyui-formatter-money rmb">' + val + '</span>';
    },
    cellStyler: function(value, row, index) {
      if (('' == row.amount && '' != value) || ('' != row.amount && '' != value && (parseFloat(row.amount) < parseFloat(value)))) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

  /**
   * 状态校验
   */
  val_stat: {
    vt: '',
    map: new Map(),
    init: function(lt_datagrid, errorMsgDomId, map_s) {
      this.map = map_s;
      this.vt = new vt_param(lt_datagrid, errorMsgDomId);
    },
    valid: function(map, lt_datagrid) {},
    formatter: function(val, row) {
      if ('' == val) return '不可为空';
      else if (this.map.containsKey(val)) return this.map.get(val);
      else return val + '(非法值)';
    },
    cellStyler: function(value, row, index) {
      if (value == '' || !this.map.containsKey(value)) return this.vt.addError(index);
    },
    reset: function(){
      this.vt.reset();
    }
  },

};


/**
 * 档案编号格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_nc(val, row) {
  return validater.val_numCode.formatter(val, row);
}

/**
 * 档案编号渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_nc(value, row, index) {
  return validater.val_numCode.cellStyler(value, row, index);
}

/**
 * 借据号格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_ln(val, row) {
  return validater.val_louNo.formatter(val, row);
}

/**
 * 借据号渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_ln(value, row, index) {
  return validater.val_louNo.cellStyler(value, row, index);
}

/**
 * 借款人姓名格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_bn(val, row) {
  return validater.val_borrowerName.formatter(val, row);
}

/**
 * 借款人姓名渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_bn(value, row, index) {
  return validater.val_borrowerName.cellStyler(value, row, index);
}

/**
 * 贷款人身份证号格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_bnr(val, row) {
  return validater.val_borrowerNumber.formatter(val, row);
}

/**
 * 贷款人身份证号渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_bnr(value, row, index) {
  return validater.val_borrowerNumber.cellStyler(value, row, index);
}

/**
 * 担保人格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_gs(val, row) {
  return validater.val_guarantees.formatter(val, row);
}

/**
 * 担保人渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_gs(value, row, index) {
  return validater.val_guarantees.cellStyler(value, row, index);
}

/**
 * 贷款金额格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_at(val, row) {
  return validater.val_amount.formatter(val, row);
}

/**
 * 贷款金额渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_at(value, row, index) {
  return validater.val_amount.cellStyler(value, row, index);
}

/**
 * 贷款发放日格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_id(val, row) {
  return validater.val_issueDate.formatter(val, row);
}

/**
 * 贷款发放日渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_id(value, row, index) {
  return validater.val_issueDate.cellStyler(value, row, index);
}

/**
 * 贷款到期日格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_dd(val, row) {
  return validater.val_dueDate.formatter(val, row);
}

/**
 * 贷款到期日渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_dd(value, row, index) {
  return validater.val_dueDate.cellStyler(value, row, index);
}

/**
 * 利率格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_ir(val, row) {
  return validater.val_interestRate.formatter(val, row);
}

/**
 * 利率渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_ir(value, row, index) {
  return validater.val_interestRate.cellStyler(value, row, index);
}

/**
 * 信贷员格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_of(val, row) {
  return validater.val_officer.formatter(val, row);
}

/**
 * 信贷员渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_of(value, row, index) {
  return validater.val_officer.cellStyler(value, row, index);
}

/**
 * 所属支行格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_on(val, row) {
  return validater.val_corporateOrg.formatter(val, row);
}

/**
 * 所属支行渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_on(value, row, index) {
  return validater.val_corporateOrg.cellStyler(value, row, index);
}

/**
 * 诉讼状态格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_ls(val, row) {
  return validater.val_litigationStat.formatter(val, row);
}

/**
 * 诉讼状态渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_ls(value, row, index) {
  return validater.val_litigationStat.cellStyler(value, row, index);
}

/**
 * 担保方式格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_gm(val, row) {
  return validater.val_guaranteeMode.formatter(val, row);
}

/**
 * 担保方式渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_gm(value, row, index) {
  return validater.val_guaranteeMode.cellStyler(value, row, index);
}

/**
 * 处理方式格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_dm(val, row) {
  return validater.val_disposeMode.formatter(val, row);
}

/**
 * 处理方式渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_dm(value, row, index) {
  return validater.val_disposeMode.cellStyler(value, row, index);
}

/**
 * 起息日格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_ind(val, row) {
  return validater.val_interestDate.formatter(val, row);
}

/**
 * 起息日渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_ind(value, row, index) {
  return validater.val_interestDate.cellStyler(value, row, index);
}

/**
 * 收回本金格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_rp(val, row) {
  return validater.val_recoveryPrincipal.formatter(val, row);
}

/**
 * 收回本金渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_rp(value, row, index) {
  return validater.val_recoveryPrincipal.cellStyler(value, row, index);
}

/**
 * 状态格式化
 * 
 * @param val
 * @param row
 * @returns
 */
function fmt_st(val, row) {
  return validater.val_stat.formatter(val, row);
}

/**
 * 状态渲染
 * 
 * @param value
 * @param row
 * @param index
 * @returns
 */
function cs_st(value, row, index) {
  return validater.val_stat.cellStyler(value, row, index);
}

/**
 * 比较两个日期的大小，如果beginDate > endDate，返回true，否则返回false
 * 
 * @param beginDate
 * @param endDate
 * @returns
 */
function dateCompare(beginDate, endDate) {
  var d1 = new Date(beginDate.replace(/\-/g, "\/"));
  var d2 = new Date(endDate.replace(/\-/g, "\/"));

  return d1 >= d2;
}

/**
 * easy-ui渲染是否
 * 
 * @param val
 * @param row
 * @returns
 */
function formatExisting(val, row) {
  if (row.isFooter) { // 判断出是否footer
    return val;
  }

  var res = '';
  if (val == 0)
    res = '是';
  else if (val == '1') res = '否';

  return '<span>' + res + '</span>';
}