<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>选择用户</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body>
	<table id="userList" class="easyui-datagrid" title="用户列表"
		data-options="rownumbers:true,singleSelect:true,fit:true,pagination:true,url:'select.do?oneDatagrid&orgId=${orgId }&field=id,realName,userName',method:'post'">
		<thead>
			<tr>
				<th data-options="field:'id',hidden:true">id</th>
				<th data-options="field:'realName',align:'center'">姓名</th>
				<th data-options="field:'userName',align:'center'">账号</th>
			</tr>
		</thead>
	</table>
</body>
</html>

<script type="text/javascript">
  function getAllBasic() {
    var row = $('#userList').datagrid('getSelected');
    if (row == null) return '';
    return row;
  }
</script>