<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>未完全收回款列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/currencyformat.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/numberal.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/contract/recall_list.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<body>
	<table id="recallList" class="easyui-datagrid" title="未完全收回款列表"
		data-options="rownumbers:true,singleSelect:true,pagination:true,pageSize:20,fit:true,striped:true,url:'recall.do?datagrid&field=id,numCode,customerNo,louNo,borrowerName,borrower.idNumber,amount,issueDate,dueDate,interestRate,officer,corporateOrgName,amountSurplus,litigationStat,guaranteeMode,disposeMode,interestDate,recoveryPrincipal,recoveryInterest,hangInteres',method:'post',toolbar:'#tb'">
		<thead>
			<tr>
				<th data-options="field:'id',hidden:true" , rowspan="2">id</th>
				<th data-options="field:'numCode',align:'center'" , rowspan="2">档案编号</th>
				<th data-options="field:'customerNo',align:'center'" rowspan="2">客户号</th>
				<th data-options="field:'louNo',align:'center'" rowspan="2">借据号</th>
				<th colspan="2">借款人</th>
				<th colspan="10">贷款信息</th>
				<th colspan="5">收回款信息</th>
				<th data-options="field:'opt',align:'center',formatter:operate_formatter" , rowspan="2">操作</th>
			</tr>
		</thead>
		<thead>
			<tr>
				<th data-options="field:'borrowerName',align:'center'">借款人</th>
				<th data-options="field:'borrower.idNumber',align:'center'">借款人身份证号</th>
				<th data-options="field:'amount',align:'center', formatter:formatMoney">贷款金额(元)</th>
				<th data-options="field:'issueDate',align:'center'">贷款发放日</th>
				<th data-options="field:'dueDate',align:'center'">贷款到期日</th>
				<th data-options="field:'interestRate',align:'center'">利率(‰)</th>
				<th data-options="field:'unhealthyDate',align:'center',formatter:formatUnhealthyDate">不良形成日期</th>
				<th data-options="field:'officer',align:'center'">信贷员</th>
				<th data-options="field:'corporateOrgName',align:'center'">所属支行</th>
				<th data-options="field:'litigationStat',align:'center',formatter:formatLitigationStat">诉讼状态</th>
				<th data-options="field:'guaranteeMode',align:'center',formatter:formatCtguaranteeMode">担保方式</th>
				<th data-options="field:'disposeMode',align:'center',formatter:formatCtdisposeMode">处理方式</th>
				<th data-options="field:'interestDate',align:'center'">起息日</th>
				<th data-options="field:'amountSurplus',align:'center', formatter:amountSurplus">贷款余额(元)</th>
				<th data-options="field:'recoveryPrincipal',align:'center', formatter:formatMoney">收回本金(元)</th>
				<th data-options="field:'recoveryInterest',align:'center', formatter:formatMoney">收回利息(元)</th>
				<th data-options="field:'hangInteres',align:'center', formatter:formatMoney">挂息(元)</th>
			</tr>
		</thead>
	</table>

	<div id="tb" style="padding: 2px 5px;">
		<table>
			<tr>
				<td><a id="view" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-tip'" onclick="detailContract()">查看详情</a></td>
				<td><label>借款人</label></td>
				<td><input name="borrowerName" id="borrowerName" class="easyui-textbox" style="width: 110px" /></td>
				<td><label>身份证号</label></td>
				<td><input name="idNumber" id="idNumber" class="easyui-textbox" style="width: 110px" /></td>
				<td><label>档案编号</label></td>
				<td><input name="numCode" id="numCode" class="easyui-textbox" style="width: 110px" /></td>
				<td><a id="search" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doQuery()">查询</a></td>
				<td><a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-le-back'" onclick="doClear()">清空</a></td>

				<td><label>(导出)开始时间</label></td>
				<td><input class="easyui-datebox" name="startDate" id="startDate" /></td>
				<td><label>结束时间</label></td>
				<td><input class="easyui-datebox" name="endDate" id="endDate" /></td>
				<td><a id="export" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="exportAll()">导出数据</a></td>
			</tr>
		</table>
	</div>
</body>
</html>