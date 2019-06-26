<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>合同数据导入初始化</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript"
	src="${webRoot}/static/js/npa/currencyformat.js"></script>
<script type="text/javascript"
	src="${webRoot}/static/js/npa/numberal.js"></script>
<script type="text/javascript" src="${webRoot}/static/js/npa/common.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/tools/Map.js"></script>
<script type="text/javascript"
	src="${webRoot}/static/js/npa/sysInit/loancontract_index.js"></script>
<link rel="stylesheet" href="${webRoot}/static/style/css/commcon.css">
<link rel="stylesheet" href="${webRoot}/static/style/css/sysInit.css">
</head>
<body class="easyui-layout">
	<div data-options="region:'south',border:false"
		style="height: 50px; background: #A9FACD; padding: 10px;">
		<label class="msgtitle">消息:</label> <label class="msgcontent"></label>
	</div>
	<div data-options="region:'west'" title="按步骤操作" style="width: 475px;">
		<table style="width: 100%;" cellpadding="0" cellspacing="1"
			class="viewtable">
			<tr>
				<th width="100px"><label class="required_sign">(第1步)</label></th>
				<td><select name="corporateOrgId" id="corporateOrgId">
						<option value="" selected="selected">---请选择---</option>
						<c:forEach items="${dictOrg}" var="item" varStatus="status">
							<option value="${item.id }">${item.nameShorter }</option>
						</c:forEach>
				</select></td>
				<td><div class="check_ok" id="step1_state"></div></td>
			</tr>
			<tr>
				<th><label class="required_sign">(第2步)</label></th>
				<td><a id="upload" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-put',disabled:true" onclick="upload()">上传Excel文件</a><a
					id="reload" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-reload'" onclick="reloadTable()">刷新导入数据</a></td>
				<td><div class="check_ok"></div></td>
			</tr>
			<tr>
				<th><label class="required_sign">(第3步)</label></th>
				<td>
					<div>
						<ul class="checkstep">
							<li id="step1"><a href="#"><div class="serial_number">1</div>
									<div class="title">(档案号)不为空,并且唯一性校验</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step2"><a href="#"><div class="serial_number">2</div>
									<div class="title">(借据号)唯一性校验</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step3"><a href="#"><div class="serial_number">3</div>
									<div class="title">(借款人)姓名不为空</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step4"><a href="#"><div class="serial_number">4</div>
									<div class="title">(借款人)身份证不为空,有效性校验</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step5"><a href="#"><div class="serial_number">5</div>
									<div class="title">(担保人)格式、身份证有效性校验</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step6"><a href="#"><div class="serial_number">6</div>
									<div class="title">(贷款金额)不为空,格式校验</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step7"><a href="#"><div class="serial_number">7</div>
									<div class="title">(贷款发放日)不为空</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step8"><a href="#"><div class="serial_number">8</div>
									<div class="title">(贷款到期日)不为空,逻辑性校验</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step9"><a href="#"><div class="serial_number">9</div>
									<div class="title">(利率)不为空,格式校验</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step10"><a href="#"><div class="serial_number">10</div>
									<div class="title">(信贷员)不为空</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step11"><a href="#"><div class="serial_number">11</div>
									<div class="title">(所属支行)不为空,逻辑性校验</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step12"><a href="#"><div class="serial_number">12</div>
									<div class="title">(诉讼状态)不为空,逻辑性校验</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step13"><a href="#"><div class="serial_number">13</div>
									<div class="title">(担保方式)不为空,逻辑性校验</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step14"><a href="#"><div class="serial_number">14</div>
									<div class="title">(处理方式)不为空,逻辑性校验</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step15"><a href="#"><div class="serial_number">15</div>
									<div class="title">(起息日)逻辑性校验</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step16"><a href="#"><div class="serial_number">16</div>
									<div class="title">(收回本金)逻辑性校验</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
							<li id="step17"><a href="#"><div class="serial_number">17</div>
									<div class="title">(状态)不为空,逻辑性校验</div>
									<div class="error_msg"></div>
									<div class="check_ok"></div></a></li>
						</ul>
					</div>
				</td>
				<td><div class="check_ok"></div></td>
			</tr>
			<tr>
				<th><label class="required_sign">(第4步)</label></th>
				<td><a id="createResult" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-edit',disabled:true"
					onclick="createResult()">生成结果</a></td>
				<td><div class="check_ok"></div></td>
			</tr>
			<tr>
				<th><label class="required_sign">(第5步)</label></th>
				<td><a id="insertDataBase" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-save',disabled:true"
					onclick="insertDataBase()">导入数据库</a></td>
				<td><div class="check_ok"></div></td>
			</tr>
			<tr>
		</table>
	</div>
	<div data-options="region:'center'">
		<div class="easyui-tabs" data-options="fit:true">
			<!-- start 原始导入借款合同列表 -->
			<div title="原始导入借款合同列表" style="padding: 10px">
				<table id="ltList" name="ltList"
					data-options="rownumbers:true,fit:true,striped:true,url:'loancontract.do?ltDatagrid&field=id,isSubmit,numCode,customerNo,louNo,borrowerName,borrowerNumber,isImpersonate,guarantees,amount,issueDate,dueDate,interestRate,officer,corporateOrgName,litigationStat,guaranteeMode,disposeMode,stat,interestDate,recoveryPrincipal,recoveryInterest,hangInteres,numCodeCountSelf,louNoCountSelf,realNumCode',method:'get'">
					<thead>
						<tr>
							<th data-options="field:'id',hidden:true" rowspan="2">id</th>
							<th data-options="field:'numCodeCountSelf',hidden:true"
								rowspan="2">id</th>
							<th data-options="field:'louNoCountSelf',hidden:true" rowspan="2">id</th>
							<th data-options="field:'realNumCode',hidden:true" rowspan="2">id</th>
							<th
								data-options="field:'numCode',align:'center',formatter:fmt_nc,styler:cs_nc"
								rowspan="2">档案编号</th>
							<th data-options="field:'customerNo',align:'center'" rowspan="2">客户号</th>
							<th
								data-options="field:'louNo',align:'center',formatter:fmt_ln,styler:cs_ln"
								rowspan="2">借据号</th>
							<th colspan="2">借款人</th>
							<th
								data-options="field:'guarantees',align:'center',formatter:fmt_gs,styler:cs_gs"
								rowspan="2">担保人</th>
							<th colspan="9">贷款信息</th>
							<th colspan="4">收回款信息</th>
							<th
								data-options="field:'stat',align:'center',formatter:fmt_st,styler:cs_st"
								rowspan="2">状态</th>
						</tr>
					</thead>
					<thead>
						<tr>
							<th
								data-options="field:'borrowerName',align:'center',formatter:fmt_bn,styler:cs_bn">姓名</th>
							<th
								data-options="field:'borrowerNumber',align:'center',formatter:fmt_bnr,styler:cs_bnr">身份证号</th>
							<th
								data-options="field:'amount',align:'center',formatter:fmt_at,styler:cs_at">贷款金额(元)</th>
							<th
								data-options="field:'issueDate',align:'center',formatter:fmt_id,styler:cs_id">贷款发放日</th>
							<th
								data-options="field:'dueDate',align:'center',formatter:fmt_dd,styler:cs_dd">贷款到期日</th>
							<th
								data-options="field:'interestRate',align:'center',formatter:fmt_ir,styler:cs_ir">利率(‰)</th>
							<th
								data-options="field:'officer',align:'center',formatter:fmt_of,styler:cs_of">信贷员</th>
							<th
								data-options="field:'corporateOrgName',align:'center',formatter:fmt_on,styler:cs_on">所属支行</th>
							<th
								data-options="field:'litigationStat',align:'center',formatter:fmt_ls,styler:cs_ls">诉讼状态</th>
							<th
								data-options="field:'guaranteeMode',align:'center',formatter:fmt_gm,styler:cs_gm">担保方式</th>
							<th
								data-options="field:'disposeMode',align:'center',formatter:fmt_dm,styler:cs_dm">处理方式</th>
							<th
								data-options="field:'interestDate',align:'center',formatter:fmt_ind,styler:cs_ind">起息日</th>
							<th
								data-options="field:'recoveryPrincipal',align:'center',formatter:fmt_rp,styler:cs_rp">收回本金(元)</th>
							<th
								data-options="field:'recoveryInterest',align:'center',formatter:formatMoney">收回利息(元)</th>
							<th
								data-options="field:'hangInteres',align:'center',formatter:formatMoney">挂息(元)</th>
						</tr>
					</thead>
				</table>

				<div id="tb1" style="padding: 2px 5px;"></div>
			</div>
			<!-- end 原始导入借款合同列表 -->
			<div title="生成的结果数据" style="padding: 10px">
				<div
					style="width: 300px; height: 100%; float: left; margin-right: 10px">
					<table id="brList" name="brList" class="easyui-datagrid"
						title="借款人清单"
						data-options="singleSelect:true,rownumbers:true,fit:true,striped:true,url:'loancontract/borrower.do?datagrid&field=name,idNumber,existing',method:'get'">
						<thead>
							<tr>
								<th data-options="field:'name',align:'center'">姓名</th>
								<th data-options="field:'idNumber',align:'center'">身份证号</th>
								<th
									data-options="field:'existing',align:'center', formatter:formatExisting">是否导入</th>
							</tr>
						</thead>
					</table>
				</div>

				<div
					style="width: 300px; height: 100%; float: left; margin-right: 10px">
					<table id="guList" name="guList" class="easyui-datagrid"
						title="担保人清单"
						data-options="singleSelect:true,rownumbers:true,fit:true,striped:true,url:'loancontract/guarantee.do?datagrid&field=name,idNumber,existing',method:'get'">
						<thead>
							<tr>
								<th data-options="field:'name',align:'center'">姓名</th>
								<th data-options="field:'idNumber',align:'center'">身份证号</th>
								<th
									data-options="field:'existing',align:'center', formatter:formatExisting">是否导入</th>
							</tr>
						</thead>
					</table>
				</div>

				<div style="width: 300px; height: 100%; float: left">
					<table id="idFixList" name="idFixList" class="easyui-datagrid"
						title="身份号相同姓名不同清单"
						data-options="singleSelect:true,rownumbers:true,fit:true,striped:true,url:'loancontract/idnumberFix.do?datagrid&field=name,idNumber',method:'get'">
						<thead>
							<tr>
								<th data-options="field:'name',align:'center'">姓名</th>
								<th data-options="field:'idNumber',align:'center'">身份证号</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>