<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>借款合同综合查询</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/currencyformat.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/numberal.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/contract/query_list.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/tools/Map.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div data-options="region:'center'" style="padding: 0px; border: 0px;">
			<table id="queryList" name="queryList" class="easyui-datagrid" title="借款合同综合查询"
				data-options="rownumbers:true,fit:true,striped:true,checkOnSelect:true,url:'query.do?datagrid&field=id,numCode,customerNo,louNo,borrowerName,idNumber,guaranteesName,guaranteesIdNumber,amount,amountSurplus,oInterestRate,issueDate,dueDate,interestDate,adjustInterestRate,officer,corporateOrgName,hangInteres,litigationStat,guaranteeMode,disposeMode,stat',method:'post',toolbar:'#tb'">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true" rowspan="2"></th>
						<th data-options="field:'id',hidden:true" rowspan="2">id</th>
						<th data-options="field:'numCode',align:'center'" rowspan="2">档案编号</th>
						<th data-options="field:'customerNo',align:'center'" rowspan="2">客户号</th>
						<th data-options="field:'louNo',align:'center'" rowspan="2">借据号</th>
						<th colspan="2">借款人</th>
						<th colspan="2">担保人</th>
						<th colspan="11">贷款信息</th>
						<th colspan="3">收回款信息</th>
						<th data-options="field:'stat',align:'center',formatter:formatCtstat" rowspan="2">状态</th>
					</tr>
				</thead>
				<thead>
					<tr>
						<th data-options="field:'borrowerName',align:'center'">姓名</th>
						<th data-options="field:'idNumber',align:'center'">身份证号</th>
						<th data-options="field:'guaranteesName',align:'center'">姓名</th>
						<th data-options="field:'guaranteesIdNumber',align:'center'">身份证号</th>
						<th data-options="field:'amount',align:'center',formatter:formatMoney">原贷金额(元)</th>
						<th data-options="field:'amountSurplus',align:'center',formatter:formatMoney">贷款余额(元)</th>
						<th data-options="field:'oInterestRate',align:'center'">原贷利率(‰)</th>
						<th data-options="field:'issueDate',align:'center'">贷款发放日</th>
						<th data-options="field:'dueDate',align:'center'">贷款到期日</th>
						<th data-options="field:'unhealthyDate',align:'center',formatter:formatUnhealthyDate">不良形成日期</th>
						<th data-options="field:'officer',align:'center'">信贷员</th>
						<th data-options="field:'corporateOrgName',align:'center'">所属支行</th>
						<th data-options="field:'litigationStat',align:'center',formatter:formatLitigationStat">诉讼状态</th>
						<th data-options="field:'guaranteeMode',align:'center',formatter:formatCtguaranteeMode">担保方式</th>
						<th data-options="field:'disposeMode',align:'center',formatter:formatCtdisposeMode">处理方式</th>
						<th data-options="field:'interestDate',align:'center'">起息日</th>
						<th data-options="field:'adjustInterestRate',align:'center'">调整利率(‰)</th>
						<th data-options="field:'hangInteres',align:'center',formatter:formatMoney">挂息(元)</th>
					</tr>
				</thead>
			</table>

			<div id="tb" style="padding: 2px 5px;">
				<table>
					<tr>
						<td><label>被查询人(多个被查询人之间以','隔开.注意使用半角逗号)</label></td>
						<td><input name="userName" id="userName" class="easyui-textbox" style="width: 110px" /></td>
						<td><label>身份证号</label></td>
						<td><input name="idNumber" id="idNumber" class="easyui-textbox" style="width: 330px" /></td>
						<td><a id="search" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doQuery()">查询</a></td>
						<td><a id="clear" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-le-back'" onclick="doClear()">清空</a></td>
						<td><a id="printList" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="doPrintList()">添加到打印清单</a></td>
						<td><a id="printListClear" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="doPrintListClear()">清空到打印区域</a></td>
						<td><a id="save" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveFile()">保存打印文件</a></td>
					</tr>
				</table>
			</div>
		</div>

		<div data-options="region:'south',title:'打印清单',split:true" style="height: 400px;">
			<div class="easyui-layout" fit="true">
				<div data-options="region:'west',border:true,split:true,collapsible:false,title:'未查到名单'" style="padding: 0px; border: 0px; width: 300px">
					<ul class="query-pdf-list" id="notFindexportList"></ul>
				</div>
				<div data-options="region:'center',border:true,split:true,title:'已查到名单'" style="padding: 0px; border: 0px;">
					<ul class="query-pdf-list" id="findExportList"></ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>