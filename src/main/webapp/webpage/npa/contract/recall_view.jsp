<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>收回款明细登记</title>
<t:base type="jquery,easyui,tools,DatePicker,validform"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/currencyformat.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/numberal.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/contract/recall_view.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<style type="text/css">
.viewtable th {
	width: 100px;
}
</style>
<body class="easyui-layout">
	<div id="htxq" data-options="region:'west', href:'register.do?toDetail&id=${view.loanContract.id }'" title="合同详情"
		style="width: 52%; padding: 5px"></div>

	<div data-options="region:'center'" title="收回款登记" style="padding: 5px">
		<div class="easyui-tabs" data-options="fit:true" style="width: 100%; height: auto">
			<div title="利息计算" style="padding: 10px">
				<form name="formobj" id="formobj" method="post" action="${webRoot}/recoveryMoney.do?saveOrUpdate">
					<input type="hidden" name="id" id="id" value="" /> <input type="hidden" name="loanContracId" id="loanContracId"
						value="${view.loanContract.id }" /> <input type="hidden" name="interestBearingPrincipal"
						id="interestBearingPrincipal" value="" /> <input type="hidden" name="recoveryInterest" id="recoveryInterest"
						value="" />
					<h3 class="lrq">试算</h3>
					<table style="width: 100%;" cellpadding="0" cellspacing="1" class="viewtable">
						<tbody>
							<tr>
								<th>
									<label class="required_sign">收回时间</label>
								</th>
								<td><input type="text" class="Wdate"
									onClick="WdatePicker({isShowClear:false,readOnly:true,minDate:'${view.loanContract.dueDate}', maxDate:'%y-%M-%d'})"
									name="recoveryDate" id="recoveryDate" datatype="*" sucmsg="收回时间验证通过!" nullmsg="请输入收回时间!" readonly="readonly" /></td>
								<th>
									<label class="required_sign">收回人</label>
								</th>
								<td><input type="text" name="recoveryPerson" id="recoveryPerson" maxlength="15" datatype="*"
									sucmsg="收回人验证通过!" nullmsg="请输入收回人!" /></td>
							</tr>
							<tr>
								<th>
									<label class="required_sign">收回本金</label>
								</th>
								<td><input type="text" name="recoveryPrincipal" id="recoveryPrincipal" value="0.0" maxlength="11"
									datatype="custom1" sucmsg="收回本金验证通过!" nullmsg="请输入收回本金!" /></td>
								<th>
									<label class="required_sign">利率</label>
								</th>
								<td><input type="text" name="interestRate" id="interestRate" value="${view.loanContract.interestRate }"
									maxlength="6" datatype="/^[1-9][0-9]?(\.\d{1,3})?$/" sucmsg="利率验证通过!" nullmsg="请输入利率!" /></td>
							</tr>
							<tr>
								<th>
									<label class="required_sign">起息日</label>
								</th>
								<td><input type="text" class="Wdate"
									onClick="WdatePicker({isShowClear:false,readOnly:true,minDate:'${view.loanContract.issueDate}', maxDate:'${view.loanContract.dueDate}'})"
									name="interestDate" id="interestDate" value="" datatype="*" sucmsg="起息日验证通过!" nullmsg="请输入起息日!" /></td>
								<th>
									<label>挂息金额</label>
								</th>
								<td><input type="text" name="hangInterest" id="hangInterest" value="0.0" maxlength="11"
									datatype="/^(0|(0{1}\.\d{1,2}|([1-9]{1}\d{0,6}\.{1}\d{1,2})|([1-9]{1}\d{0,6})))$/" sucmsg="挂息金额验证通过!"
									nullmsg="请输入挂息金额!" /></td>
							</tr>
							<tr>
								<th>
									<label class="required_sign">收回方式</label>
								</th>
								<td colspan="3"><select name="recoveryMode" id="recoveryMode" datatype="*" nullmsg="请选择收回方式!">
										<option value="" selected="selected">---请选择---</option>
										<option value="c">现金收回</option>
										<option value="f">法院扣划</option>
								</select></td>
							</tr>
						</tbody>
					</table>
					<div class="split blue_line"></div>
					<table style="width: 100%;" cellpadding="0" cellspacing="1" class="viewtable">
						<tbody>
							<tr>
								<th>
									<label>应收回本金</label>
								</th>
								<td><input type="text" id="b1" readonly="readonly" value="" /></td>
								<th>
									<label>剩余本金</label>
								</th>
								<td><input type="text" id="b2" readonly="readonly" value="0.0" datatype="custom2" sucmsg="剩余本金验证通过!"
									errormsg="剩余本金不允许为负数!" /></td>
							</tr>
						</tbody>
					</table>
					<div class="split blue_line"></div>

					<h3 class="lrq">利息卡</h3>
					<table id="lixika" class="easyui-datagrid"
						data-options="rownumbers:true,singleSelect:true,showFooter:true,striped:true" style="width: 100%;">
						<thead>
							<tr>
								<th data-options="field:'sdate', formatter:formatDate">开始日期</th>
								<th data-options="field:'edate', formatter:formatDate">截止日期</th>
								<th data-options="field:'amount', formatter:formatMoney">金额(元)</th>
								<th data-options="field:'days'">天数</th>
								<th data-options="field:'rate', formatter:formatRate1">利率(‰)</th>
								<th data-options="field:'interest', formatter:formatMoney">利息(元)</th>
							</tr>
						</thead>
					</table>

					<div class="split orange_line"></div>
					<table style="width: 100%;" cellpadding="0" cellspacing="1" class="viewtable">
						<tbody>
							<tr>
								<th>
									<label>逾期罚息</label>
								</th>
								<td><span id="y1"></span></td>
								<th>
									<label>罚息率</label>
								</th>
								<td><span class="rate">50</span></td>
								<th>
									<label>罚息金额</label>
								</th>
								<td><span class="rmb" id="y2"></span></td>
							</tr>
							<tr>
								<th>
									<label>利息合计</label>
								</th>
								<td><span class="rmb" id="y3"></span></td>
								<th>
									<label>本息合计</label>
								</th>
								<td colspan="5"><span class="rmb" id="y4"></span></td>
							</tr>
						</tbody>
					</table>

					<div style="padding: 5px 0; text-align: right">
						<a href="#" class="easyui-linkbutton" onclick="calculator()">计算</a> <a href="#" class="easyui-linkbutton"
							onclick="allRecall()">全额还款</a> <a href="#" class="easyui-linkbutton" id="btn_sub">保存</a>
					</div>
				</form>
			</div>

			<div title="还款明细" style="padding: 10px">
				<table id="recoveryMoney">
					<thead>
						<tr>
							<th data-options="field:'recoveryDate',align:'center'">收回时间</th>
							<th data-options="field:'recoveryPerson',align:'center'">收回人</th>
							<th data-options="field:'interestDate',align:'center'">起息日</th>
							<th data-options="field:'interestRate',align:'center'">当前利率(‰)</th>
							<th data-options="field:'interestBearingPrincipal',align:'center', formatter:formatMoney">计息金额(元)</th>
							<th data-options="field:'recoveryPrincipal',align:'center', formatter:formatMoney">本金(元)</th>
							<th data-options="field:'recoveryInterest',align:'center', formatter:formatMoney">利息(元)</th>
							<th data-options="field:'hangInterest',align:'center', formatter:formatMoney">挂息(元)</th>
							<th data-options="field:'recoveryMode',align:'center', formatter:formatRecoveryMode">收回方式</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${view.recoveryMoneies}" var="item" varStatus="status">
							<tr>
								<td>${item.recoveryDate }</td>
								<td>${item.recoveryPerson }</td>
								<td>${item.interestDate }</td>
								<td>${item.interestRate }</td>
								<td>${item.interestBearingPrincipal }</td>
								<td>${item.recoveryPrincipal }</td>
								<td>${item.recoveryInterest }</td>
								<td>${item.hangInterest }</td>
								<td>${item.recoveryMode }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
</body>
</html>
<script type="text/javascript">
  function contract(id, numCode, amount, issueDate, dueDate, interestRate, recoveryPrincipal, recoveryInterest, hangInterest, interestDate) {
    this.id = parseInt(id);
    this.numCode = numCode;
    this.amount = parseFloat(amount);
    this.issueDate = new Date(issueDate);
    this.dueDate = new Date(dueDate);
    this.interestRate = parseFloat(interestRate);
    this.recoveryPrincipal = parseFloat(recoveryPrincipal);
    this.recoveryInterest = parseFloat(recoveryInterest);
    this.hangInterest = parseFloat(hangInterest);
    this.interestDate = interestDate;
  }

  var contract_obj = new contract('${view.loanContract.id }', '${view.loanContract.numCode }', '${view.loanContract.amount }', '${view.loanContract.issueDate }',
          '${view.loanContract.dueDate }', '${view.loanContract.interestRate }', '${view.loanContract.recoveryPrincipal }', '${view.loanContract.recoveryInterest }',
          '${view.loanContract.hangInteres }', '${view.loanContract.interestDate }');

  var selectRowIndex = '${selectRowIndex}';
</script>