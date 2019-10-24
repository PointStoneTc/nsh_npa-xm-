<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>更新错误借款合同担保人信息</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<t:base type="jquery,easyui,tools,DatePicker,validform"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/numberal.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/contract/error_updateGuarantee.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<body style="width: 98%;">
	<form name="formobj" id="formobj" method="post" action="error.do?updateGuarantee">
		<input type="hidden" name="id" value="${id }" /> <input type="hidden" name="index" id="index" value="${index }" />
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="viewtable" id="ctable">
			<tbody>
				<c:forEach items="${guaranteesNames }" var="item" varStatus="status">
					<tr>
						<th><label class="required_sign">姓名</label></th>
						<td><input type="text" name="guaranteesNames" id="guaranteesNames" value="${item }" maxlength="50" datatype="*" sucmsg="姓名验证通过!" nullmsg="请输入姓名!" /></td>
						<th><label class="required_sign">身份证号</label></th>
						<td><input type="text" name="guaranteesIdNumbers" id="guaranteesIdNumbers" value="${guaranteesIdNumbers[status.index] }" maxlength="20" datatype="*" /></td>
						<th><label>地址</label></th>
						<td><input type="text" name="guaranteesAddresses" id="guaranteesAddresses" value="${guaranteesAddresses[status.index] }" maxlength="20" /></td>
						<th><a href="#" id="delPerson" class="ace_button" alt="删除" onclick="delPerson(this)" style="background-color: #9e123e;"><i class="fa fa-trash-o"></i>删除担保人</a></th>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<a href="#" id="addPerson" class="ace_button" alt="新增" onclick="addPerson()" style="background-color: #129e1e;"><i class="fa fa-gavel"></i>新增担保人</a> <input type="hidden"
			id="btn_sub" class="btn_sub" />
	</form>
</body>
</html>