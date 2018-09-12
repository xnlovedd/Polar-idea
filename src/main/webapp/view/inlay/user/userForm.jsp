<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class='form-div'>
	<form method="post" class="layui-form required-validate polar-form" id="userForm" lay-filter="userForm">
		<input type="hidden" name="id" value='${user.id}' />

		<div class="layui-form-item ">
			<div class="layui-row">
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">用户名：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="userName" placeholder="请输入用户名" tag="用户名" value='${user.userName}' vertify="required"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">所属部门：</label>
					<div class="layui-input-block polar-form-content">
						<form:singelTree values="${org_allEntities}" id="orgId" name="orgId" value='${user.orgId}'  idField="id" parentIdField="parentId" nameField="name" valueField="id" ></form:singelTree>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">邮箱：</label>
					<div class="layui-input-block">
						<form:input name="email" placeholder="请输入邮箱" tag="邮箱" value='${user.email}' vertify="email"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">昵称：</label>
					<div class="layui-input-block">
						<form:input name="nickName" placeholder="请输入昵称" tag="昵称" value='${user.nickName}' />
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">手机号：</label>
					<div class="layui-input-block">
						<form:input name="phone" placeholder="请输入手机号" tag="手机号" value='${user.phone}' vertify="phone"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm12 layui-col-md12">
					<label class="layui-form-label polar-form-title">头像：</label>
					<div class="layui-input-block">
						<form:img name="headUrl" value="${user.headUrl}"></form:img>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<script>
	$(function(){
		var options={
			addUrl:"/user/json/add",//定义新增的url
			upDateUrl:"/user/json/updateAllById",//定义修改的url
			id:"userForm",//定义表单编号,要求lay-flter也为此
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
			return data;
		}
		form.init(form);
	});
</script>
