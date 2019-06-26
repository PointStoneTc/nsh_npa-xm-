<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>合同数据导入初始化</title>
<t:base type="jquery,tools"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/sysInit/loancontract_excel_upload.js"></script>
</head>
<body style="overflow-y: hidden" scroll="no">
	<fieldset class="step">
		<div class="form">
			<t:upload name="fiels" width="120" buttonText="选择要导入的文件" uploader="sysInit.do?importExcel" extend="*.xls;*.xlsx" id="file_upload" formData="documentTitle" dialog="false"
				callback="callBack" />
		</div>
		<div class="form" id="filediv" style="height: 50px"></div>
	</fieldset>
</body>
</html>