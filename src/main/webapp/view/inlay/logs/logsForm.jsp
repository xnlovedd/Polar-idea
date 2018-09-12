<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class='form-div' id="logseditFormDiv"
	style="background-color: white; height: 100%; width: calc(100% - 10px);">
	<form method="post" class="layui-form required-validate  polar-form" id="logseditForm" lay-filter="logseditForm">
		<input type="hidden" name="id" value='${logs.id}' />
		<input type="hidden" name="createTimeMillions" value='${logs.createTimeMillions}' />
		<div class="layui-form-item ">
			<div class="layui-row">
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">登录用户：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="userId" placeholder="请输入当前登录用户" tag="当前登录用户" value='${logs.userId}' />
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">发生时间：</label>
					<div class="layui-input-block polar-form-content">
						<form:inputTime name="createTime" placeholder="请输入发生时间" cache="true" type="datetime" format="yyyy-MM-dd HH:mm:ss" tag="创建时间" value='${fns:formatDateTimeCustom(logs.createTime,"yyyy-MM-dd HH:mm:ss")}'  />
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">接口名称：</label>
					<div class="layui-input-block polar-form-content">
						<form:input  placeholder="请输入接口名称" tag="接口名称" value='${logs.interfaceName}' />
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm12 layui-col-md12">
					<label class="layui-form-label polar-form-title">错误信息：</label>
					<div class="layui-input-block polar-form-content">
						<textarea id="message" style="min-height: 50px;" class="layui-textarea">${logs.message}</textarea>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm12 layui-col-md12">
					<label class="layui-form-label polar-form-title">引起的原因：</label>
					<div class="layui-input-block polar-form-content">
						<textarea id="caseBy" style="min-height: 250px;" class="layui-textarea">${logs.caseBy}</textarea>
					</div>
				</div>
			</div>
		</div>

	</form>
</div>
<script>
	var indexs={};
	var uploads={};
	function init() {
		var layedit = layui.layedit;
		layui.form.render(null,'logseditForm'); //更新全部
	}
	function validateDate(){
		return Verification('#logseditForm');
	}
	function submit(index) {
		if(validateDate()){
			//提交表单
			var id=$("input[name='id']").val();
			var url="/logs/json/add";
			if(id!=null && id!='undefined' && id!=''){
				url="/logs/json/updateAllById";
			}
			var m =$("#logseditForm").serializeArray();
			var data = {};
			for ( var p in m) {
				var va = m[p].value;
				if (va != null && va != 'undefined' && va != '') {
					data[ m[p].name] = m[p].value;
				}
			}
			var layedit = layui.layedit;
			data["message"]=$("#message").val();
			data["caseBy"]=$("#caseBy").val();
			var succseCall = function(dataUrl, title, successData, flag,
					contentType, args) {
				if (flag) {
					loadFinish();
				}
				successData = JSON.parse(successData);
				if (successData.code != successCode) {
					if(!checkLogin(successData)){
						alertMessage("提示", successData.msg);
					}
				
				} else {
					if(id!=null && id!='undefined' && id!=''){
						showToast('修改日志记录表成功');
					}else{
						showToast('新增日志记录表成功');
					}
					layer.close(index);
					refreshTable();
				}
			}
			var errorCall = function(XMLHttpRequest, textStatus, errorThrown,
					flag, args) {
				if (flag) {
					loadFinish();
				}
				alertMessage('提示', "网络异常，请检查您的网络连接方式.");
			}
			loadData(succseCall, errorCall, url, null, true, null, data);
		}
	}
	init();
</script>
