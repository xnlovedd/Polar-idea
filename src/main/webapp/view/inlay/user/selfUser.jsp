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
						<input type="text" name="userName" placeholder="请输入用户名" class="layui-input" disabled="disabled" value="${user.userName}"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">邮箱：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="email" placeholder="请输入邮箱" tag="邮箱" value='${user.email}' vertify="email"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">昵称：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="nickName" placeholder="请输入昵称" tag="昵称" value='${user.nickName}' />
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">手机号：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="phone" placeholder="请输入手机号" tag="手机号" value='${user.phone}' vertify="phone"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm12 layui-col-md12">
					<label class="layui-form-label polar-form-title">头像：</label>
					<div class="layui-input-block polar-form-content">
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
			upDateUrl:"/user/json/updateSelf",//定义修改的url
			id:"userForm",//定义表单编号,要求lay-flter也为此
			unionId:"id"//主键编号
		};
		var form=polar.form.Form(options);

		form.done=function(that,layuiForm){//加载完成的回调
			var layedit = layui.layedit;
			that.indexs={};
		};
		form.onSubmit=function(that,data){

			return data;
		}
		form.onSubmitOptions=function(args,that){
			args.refresh=false;
			args.onRequestOk=function(){
				$('.polar-nickname img').attr('src',$('#userForm input[name="headUrl"]').val());
				$('.polar-nickname span').html($('#userForm input[name="nickName"]').val());
			}
			return args;
		}
		form.init=function(that){//初始化
			var form = layui.form;
			that.done(that,form);
			polar.form.targetCurrent = that;//增加一个参数来保存当前对象
			form.render(null,that.options.id); //更新全部
		};
		form.init(form);
	});
</script>
