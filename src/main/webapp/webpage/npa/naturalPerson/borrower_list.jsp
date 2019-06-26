<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>借款人列表</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/naturalPerson/borrower_list.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<body>
	<table id="borrowerList" class="easyui-datagrid" title="借款人列表"
		data-options="rownumbers:true,singleSelect:true,pagination:true,pageSize:20,fit:true,striped:true,url:'borrower.do?datagrid&field=id,name,sex,birthday,age,idNumber,phone,address,createBy,createDate',method:'post',toolbar:'#tb'">
		<thead>
			<tr>
			<th data-options="field:'ck',checkbox:true" ></th>
				<th data-options="field:'id',hidden:true">id</th>
				<th data-options="field:'name',align:'center'">姓名</th>
				<th data-options="field:'sex',align:'center',formatter:formatSex">性别</th>
				<th data-options="field:'birthday',align:'center'">出生年月</th>
				<th data-options="field:'age',align:'center'">年龄</th>
				<th data-options="field:'idNumber',align:'center'">身份证号</th>
				<th data-options="field:'phone',align:'center'">手机号</th>
				<th data-options="field:'address',align:'center'">通讯地址</th>
				<th data-options="field:'createBy',align:'center'">创建人</th>
				<th data-options="field:'createDate',align:'center'">创建时间</th>
				<th data-options="field:'opt',formatter:operate_formatter">操作</th>
			</tr>
		</thead>
	</table>

	<div id="tb" style="padding: 2px 5px;">
		<table>
			<tr>
				<td><label>姓名</label></td>
				<td><input name="name" id="name" class="easyui-textbox" style="width: 110px" /></td>
				<td><label>身份证号</label></td>
				<td><input name="idNumber" id="idNumber" class="easyui-textbox" style="width: 110px" /></td>
				<td><a id="search" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doQuery()">查询</a></td>
				<td><a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-le-back'" onclick="doClear()">清空</a></td>
			</tr>
	</div>
</body>
</html>