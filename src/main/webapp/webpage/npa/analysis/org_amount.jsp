<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>查询分析统计-按支行、贷款金额</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<t:base type="jquery"></t:base>
<script type="text/javascript" src="${webRoot}/plug-in/echart/echarts.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/analysis/org_amount.js"></script>
</head>
<body>
	<div id="chart" style="width: 800px; height: 700px"></div>
</body>
</html>