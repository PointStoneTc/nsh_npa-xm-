<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>更新错误借款合同其它信息</title>
<t:base type="jquery,easyui,tools,DatePicker,validform"></t:base>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/numberal.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/contract/error_other.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
</head>
<body style="width: 98%;">
	<form name="formobj" id="formobj" method="post" action="error.do?updateOther">
		<input type="hidden" name="id" value="${id }" /> <input type="hidden" name="index" id="index" value="${index }" />
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="viewtable">
			<tbody>
				<tr>
					<th>
						<label class="required_sign">利率‰</label>
					</th>
					<td><input type="text" name="interestRate" id="interestRate"
						value="<fmt:formatNumber type="number" pattern="0.000" maxFractionDigits="3" maxIntegerDigits="2" value="${interestRate }" />"
						maxlength="6" tip="千分比格式" altercss="gray" datatype="/^[1-9][0-9]?(\.\d{1,3})?$/" sucmsg="利率验证通过!" nullmsg="请输入利率!" /></td>
				</tr>
				<tr>
					<th>
						<label>信贷员</label>
					</th>
					<td><input type="text" name="officer" id="officer" value="${officer }" maxlength="15" datatype="*" sucmsg="信贷员验证通过!"
						nullmsg="请输入信贷员!" /></td>
				</tr>
				<tr>
					<th>
						<label class="required_sign">诉讼状态</label>
					</th>
					<td><select name="litigationStat" id="litigationStat" datatype="*" nullmsg="请选择诉讼状态!">
							<option value="" selected="selected">---请选择---</option>
							<option value="n">未诉讼</option>
							<option value="l">立案</option>
							<option value="f">一审</option>
							<option value="s">二审</option>
							<option value="g">再审</option>
							<option value="t">调解</option>
							<option value="e">诉讼终结</option>
							<option value="i">申请执行</option>
							<option value="a">执行</option>
							<option value="b">中止执行</option>
							<option value="c">终止本次执行</option>
							<option value="d">执行终结</option>
					</select></td>
				</tr>
				<tr>
					<th>
						<label class="required_sign">担保方式</label>
					</th>
					<td><select name="guaranteeMode" id="guaranteeMode" datatype="*" nullmsg="请选择担保方式!">
							<option value="" selected="selected">---请选择---</option>
							<option value="x">信用</option>
							<option value="b">保证</option>
							<option value="d">抵押</option>
							<option value="f">复合</option>
					</select></td>
				</tr>
				<tr>
					<th>
						<label class="required_sign">处理方式</label>
					</th>
					<td><select name="disposeMode" id="disposeMode" datatype="*" nullmsg="请选择处理方式!">
							<option value="" selected="selected">---请选择---</option>
							<option value="h">核销贷款</option>
							<option value="t">土地置换</option>
							<option value="y">央票置换</option>
					</select></td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" id="btn_sub" class="btn_sub" />
	</form>
</body>
</html>

<script type="text/javascript">
    var litigationStat = '${litigationStat}';
    var guaranteeMode = '${guaranteeMode}';
    var disposeMode = '${disposeMode}';
</script>