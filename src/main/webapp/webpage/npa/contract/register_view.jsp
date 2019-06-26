<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>合同查看</title>
<t:base type="jquery,easyui,tools,DatePicker,validform"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/currencyformat.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/numberal.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/contract/register_view.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<body style="width: 99%;">
	<form name="formobj" id="formobj" method="post" action="register.do?saveOrUpdate">
		<!-- 借款信息 -->
		<div>
			<input type="hidden" name="loanContract.id" id="ctid" value="${view.loanContract.id }" /> <input type="hidden" name="loanContract.corporateOrgName"
				value="${view.loanContract.corporateOrgName }" />
			<h3 class="lrq">借款信息</h3>
			<table style="width: 100%;" cellpadding="0" cellspacing="1" class="viewtable">
				<tbody>
					<tr>
						<th><label class="required_sign">合同编号</label></th>
						<td><input type="text" name="loanContract.numCode" value="${view.loanContract.numCode }" maxlength="14" tip="14位数字编号" altercss="gray" datatype="numCode"
							sucmsg="档案编号验证通过!" nullmsg="请输入档案编号!" errormsg="格式不对或者编号已存在!" /></td>
						<th><label class="required_sign">贷款金额</label></th>
						<td><input type="text" name="loanContract.amount" value="<fmt:formatNumber pattern="0" maxFractionDigits="0" value="${view.loanContract.amount }" />" maxlength="7"
							tip="最大7位整数" altercss="gray" datatype="/^[1-9]\d*$/" sucmsg="贷款金额验证通过!" nullmsg="请输入贷款金额!" /></td>
						<th><label class="required_sign">贷款发放日</label></th>
						<td><input type="text" class="Wdate" onClick="WdatePicker({isShowClear:false,readOnly:true,minDate:'#F{$dp.$D(\'dueDate\')}'})" name="loanContract.issueDate"
							id="issueDate" value="${view.loanContract.issueDate }" datatype="*" sucmsg="贷款发放日验证通过!" nullmsg="请输入贷款发放日!" /></td>
						<th><label class="required_sign">贷款到期日</label></th>
						<td><input type="text" class="Wdate" onClick="WdatePicker({isShowClear:false,readOnly:true,minDate:'#F{$dp.$D(\'issueDate\')}'})" name="loanContract.dueDate"
							id="dueDate" value="${view.loanContract.dueDate }" datatype="*" sucmsg="贷款到期日验证通过!" nullmsg="请输入贷款到期日!" /></td>
					</tr>
					<tr>
						<th><label class="required_sign">利率</label></th>
						<td><input type="text" name="loanContract.interestRate"
							value="<fmt:formatNumber type="number" pattern="0.000" maxFractionDigits="3" maxIntegerDigits="2" value="${view.loanContract.interestRate }" />" maxlength="6" tip="千分比格式"
							altercss="gray" datatype="/^[1-9][0-9]?(\.\d{1,3})?$/" sucmsg="利率验证通过!" nullmsg="请输入利率!" /></td>
						<th><label class="required_sign">信贷员</label></th>
						<td><input type="text" name="loanContract.officer" value="${view.loanContract.officer }" maxlength="15" datatype="*" sucmsg="信贷员验证通过!" nullmsg="请输入信贷员!" /></td>
						<th><label class="required_sign">所属支行</label></th>
						<td><select name="loanContract.corporateOrgId" id="loanContract.corporateOrgId">
								<c:forEach items="${dictOrg}" var="item" varStatus="status">
									<option value="${item.id }">${item.nameShorter }</option>
								</c:forEach>
						</select></td>
						<th><label class="required_sign">担保方式</label></th>
						<td><select name="loanContract.guaranteeMode" id="loanContract.guaranteeMode" datatype="*" nullmsg="请选择担保方式!">
								<option value="" selected="selected">---请选择---</option>
								<option value="x">信用</option>
								<option value="b">保证</option>
								<option value="d">抵押</option>
								<option value="f">复合</option>
						</select></td>
					</tr>
					<tr>
						<th><label class="required_sign">处理方式</label></th>
						<td><select name="loanContract.disposeMode" id="loanContract.disposeMode" datatype="*" nullmsg="请选择处理方式!">
								<option value="" selected="selected">---请选择---</option>
								<option value="h">核销贷款</option>
								<option value="t">土地置换</option>
								<option value="y">央票置换</option>
						</select></td>
						<th><label class="required_sign">诉讼状态</label></th>
						<td><select name="loanContract.litigationStat" id="loanContract.litigationStat" datatype="*" nullmsg="请选择诉讼状态!">
								<option value="" selected="selected">---请选择---</option>
								<option value="n">未诉讼</option>
								<option value="l">立案</option>
								<option value="f">一审</option>
								<option value="s">二审</option>
								<option value="g">再审</option>
								<option value="t">调解</option>
								<option value="e">诉讼终结</option>
								<option value="i">申请执行</option>
								<option value="a">执行</option>
								<option value="b">中止执行</option>
								<option value="c">终止本次执行</option>
								<option value="d">执行终结</option>
						</select></td>
						<th><label>客户号</label></th>
						<td><input type="text" name="loanContract.customerNo" value="${view.loanContract.customerNo }" maxlength="20" /></td>
						<th><label>借据号</label></th>
						<td><input type="text" name="loanContract.louNo" value="${view.loanContract.louNo }" maxlength="20" /></td>
					</tr>
					<tr>
						<th><label>备注</label></th>
						<td colspan="7"><input type="text" name="loanContract.remark" value="${view.loanContract.remark }" maxlength="100" style="width: 365px;" /></td>
					</tr>
				</tbody>
			</table>
			<div class="split blue_line"></div>
		</div>

		<!-- 借款人信息 -->
		<div id="borrower_table">
			<h3 class="lrq">借款人信息</h3>
			<table style="width: 100%;" cellpadding="0" cellspacing="1" class="viewtable">
				<input type="hidden" name="loanContract.borrowerId" id="brId" value="${view.loanContract.borrowerId }" />
				<input type="hidden" name="borrower.id" value="${view.borrower.id }" />
				<tbody>
					<tr>
						<th><label class="required_sign">姓名</label></th>
						<td><input type="text" name="borrower.name" value="${view.borrower.name}" maxlength="50" datatype="*" sucmsg="姓名验证通过!" nullmsg="请输入姓名!" /></td>
						<th><label class="required_sign">身份证号</label></th>
						<td><input type="text" name="borrower.idNumber" id="borrowerIdNumber" value="${view.borrower.idNumber }" maxlength="18" datatype="*" sucmsg="身份证号验证通过!"
							nullmsg="请输入身份证号!" /></td>
						<th><label>出生年月</label></th>
						<td><input type="text" name="borrower.birthday" value="${view.borrower.birthday }" readonly="readonly" /></td>
						<th><label>年龄</label></th>
						<td><input type="text" name="borrower.age" value="${view.borrower.age }" readonly="readonly" /></td>
					</tr>
					<tr>
						<th><label>性别</label></th>
						<td><input type="radio" name="borrower.sex" value="m" onclick="return false;" readonly="readonly">男<input type="radio" name="borrower.sex" value="f"
							onclick="return false;" readonly="readonly">女</td>
						<th><label>手机号码</label></th>
						<td><input type="text" name="borrower.phone" value="${view.borrower.phone }" maxlength="11" datatype="m" ignore="ignore" sucmsg="手机号码验证通过!" nullmsg="请输入手机号码!" /></td>
						<th><label>通讯地址</label></th>
						<td><input type="text" name="borrower.address" value="${view.borrower.address }" maxlength="50" /></td>
						<th><label>是否借冒名</label></th>
						<td><input type="radio" name="loanContract.isImpersonate" value="1">是<input type="radio" name="loanContract.isImpersonate" value="0" checked="checked">否</td>
					</tr>
				</tbody>
			</table>
			<div style="margin-top: 5px;">
				<a id="borrower_search" class="easyui-linkbutton" data-options="iconCls:'icon-search'" attr1="borrower_table">查询</a><a id="borrower_clean" class="easyui-linkbutton"
					data-options="iconCls:'icon-le-back'" attr1="borrower_table">清空</a>
			</div>
			<div class="split blue_line"></div>
		</div>

		<!-- 担保人信息 -->
		<div id="guarantee_div">
			<h3 class="lrq" style="display: inline-block">担保人信息</h3>
			<a id="guarantee_add_btn" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增</a>
		</div>
		<input type="hidden" id="btn_sub" class="btn_sub" />
	</form>

	<!-- 模板信息 -->
	<div id="guarantee_template" style="display: none">
		<div style="position: relative;" id="" name="guarantee_table_">
			<input type="hidden" name="loanContractGuarantees[-].id" value="" /> <input type="hidden" name="loanContractGuarantees[-].loanContracId" value="" /> <input type="hidden"
				name="loanContractGuarantees[-].guaranteeId" value="" /> <input type="hidden" name="loanContractGuarantees[-].guarantee.id" value="" />
			<table style="width: 100%;" cellpadding="0" cellspacing="1" class="viewtable">
				<tbody>
					<tr>
						<td rowspan="2" style="width: 40px"><div class="circle">1</div></td>
						<th><label class="required_sign">姓名</label></th>
						<td><input type="text" name="loanContractGuarantees[-].guarantee.name" value="" maxlength="50" datatype="*" sucmsg="姓名验证通过!" nullmsg="请输入姓名!" /></td>
						<th><label class="required_sign">身份证号</label></th>
						<td><input type="text" name="loanContractGuarantees[-].guarantee.idNumber" value="" maxlength="18" datatype="*" sucmsg="身份证号验证通过!" nullmsg="请输入身份证号!" /></td>
						<th><label>出生年月</label></th>
						<td><input type="text" name="loanContractGuarantees[-].guarantee.birthday" value="" readonly="readonly" /></td>
						<th><label>年龄</label></th>
						<td><input type="text" name="loanContractGuarantees[-].guarantee.age" value="" readonly="readonly" /></td>
					</tr>
					<tr>
						<th><label>性别</label></th>
						<td><input type="radio" name="loanContractGuarantees[-].guarantee.sex" value="m" onclick="return false;" readonly="readonly">男<input type="radio"
							name="loanContractGuarantees[-].guarantee.sex" value="f" onclick="return false;" readonly="readonly">女</td>
						<th><label>手机号码</label></th>
						<td><input type="text" name="loanContractGuarantees[-].guarantee.phone" value="" maxlength="11" datatype="m" ignore="ignore" sucmsg="手机号码验证通过!" nullmsg="请输入手机号码!" /></td>
						<th><label>通讯地址</label></th>
						<td><input type="text" name="loanContractGuarantees[-].guarantee.address" value="" maxlength="50" /></td>
						<th><label>是否借冒名</label></th>
						<td><input type="radio" name="loanContractGuarantees[-].isImpersonate" value="1">是<input type="radio" name="loanContractGuarantees[-].isImpersonate" value="0"
							checked="checked">否</td>
					</tr>
				</tbody>
			</table>
			<div style="margin-top: 5px;">
				<a name="person_search_btn" class="easyui-linkbutton" data-options="iconCls:'icon-search'" attr1="guarantee_table_">查询</a><a name="person_clean_btn" class="easyui-linkbutton"
					data-options="iconCls:'icon-le-back'" attr1="guarantee_table_">清空</a><a name="person_remove_btn" class="easyui-linkbutton" data-options="iconCls:'icon-remove'"
					attr1="guarantee_table_">删除</a>
			</div>
			<div class="split orange_line"></div>
		</div>
	</div>
</body>
</html>

<script type="text/javascript">
  var corporateOrgId = '${view.loanContract.corporateOrgId}';
  var litigationStat = '${view.loanContract.litigationStat}';
  var guaranteeMode = '${view.loanContract.guaranteeMode}';
  var disposeMode = '${view.loanContract.disposeMode}';

  /**
   * 创建担保人
   * @param id_p
   * @param loanContracId_p
   * @param guaranteeId_p
   * @param isImpersonate_p
   * @param id
   * @param name
   * @param idNumber
   * @param birthday
   * @param age
   * @param sex
   * @param phone
   * @param address
   * @returns
   */
  function User_g(id_p, loanContracId_p, guaranteeId_p, isImpersonate_p, id, name, idNumber, birthday, age, sex, phone, address) {
    this.id_p = id_p;
    this.loanContracId_p = loanContracId_p;
    this.guaranteeId_p = guaranteeId_p;
    this.isImpersonate_p = isImpersonate_p;
    this.id = id;
    this.name = name;
    this.idNumber = idNumber;
    this.birthday = birthday;
    this.age = age;
    this.sex = sex;
    this.phone = phone;
    this.address = address;
  }

  function User_b(id, name, idNumber, birthday, age, sex, phone, address) {
    this.id = id;
    this.name = name;
    this.idNumber = idNumber;
    this.birthday = birthday;
    this.age = age;
    this.sex = sex;
    this.phone = phone;
    this.address = address;
  }

  function User_b(id_p, id, name, idNumber, birthday, age, sex, phone, address, isImpersonate) {
    this.id_p = id_p;
    this.id = id;
    this.name = name;
    this.idNumber = idNumber;
    this.birthday = birthday;
    this.age = age;
    this.sex = sex;
    this.phone = phone;
    this.address = address;
    this.isImpersonate = isImpersonate;
  }

  var borrower = new User_b('${view.loanContract.borrowerId}', '${view.borrower.id}', '${view.borrower.name}', '${view.borrower.idNumber}', '${view.borrower.birthday}',
          '${view.borrower.age}', '${view.borrower.sex}', '${view.borrower.phone}', '${view.borrower.address}', '${view.loanContract.isImpersonate}')
  var guaranteesArray = new Array(); //保存担保人
  <c:forEach items="${view.loanContractGuarantees}" var="item">
  var g = new User_g('${item.id}', '${item.loanContracId}', '${item.guaranteeId}', '${item.isImpersonate}', '${item.guarantee.id}', '${item.guarantee.name}',
          '${item.guarantee.idNumber}', '${item.guarantee.birthday}', '${item.guarantee.age}', '${item.guarantee.sex}', '${item.guarantee.phone}', '${item.guarantee.address}');
  guaranteesArray.push(g);
  </c:forEach>
</script>