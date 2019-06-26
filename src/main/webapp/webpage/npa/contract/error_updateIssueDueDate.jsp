<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>更新错误借款合同贷款发放日、到期日信息</title>
<t:base type="jquery,easyui,tools,DatePicker,validform"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/numberal.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/contract/error_updateIssueDueDate.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<body style="width: 98%;">
	<form name="formobj" id="formobj" method="post" action="error.do?updateIssueDueDate">
		<input type="hidden" name="id" value="${id }" /> <input type="hidden" name="index" id="index" value="${index }" />
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="viewtable">
			<tbody>
				<tr>
					<th>
						<label class="required_sign">贷款发放日</label>
					</th>
					<td><input type="text" class="Wdate"
						onClick="WdatePicker({isShowClear:false,readOnly:true,minDate:'#F{$dp.$D(\'dueDate\')}'})" name="issueDate"
						id="issueDate" value="${issueDate }" datatype="*" sucmsg="贷款发放日验证通过!" nullmsg="请输入贷款发放日!" /></td>
				</tr>
				<tr>
					<th>
						<label class="required_sign">贷款到期日</label>
					</th>
					<td><input type="text" class="Wdate"
						onClick="WdatePicker({isShowClear:false,readOnly:true,minDate:'#F{$dp.$D(\'issueDate\')}'})" name="dueDate"
						id="dueDate" value="${dueDate }" datatype="*" sucmsg="贷款到期日验证通过!" nullmsg="请输入贷款到期日!" /></td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" id="btn_sub" class="btn_sub" />
	</form>
</body>
</html>