<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>更新错误借款合同借款人信息</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<t:base type="jquery,easyui,tools,DatePicker,validform"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/numberal.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/contract/error_updateBorrower.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<body style="width: 98%;">
	<form name="formobj" id="formobj" method="post" action="error.do?updateBorrower">
		<input type="hidden" name="ids" value="${ids }" /> <input type="hidden" name="indexs" id="indexs" value="${indexs }" /> <input type="hidden" name="sex" id="sex" value="" /> <input
			type="hidden" name="birthday" id="birthday" value="" />
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="viewtable">
			<tbody>
				<tr>
					<th><label class="required_sign">姓名</label></th>
					<td><input type="text" name="name" id="name" value="${name }" readonly="readonly" /></td>
				</tr>
				<tr>
					<th><label class="required_sign">身份证号</label></th>
					<td><input type="text" name="idNumber" id="idNumber" value="${idNumber }" maxlength="20" datatype="*" /></td>
				</tr>
				<tr>
					<th><label>地址</label></th>
					<td><input type="text" name="address" id="address" value="${address }" maxlength="30" /></td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" id="btn_sub" class="btn_sub" />
	</form>
</body>
</html>