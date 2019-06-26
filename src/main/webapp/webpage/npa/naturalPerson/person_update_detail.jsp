<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>借款人/担保人信息修改</title>
<t:base type="jquery,easyui,tools,validform"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript"
	src="${webRoot}/static/js/npa/naturalPerson/person_update_detail.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<body style="width: 97%;">
	<form name="formobj" id="formobj" method="post"
		action="borrower.do?saveOrUpdate">
		<div id="borrower_table">
			<table style="width: 100%;" cellpadding="0" cellspacing="1"
				class="viewtable">
				<input type="hidden" name="id" id="id" value="${person.id }" />
				<tbody>
					<tr>
						<th><label>姓名</label></th>
						<td><input type="text" name="name" value="${person.name}"
							maxlength="50" datatype="*" sucmsg="姓名验证通过!" nullmsg="请输入姓名!" /></td>
					</tr>
					<tr>
						<th><label>身份证号</label></th>
						<td><input type="text" name="idNumber" id="idNumber"
							value="${person.idNumber }" maxlength="18" datatype="*"
							sucmsg="身份证号验证通过!" nullmsg="请输入身份证号!" /></td>
					</tr>
					<tr>
						<th><label>出生年月</label></th>
						<td><input type="text" name="birthday"
							value="${person.birthday }" readonly="readonly" /></td>
					<tr>
						<th><label>年龄</label></th>
						<td><input type="text" name="age" value="${person.age }"
							readonly="readonly" /></td>
					<tr>
						<th><label>性别</label></th>
						<td><input type="radio" name="sex" value="m"
							onclick="return false;" readonly="readonly"
							<c:if test="${person.sex == 'm' }">checked="checked"</c:if>>男<input
							type="radio" name="sex" value="f" onclick="return false;"
							readonly="readonly"
							<c:if test="${person.sex == 'f' }">checked="checked"</c:if>>女</td>
					</tr>
					<tr>
						<th><label>手机号码</label></th>
						<td><input type="text" name="phone" value="${person.phone }"
							maxlength="11" datatype="m" ignore="ignore" sucmsg="手机号码验证通过!"
							nullmsg="请输入手机号码!" /></td>
					</tr>
					<tr>
						<th><label>通讯地址</label></th>
						<td><input type="text" name="address"
							value="${person.address }" maxlength="50" /></td>
					</tr>
				</tbody>
			</table>
			<input type="hidden" id="btn_sub" class="btn_sub" />
	</form>
</body>
</html>