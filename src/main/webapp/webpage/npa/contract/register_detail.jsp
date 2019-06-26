<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>借款合同详情</title>
<t:base type="jquery,easyui,tools"></t:base>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<body style="width: 99%;">
	<!-- 借款信息 -->
	<div>
		<h3 class="lrq">借款信息</h3>
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="viewtable">
			<tbody>
				<tr>
					<th>
						<label>档案编号</label>
					</th>
					<td>${view.loanContract.numCode }</td>
					<th>
						<label>贷款金额</label>
					</th>
					<td><fmt:formatNumber type="currency" maxFractionDigits="0" value="${view.loanContract.amount }" /></td>
					<th>
						<label>贷款发放日</label>
					</th>
					<td>${view.loanContract.issueDate }</td>
					<th>
						<label>贷款到期日</label>
					</th>
					<td>${view.loanContract.dueDate }</td>
				</tr>
				<tr>
					<th>
						<label>利率</label>
					</th>
					<td><fmt:formatNumber type="number" maxIntegerDigits="2" maxFractionDigits="3"
							value="${view.loanContract.interestRate }" />‰</td>
					<th>
						<label>信贷员</label>
					</th>
					<td>${view.loanContract.officer }</td>
					<th>
						<label>所属支行</label>
					</th>
					<td>${view.loanContract.corporateOrgName }</td>
					<th>
						<label>担保方式</label>
					</th>
					<td>${view.loanContract.guaranteeMode_s }</td>
				</tr>
				<tr>
					<th>
						<label>处理方式</label>
					</th>
					<td>${view.loanContract.disposeMode_s }</td>
					<th>
						<label>诉讼状态</label>
					</th>
					<td>${view.loanContract.litigationStat_s }</td>
					<th>
						<label>客户号</label>
					</th>
					<td>${view.loanContract.customerNo }</td>
					<th>
						<label>借据号</label>
					</th>
					<td>${view.loanContract.louNo }</td>
				</tr>
				<tr>
					<th>
						<label>备注</label>
					</th>
					<td colspan="7">${view.loanContract.remark }</td>
				</tr>
			</tbody>
		</table>
		<div class="split blue_line"></div>
	</div>

	<!-- 回款信息 -->
	<div>
		<h3 class="lrq">回款信息</h3>
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="viewtable">
			<tbody>
				<tr>
					<th>
						<label>起息日</label>
					</th>
					<td id="qxr">${view.loanContract.interestDate }</td>
					<th>
						<label>收回本金</label>
					</th>
					<td id="hsbj"><fmt:formatNumber type="currency" maxFractionDigits="4"
							value="${view.loanContract.recoveryPrincipal }" /></td>
					<th>
						<label>收回利息</label>
					</th>
					<td id="hslx"><fmt:formatNumber type="currency" maxFractionDigits="4"
							value="${view.loanContract.recoveryInterest }" /></td>
					<th>
						<label>挂息</label>
					</th>
					<td id="gx"><fmt:formatNumber type="currency" maxFractionDigits="4" value="${view.loanContract.hangInteres }" /></td>
				</tr>
			</tbody>
		</table>
		<div class="split blue_line"></div>
	</div>

	<!-- 借款人信息 -->
	<div id="borrower_table">
		<h3 class="lrq">借款人信息</h3>
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="viewtable">
			<tbody>
				<tr>
					<th>
						<label>姓名</label>
					</th>
					<td>${view.borrower.name}</td>
					<th>
						<label>身份证号</label>
					</th>
					<td>${view.borrower.idNumber }</td>
					<th>
						<label>出生年月</label>
					</th>
					<td>${view.borrower.birthday }</td>
					<th>
						<label>年龄</label>
					</th>
					<td>${view.borrower.age }</td>
				</tr>
				<tr>
					<th>
						<label>性别</label>
					</th>
					<td><c:if test="${view.borrower.sex == 'f'}">男</c:if> <c:if test="${view.borrower.sex == 'm'}">女</c:if></td>
					<th>
						<label>手机号码</label>
					</th>
					<td>${view.borrower.phone }</td>
					<th>
						<label>通讯地址</label>
					</th>
					<td>${view.borrower.address }</td>
					<th>
						<label>是否借冒名</label>
					</th>
					<td><c:if test="${view.loanContract.isImpersonate == 1}">是</c:if> <c:if
							test="${view.loanContract.isImpersonate == 0}">否</c:if></td>
				</tr>
			</tbody>
		</table>
		<div class="split blue_line"></div>
	</div>

	<!-- 担保人信息 -->
	<div id="guarantee_div">
		<h3 class="lrq" style="display: inline-block">担保人信息</h3>
		<c:forEach items="${view.loanContractGuarantees}" var="item" varStatus="status">
			<div style="position: relative;" id="" name="guarantee_table_${status.index }">
				<table style="width: 100%;" cellpadding="0" cellspacing="1" class="viewtable">
					<tbody>
						<tr>
							<td rowspan="2" style="width: 40px"><div class="circle">${status.index + 1 }</div></td>
							<th>
								<label>姓名</label>
							</th>
							<td>${item.guarantee.name}</td>
							<th>
								<label>身份证号</label>
							</th>
							<td>${item.guarantee.idNumber}</td>
							<th>
								<label>出生年月</label>
							</th>
							<td>${item.guarantee.birthday}</td>
							<th>
								<label>年龄</label>
							</th>
							<td>${item.guarantee.age}</td>
						</tr>
						<tr>
							<th>
								<label>性别</label>
							</th>
							<td><c:if test="${item.guarantee.sex == 'f'}">男</c:if> <c:if test="${item.guarantee.sex == 'm'}">女</c:if></td>
							<th>
								<label>手机号码</label>
							</th>
							<td>${item.guarantee.phone}</td>
							<th>
								<label>通讯地址</label>
							</th>
							<td>${item.guarantee.address}</td>
							<th>
								<label>是否借冒名</label>
							</th>
							<td><c:if test="${item.isImpersonate == 1}">是</c:if> <c:if test="${item.isImpersonate == 0}">否</c:if></td>
						</tr>
					</tbody>
				</table>
				<div class="split orange_line"></div>
			</div>
		</c:forEach>
	</div>
</body>
</html>