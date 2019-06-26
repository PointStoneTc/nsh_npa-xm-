var vcity = {
  11: "北京",
  12: "天津",
  13: "河北",
  14: "山西",
  15: "内蒙古",
  21: "辽宁",
  22: "吉林",
  23: "黑龙江",
  31: "上海",
  32: "江苏",
  33: "浙江",
  34: "安徽",
  35: "福建",
  36: "江西",
  37: "山东",
  41: "河南",
  42: "湖北",
  43: "湖南",
  44: "广东",
  45: "广西",
  46: "海南",
  50: "重庆",
  51: "四川",
  52: "贵州",
  53: "云南",
  54: "西藏",
  61: "陕西",
  62: "甘肃",
  63: "青海",
  64: "宁夏",
  65: "新疆",
  71: "台湾",
  81: "香港",
  82: "澳门",
  91: "国外"
};

/**
 * 渲染普通表单或者内容中的性别
 * 
 * @returns
 */
function rendering_sex() {
  $.each($('.sex'), function(i, n) {
    var text = $(n).text();
    if (text == 'm')
      $(n).text('男');
    else
      $(n).text('女');
  });
}

/**
 * 渲染普通表单或者内容中的是非
 * 
 * @returns
 */
function rendering_rw() {
  $.each($('.rw'), function(i, n) {
    var text = $(n).text();
    if (text == '1')
      $(n).text('是');
    else
      $(n).text('否');
  });
}

/**
 * easy-ui渲染货币
 * 
 * @param val
 * @param row
 * @returns
 */
function formatMoney(val, row) {
  if (row.isFooter) { // 判断出是否footer
    return val;
  }

  if (isNaN(val)) return 'NaN';

  var res = '-';
  if (parseFloat(val) != 0) res = formatNull(Math.abs(val), row);

  return '<span class="easyui-formatter-money rmb">' + res + '</span>';
}

/**
 * easy-ui渲染性别
 * 
 * @param val
 * @param row
 * @returns
 */
function formatSex(val, row) {
  if (row.isFooter) { // 判断出是否footer
    return val;
  }

  var res = '';
  if (val == 'm')
    res = '男';
  else if (val == 'f') res = '女';

  return '<span>' + res + '</span>';
}

/**
 * easy-ui渲染是否
 * 
 * @param val
 * @param row
 * @returns
 */
function formatRw(val, row) {
  if (row.isFooter) { // 判断出是否footer
    return val;
  }

  var res = '';
  if (val == 0)
    res = '否';
  else if (val == '1') res = '是';

  return '<span>' + res + '</span>';
}

/**
 * easy-ui渲染诉讼状态
 * 
 * @param val
 * @param row
 * @returns
 */
function formatLitigationStat(val, row) {
  if (row.isFooter) { // 判断出是否footer
    return val;
  }

  return '<span>' + lgst(val) + '</span>';
}

function lgst(val) {
  if (val == 'n')
    return '未诉讼';
  else if (val == 'l')
    return '立案';
  else if (val == 'f')
    return '一审';
  else if (val == 's')
    return '二审';
  else if (val == 'g')
    return '再审';
  else if (val == 't')
    return '调解';
  else if (val == 'e')
    return '诉讼终结';
  else if (val == 'i')
    return '申请执行';
  else if (val == 'a')
    return '执行';
  else if (val == 'b')
    return '中止执行';
  else if (val == 'c')
    return '终止本次执行';
  else if (val == 'd')
    return '执行终结';
  else
    return '';
}

/**
 * easy-ui渲染收回方式
 * 
 * @param val
 * @param row
 * @returns
 */
function formatRecoveryMode(val, row) {
  if (row.isFooter) { // 判断出是否footer
    return val;
  }

  return '<span>' + shfs(val) + '</span>';
}

function shfs(val) {
  if (val == 'c')
    return '现金收回';
  else if (val == 'f')
    return '法院扣划';
  else
    return '';
}

/**
 * easy-ui渲染不良形成日期
 * 
 * @param val
 * @param row
 * @returns
 */
function formatUnhealthyDate(val, row) {
  if (row.isFooter) { // 判断出是否footer
    return val;
  }

  var d1 = new Date(row.dueDate)
  var d2 = new Date(row.dueDate);
  d2.setDate(d1.getDate() + 30);
  return '<span>' + d2.format1('yyyy-MM-dd') + '</span>';
}

/**
 * easy-ui渲染合同担保方式
 * 
 * @param val
 * @param row
 * @returns
 */
function formatCtguaranteeMode(val, row) {
  if (row.isFooter) { // 判断出是否footer
    return val;
  }

  return '<span>' + dbfs(val) + '</span>';
}

function dbfs(val) {
  if (val == 'x')
    return '信用';
  else if (val == 'b')
    return '保证';
  else if (val == 'd')
    return '抵押';
  else if (val = 'f')
    return '复合';
  else
    return '';
}

/**
 * easy-ui渲染合同状态
 * 
 * @param val
 * @param row
 * @returns
 */
function formatCtdisposeMode(val, row) {
  if (row.isFooter) { // 判断出是否footer
    return val;
  }

  return '<span>' + clfs(val) + '</span>';
}

function clfs(val) {
  if (val == 'h')
    return '核销贷款';
  else if (val == 't')
    return '土地置换';
  else if (val == 'y')
    return '央票置换';
  else
    return '';
}

/**
 * easy-ui渲染合同状态
 * 
 * @param val
 * @param row
 * @returns
 */
function formatCtstat(val, row) {
  if (row.isFooter) { // 判断出是否footer
    return val;
  }

  var res = '';
  if (val == 'n')
    res = '正常';
  else if (val == 'e')
    res = '结束';
  else if (val == 't') res = '终止';

  return '<span>' + res + '</span>';
}

/**
 * easy-ui渲染时间
 * 
 * @param val
 * @param row
 * @returns
 */
function formatDate(val, row) {
  if (row.isFooter) { // 判断出是否footer
    return val;
  }

  var d = new Date(val);
  return '<span>' + d.format1('yyyy-MM-dd') + '</span>';
}

/**
 * easy-ui渲染担保人
 * 
 * @param val
 * @param row
 * @returns
 */
function formatGuarantee(val, row) {
  if (row.isFooter) { // 判断出是否footer
    return val;
  }

  var guarantees = row.loanContractGuarantees;
  var res = '';
  $.each(guarantees, function(i, n) {
    res += ''
  });

  return res;
}

/**
 * 身份证15位编码规则：dddddd yymmdd xx p dddddd：6位地区编码 yymmdd: 出生年(两位年)月日，如：910215 xx:
 * 顺序编码，系统产生，无法确定 p: 性别，奇数为男，偶数为女 身份证18位编码规则：dddddd yyyymmdd xxx y dddddd：6位地区编码
 * yyyymmdd: 出生年(四位年)月日，如：19910215 xxx：顺序编码，系统产生，无法确定，奇数为男，偶数为女 y:
 * 校验码，该位数值可通过前17位计算获得 前17位号码加权因子为 Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9,
 * 10, 5, 8, 4, 2 ] 验证位 Y = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ]
 * 如果验证码恰好是10，为了保证身份证是十八位，那么第十八位将用X来代替 校验位计算公式：Y_P = mod( ∑(Ai×Wi),11 )
 * i为身份证号码1...17 位; Y_P为校验码Y所在校验码数组位置
 * 
 * @param idCard
 * @returns
 */
function validateIdNumber(idCard) {
  // 校验长度，类型
  if (isCardNo(idCard) === false) return false;
  // 检查省份
  if (checkProvince(idCard) === false) return false;
  // 校验生日
  if (checkBirthday(idCard) === false) return false;
  // 检验位的检测
  if (checkParity(idCard) === false) return false;
  return true;
}

/**
 * 身份证号码格式验证
 */
isCardNo = function(card) {
  // 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
  var reg = /^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[X])$)$/;
  if (reg.test(card) === false) return false;
  return true;
};

/**
 * 取身份证前两位,校验省份
 */
checkProvince = function(card) {
  var province = card.substr(0, 2);
  if (vcity[province] == undefined) return false;
  return true;
};

/**
 * 检查生日是否正确
 */
checkBirthday = function(card) {
  var len = card.length;
  // 身份证15位时，次序为省（3位）市（3位）年（2位）月（2位）日（2位）校验位（3位），皆为数字
  if (len == '15') {
    var re_fifteen = /^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/;
    var arr_data = card.match(re_fifteen);
    var year = arr_data[2];
    var month = arr_data[3];
    var day = arr_data[4];
    var birthday = new Date('19' + year + '/' + month + '/' + day);
    return verifyBirthday('19' + year, month, day, birthday);
  }
  // 身份证18位时，次序为省（3位）市（3位）年（4位）月（2位）日（2位）校验位（4位），校验位末尾可能为X
  if (len == '18') {
    var re_eighteen = /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|[X])$/;
    var arr_data = card.match(re_eighteen);
    var year = arr_data[2];
    var month = arr_data[3];
    var day = arr_data[4];
    var birthday = new Date(year + '/' + month + '/' + day);
    return verifyBirthday(year, month, day, birthday);
  }
  return false;
};

/**
 * 校验日期
 */
verifyBirthday = function(year, month, day, birthday) {
  var now = new Date();
  var now_year = now.getFullYear();
  // 年月日是否合理
  if (birthday.getFullYear() == year && (birthday.getMonth() + 1) == month && birthday.getDate() == day) {
    // 判断年份的范围（3岁到100岁之间)
    var time = now_year - year;
    if (time >= 3 && time <= 100) { return true; }
    return false;
  }
  return false;
}

/**
 * 校验位的检测
 */
checkParity = function(card) {
  // 15位转18位
  card = changeFivteenToEighteen(card);
  var len = card.length;
  if (len == '18') {
    var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);
    var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
    var cardTemp = 0, i, valnum;
    for (i = 0; i < 17; i++) {
      cardTemp += card.substr(i, 1) * arrInt[i];
    }
    valnum = arrCh[cardTemp % 11];
    if (valnum == card.substr(17, 1)) { return true; }
    return false;
  }
  return false;
};

/**
 * 15位转18位身份证号
 */
changeFivteenToEighteen = function(card) {
  if (card.length == '15') {
    var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);
    var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
    var cardTemp = 0, i;
    card = card.substr(0, 6) + '19' + card.substr(6, card.length - 6);
    for (i = 0; i < 17; i++) {
      cardTemp += card.substr(i, 1) * arrInt[i];
    }
    card += arrCh[cardTemp % 11];
    return card;
  }
  return card;
};

/**
 * 计算年龄
 * 
 * @param startDateStr
 * @returns
 */
function getDateYearSub(startDateStr) {
  var sDate = new Date(Date.parse(startDateStr.replace(/-/g, "-")));
  var eDate = new Date();
  var sY = sDate.getFullYear();
  var eY = eDate.getFullYear();
  if (eY > sY) {
    return eY - sY;
  } else {
    return 0;
  }
}

/**
 * 计算两个时间之间相差的天数
 * 
 * @param dateString1
 *          开始时间
 * @param dateString2
 *          结束时间
 * @param containEndData
 *          是否包含结束时间那一天
 * @returns
 */
function getDaysByDateString(startDate, endDate, containEndData) {
  // 获取起始时间的毫秒数
  // 其中dateString1.replace('/-/g','/')是将日期格式为yyyy-mm-dd转换成yyyy/mm/dd
  // Date.parse()静态方法的返回值为1970年1月1日午时到当前字符串时间的毫秒数，返回值为整数
  // 如果传入的日期只包含年月日不包含时分秒，则默认取的毫秒数为yyyy/mm/dd 00:00:00
  // 取的是0时0分0秒的毫秒数，如果传入的是2015/07/03 12:20:12则取值为该时间点的毫秒数
  // var startDate = Date.parse(dateString1.replace('/-/g', '/'));
  // var endDate = Date.parse(dateString2.replace('/-/g', '/'));
  // 因为不传时分秒的时候 默认取值到dateString2的0时0分0秒时的毫秒数，这样就不包含当前天数的毫秒数
  // 如果计算时要包含日期的当前天，就要加上一天的毫秒数，我的业务需要，将加上了。
  var diffDate;
  if (containEndData)
    diffDate = (endDate - startDate) + 1 * 24 * 60 * 60 * 1000;
  else
    diffDate = endDate - startDate;
  // 计算出两个日期字符串之间的相差的天数
  var days = diffDate / (1 * 24 * 60 * 60 * 1000);
  return parseInt(days);
}