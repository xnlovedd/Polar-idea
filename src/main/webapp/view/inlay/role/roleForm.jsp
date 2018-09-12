<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class='form-div'>
	<form method="post" class="layui-form required-validate polar-form" id="roleForm" lay-filter="roleForm">
		<input type="hidden" name="id" value='${role.id}' />

		<div class="layui-form-item ">
			<div class="layui-row">
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">上级角色：</label>
					<div class="layui-input-block polar-form-content">
						<form:singelTree values="${fns:allRolesJson()}" id="roleFormParentId" name="parentId" value='${role.parentId}' idField="id" parentIdField="parentId" nameField="text" valueField="id" textName="parentIdName"></form:singelTree>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">角色标识：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="name" placeholder="请输入角色标识" tag="角色标识" value='${role.name}' vertify="required"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">角色名称：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="text" placeholder="请输入角色名称" tag="角色名称" value='${role.text}' vertify="required"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">排序：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="orderNum" placeholder="请输入排序" tag="排序" value='${role.orderNum}' vertify="required,number"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm12 layui-col-md12">
					<label class="layui-form-label polar-form-title">角色描述：</label>
					<div class="layui-input-block polar-form-content">
						<textarea id="info" class="layui-textarea">${role.info}</textarea>
					</div>
				</div>
			</div>
		</div>

	</form>
</div>
<script>
	$(function(){
		var options={
			addUrl:"/role/json/add",//定义新增的url
			upDateUrl:"/role/json/updateAllById",//定义修改的url
			id:"roleForm",//定义表单编号,要求lay-flter也为此
			unionId:"id"//主键编号
		};
		var form=polar.form.Form(options);
		form.validate=function(that){
			return polar.form.Verification("#"+that.options.id);
		};
		form.done=function(that,layuiForm){//加载完成的回调
			var layedit = layui.layedit;
			that.indexs={};
		};
		form.onSubmit=function(that,data){
			var layedit = layui.layedit;
			data["info"]=$("#info").val();
			return data;
		}
		form.init(form);
	});
</script>
