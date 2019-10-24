<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>自然人列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<t:base type="jquery,easyui"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/naturalPerson/selectOnePerson_dialog.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<body>
	<table id="personList" class="easyui-datagrid"
		data-options="rownumbers:true,singleSelect:true,pagination:true,pageSize:20,fit:true,url:'select.do?oneDatagrid&excludeIdNumbers=${excludeIdNumbers}&field=id,name,sex,birthday,age,idNumber,phone,address',method:'post',toolbar:'#tb'">
		<thead>
			<tr>
				<th data-options="field:'id',hidden:true">id</th>
				<th data-options="field:'name',align:'center'">姓名</th>
				<th data-options="field:'sex',align:'center',formatter:formatSex">性别</th>
				<th data-options="field:'idNumber',align:'center'">身份证号</th>
				<th data-options="field:'birthday',align:'center'">出生年月</th>
				<th data-options="field:'phone',align:'center'">电话</th>
				<th data-options="field:'address',align:'left'">通讯地址</th>
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
		</table>
	</div>
</body>
</html>