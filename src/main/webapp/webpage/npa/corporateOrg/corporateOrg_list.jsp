<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>法人组织机构列表</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/corporateOrg/corporateOrg_list.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<body class="easyui-layout">
	<div region="center" style="padding: 0px; border: 0px">
		<table id="corporateOrgList" class="easyui-datagrid" title="法人组织机构列表"
			data-options="rownumbers:true,singleSelect:true,fit:true,striped:true,url:'corporateOrg.do?datagrid&field=id,name,nameShorter,address,code,phone,isEffect',method:'post',toolbar:'#tb'">
			<thead>
				<tr>
					<th data-options="field:'id',hidden:true">id</th>
					<th data-options="field:'name',align:'center'">全称</th>
					<th data-options="field:'nameShorter',align:'center'">简称</th>
					<th data-options="field:'address',align:'center'">地址</th>
					<th data-options="field:'code',align:'center'">单位代码</th>
					<th data-options="field:'phone',align:'center'">电话</th>
					<th data-options="field:'name',align:'center'">名称</th>
					<th data-options="field:'isEffect',align:'center',formatter:formatRw">是否生效</th>
					<th data-options="field:'opt',formatter:operate_formatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	<div style="width: 300px;" data-options="region:'east',split:true">
		<table id="corporateOrgOperatorList" class="easyui-datagrid" title="操作员列表"
			data-options="rownumbers:true,singleSelect:true,fit:true,striped:true,url:'corporateOrg/operator.do?datagrid&field=id,userid,userName',method:'post'">
			<thead>
				<tr>
					<th data-options="field:'id',hidden:true">id</th>
					<th data-options="field:'userid',hidden:true">userid</th>
					<th data-options="field:'userName',align:'center'">姓名</th>
					<th data-options="field:'opt',formatter:operate_opt_formatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>

	<form>
		<input type="hidden" name="parentId" id="parentId" />
	</form>
</body>
</html>