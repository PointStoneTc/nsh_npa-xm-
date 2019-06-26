<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>借款合同登记收回款初始化</title>
<t:base type="jquery,easyui,tools,DatePicker,validform"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/numberal.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/contract/register_initRecoveryMoney.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<body style="width: 98%;">
	<form name="formobj" id="formobj" method="post" action="register.do?updateInitRecoveryMoney">
		<input type="hidden" name="id" value="${loanContract.id }" /> <input type="hidden" name="index" id="index" value="${index }" />
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="viewtable">
			<tbody>
				<tr>
					<th><label class="required_sign">收回本金</label></th>
					<td><input type="text" name="recoveryPrincipal" id="recoveryPrincipal" value="${loanContract.recoveryPrincipal }" maxlength="12" datatype="currency" ignore="ignore"
						sucmsg="收回本金验证通过!" /></td>
				</tr>
				<tr>
					<th><label class="required_sign">收回利息</label></th>
					<td><input type="text" name="recoveryInterest" id="recoveryInterest" value="${loanContract.recoveryInterest }" maxlength="12" datatype="currency" ignore="ignore"
						sucmsg="收回利息验证通过!" /></td>
				</tr>
				<tr>
					<th><label>挂息</label></th>
					<td><input type="text" name="hangInteres" id="hangInteres" value="${loanContract.hangInteres }" maxlength="12" datatype="currency" ignore="ignore" sucmsg="挂息验证通过!" /></td>
				</tr>
				<tr>
					<th><label>起息日</label></th>
					<td><input type="text" class="Wdate"
						onClick="WdatePicker({isShowClear:false,readOnly:true,minDate:'${loanContract.issueDate}', maxDate:'${loanContract.dueDate}'})" name="interestDate"
						id="interestDate" datatype="*" ignore="ignore" sucmsg="起息日验证通过!" readonly="readonly" /></td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" id="btn_sub" class="btn_sub" />
	</form>
</body>
</html>