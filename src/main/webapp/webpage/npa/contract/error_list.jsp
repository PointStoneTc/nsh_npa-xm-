<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>错误借款合同列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/currencyformat.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/numberal.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/contract/error_list.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<body>
	<table id="errorList" name="errorList" class="easyui-datagrid" title="错误借款合同列表"
		data-options="rownumbers:true,pagination:true,pageSize:20,fit:true,striped:true,url:'error.do?datagrid&field=id,numCode,customerNo,louNo,borrowerName,idNumber,address,guaranteesName,guaranteesIdNumber,guaranteesAddresses,amount,issueDate,dueDate,interestRate,officer,corporateOrgName,litigationStat,guaranteeMode,disposeMode,interestDate,recoveryPrincipal,recoveryInterest,hangInteres',method:'post',toolbar:'#tb'">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true" rowspan="2"></th>
				<th data-options="field:'id',align:'center'" rowspan="2">id</th>
				<th data-options="field:'numCode',align:'center'" rowspan="2">档案编号</th>
				<th data-options="field:'customerNo',align:'center'" rowspan="2">客户号</th>
				<th data-options="field:'louNo',align:'center'" rowspan="2">借据号</th>
				<th colspan="3">借款人</th>
				<th colspan="3">担保人</th>
				<th colspan="10">贷款信息</th>
				<th colspan="4">收回款信息</th>
			</tr>
		</thead>
		<thead>
			<tr>
				<th data-options="field:'borrowerName',align:'center'">姓名</th>
				<th data-options="field:'idNumber',align:'center'">身份证号</th>
				<th data-options="field:'address',align:'center'">地址</th>
				<th data-options="field:'guaranteesName',align:'center'">姓名</th>
				<th data-options="field:'guaranteesIdNumber',align:'center'">身份证号</th>
				<th data-options="field:'guaranteesAddresses',align:'center'">地址</th>
				<th data-options="field:'amount',align:'center',formatter:formatMoney">贷款金额(元)</th>
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
				<th data-options="field:'recoveryPrincipal',align:'center',formatter:formatMoney">收回本金(元)</th>
				<th data-options="field:'recoveryInterest',align:'center',formatter:formatMoney">收回利息(元)</th>
				<th data-options="field:'hangInteres',align:'center',formatter:formatMoney">挂息(元)</th>
			</tr>
		</thead>
	</table>

	<div id="tb" style="padding: 2px 5px;">
		<table>
			<tr class="queryToolbarTable">
				<td><label>借款人</label></td>
				<td><input name="borrowerName" id="borrowerName" class="easyui-textbox" style="width: 110px" /></td>
				<td><label>错误类型</label></td>
				<td><select name="errorType" id="errorType" style="width: 150px">
						<option value="" selected="selected">---请选择---</option>
						<option value="e1">借款人身份证号为空</option>
						<option value="e2">贷款发放日为空</option>
						<option value="e3">贷款到期日为空</option>
						<option value="e4">贷款到期日>贷款发放日</option>
				</select></td>
				<td class="borderLeft"><a id="search" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doQuery()">查询</a></td>
				<td><a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-le-back'" onclick="doClear()">清空</a></td>
				<td class="borderLeft"><a href="#" class="ace_button" alt="修改借款人" onclick="updateBorrower()" style="background-color: #9e123e;"><i class="fa fa-gavel"></i>修改借款人</a></td>
				<td class="borderLeft"><a href="#" class="ace_button" alt="修改担保人" onclick="updateGuarantee()" style="background-color: #9e123e;"><i class="fa fa-gavel"></i>修改担保人</a></td>
				<td class="borderLeft"><a href="#" class="ace_button" alt="修改贷款发放日" onclick="updateIssueDueDate()" style="background-color: #9e123e;"><i class="fa fa-gavel"></i>修改贷款发放日</a></td>
				<td class="borderLeft"><a href="#" class="ace_button" alt="修改其它信息" onclick="updateOther()" style="background-color: #9e123e;"><i class="fa fa-gavel"></i>修改其它信息</a></td>
				<td class="borderLeft"><a href="#" class="ace_button" alt="提交" onclick="commit()" style="background-color: #9e123e;"><i class="fa fa-gavel"></i>提交</a></td>
			</tr>
		</table>
	</div>
</body>
</html>