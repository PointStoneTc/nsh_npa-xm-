<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>消息发送记录表</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body>
	<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="tSSmsController.do?doUpdate"
		tiptype="1">
		<input id="id" name="id" type="hidden" value="${tSSmsPage.id }">
		<input id="createName" name="createName" type="hidden" value="${tSSmsPage.createName }">
		<input id="createBy" name="createBy" type="hidden" value="${tSSmsPage.createBy }">
		<input id="createDate" name="createDate" type="hidden" value="${tSSmsPage.createDate }">
		<input id="updateName" name="updateName" type="hidden" value="${tSSmsPage.updateName }">
		<input id="updateBy" name="updateBy" type="hidden" value="${tSSmsPage.updateBy }">
		<input id="updateDate" name="updateDate" type="hidden" value="${tSSmsPage.updateDate }">
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
			<tr>
				<td align="right"><label class="Validform_label"> 消息标题: </label></td>
				<td class="value"><input id="esTitle" name="esTitle" type="text" style="width: 150px" class="inputxt"
					value='${tSSmsPage.esTitle}'> <span class="Validform_checktip"></span> <label class="Validform_label"
						style="display: none;">消息标题</label></td>
			<tr>
				<td align="right"><label class="Validform_label"> 消息类型: </label></td>
				<td class="value"><t:dictSelect field="esType" typeGroupCode="msgType" hasLabel="false"
						defaultVal="${tSSmsPage.esType}"></t:dictSelect> <span class="Validform_checktip"></span> <label
						class="Validform_label" style="display: none;">消息类型</label></td>
			</tr>
			<tr>
				<td align="right"><label class="Validform_label"> 接收人: </label></td>
				<td class="value"><input id="esReceiver" name="esReceiver" type="text" style="width: 150px" class="inputxt"
					value='${tSSmsPage.esReceiver}'> <span class="Validform_checktip"></span> <label class="Validform_label"
						style="display: none;">接收人</label></td>
			</tr>
			<tr>
				<td align="right"><label class="Validform_label"> 内容: </label></td>
				<td class="value"><textarea rows="10" cols="70" id="esContent" name="esContent">${tSSmsPage.esContent}</textarea>
					<span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">内容</label></td>
			<tr>
				<td align="right"><label class="Validform_label"> 发送状态: </label></td>
				<td class="value"><t:dictSelect field="esStatus" typeGroupCode="msgStatus" hasLabel="false"
						defaultVal="${tSSmsPage.esStatus}"></t:dictSelect> <span class="Validform_checktip"></span> <label
						class="Validform_label" style="display: none;">发送状态</label></td>
			</tr>
		</table>
	</t:formvalid>
</body>