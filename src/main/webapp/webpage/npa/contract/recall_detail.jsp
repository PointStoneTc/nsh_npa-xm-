<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>收回款明细详情</title>
<t:base type="jquery,easyui,DatePicker"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript"
	src="${webRoot}/static/js/npa/currencyformat.js"></script>
<script type="text/javascript"
	src="${webRoot}/static/js/npa/numberal.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<style type="text/css">
.viewtable th {
	width: 100px;
}
</style>
<body style="width: 98%">
	<table id="recoveryMoney" width="100%">
		<thead>
			<tr>
				<th data-options="field:'recoveryDate',align:'center'">收回时间</th>
				<th data-options="field:'recoveryPerson',align:'center'">收回人</th>
				<th data-options="field:'interestDate',align:'center'">起息日</th>
				<th data-options="field:'interestRate',align:'center'">当前利率(‰)</th>
				<th
					data-options="field:'interestBearingPrincipal',align:'center', formatter:formatMoney">计息金额(元)</th>
				<th
					data-options="field:'recoveryPrincipal',align:'center', formatter:formatMoney">本金(元)</th>
				<th
					data-options="field:'recoveryInterest',align:'center', formatter:formatMoney">利息(元)</th>
				<th
					data-options="field:'hangInterest',align:'center', formatter:formatMoney">挂息(元)</th>
				<th
					data-options="field:'recoveryMode',align:'center', formatter:formatRecoveryMode">收回方式</th>
			</tr>
		</thead>

		<tbody>
			<c:forEach items="${view.recoveryMoneies}" var="item"
				varStatus="status">
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
</body>
</html>
<script type="text/javascript">
  $(function() {
    $('#recoveryMoney').datagrid({
      rownumbers: true,
      singleSelect: true,
      fitColumns: true
    });
  });
</script>