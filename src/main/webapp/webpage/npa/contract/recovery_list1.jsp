<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>回款清单</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<t:base type="jquery,easyui,tools,validform"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/currencyformat.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/numberal.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/contract/recovery_list1.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<body>
	<form name="formobj" id="formobj" method="post" action="recoveryMoney.do?del">
		<input type="hidden" id="id" name="id" value="" /> <input type="hidden" name="index" id="index" value="${index}" /> <input type="hidden" id="btn_sub" class="btn_sub" />
	</form>
	<table id="recoverylList" class="easyui-datagrid" title="回款清单"
		data-options="rownumbers:true,singleSelect:true,fit:true,striped:true,url:'recoveryMoney.do?datagrid&id=${id}&field=id,recoveryDate,recoveryPerson,interestDate,interestRate,interestBearingPrincipal,recoveryPrincipal,recoveryInterest,hangInterest,createBy,createDate',method:'post'">
		<thead>
			<tr>
				<th data-options="field:'id',hidden:true">id</th>
				<th data-options="field:'recoveryDate',align:'center'">收回时间</th>
				<th data-options="field:'recoveryPerson',align:'center'">收回人</th>
				<th data-options="field:'interestDate',align:'center'">起息日</th>
				<th data-options="field:'interestRate',align:'center'">当前利率(‰)</th>
				<th data-options="field:'interestBearingPrincipal',align:'center', formatter:formatMoney">计息金额(元)</th>
				<th data-options="field:'recoveryPrincipal',align:'center', formatter:formatMoney">本金(元)</th>
				<th data-options="field:'recoveryInterest',align:'center', formatter:formatMoney">利息(元)</th>
				<th data-options="field:'hangInterest',align:'center', formatter:formatMoney">挂息(元)</th>
				<th data-options="field:'createBy',align:'center'">创建人</th>
				<th data-options="field:'createDate',align:'center'">创建时间</th>
				<th data-options="field:'opt',align:'center',formatter:operate_formatter">操作</th>
			</tr>
		</thead>
	</table>
</body>
</html>