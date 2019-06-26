<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Jeecg 微云快速开发平台</title>
<t:base type="jquery"></t:base>
<link rel="shortcut icon" href="images/favicon.ico">
<link href="plug-in/hplus/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="plug-in/hplus/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="plug-in/hplus/css/animate.css" rel="stylesheet">
<link href="plug-in/hplus/css/style.css?v=4.1.0" rel="stylesheet">
<script type="text/javascript" src="plug-in/echart/echarts.js"></script>
<script type="text/javascript" src="static/js/npa/analysis/home.js"></script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<div id="chart1" style="width: 100%; height: 700px;"></div>
		<div id="chart2" style="width: 100%; height: 700px;"></div>
		<div id="chart3" style="width: 100%; height: 700px;"></div>
	</div>
	<!-- 全局js -->
	<script src="plug-in/hplus/js/jquery.min.js?v=2.1.4"></script>
	<script src="plug-in/hplus/js/bootstrap.min.js?v=3.3.6"></script>
	<script src="plug-in/hplus/js/plugins/layer/layer.min.js"></script>
	<!-- 自定义js -->
	<script src="plug-in/hplus/js/content.js"></script>
</body>
</html>
