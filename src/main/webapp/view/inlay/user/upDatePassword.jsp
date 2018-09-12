<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class='form-div'>
	<form method="post" class="layui-form required-validate" id="updatePasswordForm"
		lay-filter="updatePasswordForm">
		<table style="width: 100%;" class="layui-table">
			<tr>
				<td class="width-15 active form-group"><label
					class="pull-right">原始密码：</label></td>
				<td class="width-35"><input type="password" name="oldPwd" tag="原始密码"
					placeholder="请输入原始密码" class="layui-input" lay-verify="required"/></td>
			</tr>
			<tr>
				<td class="width-15 active form-group"><label
					class="pull-right">新密码：</label></td>
				<td class="width-35"><input type="password" name="newPwd" tag="新密码"
					placeholder="请输入新密码" class="layui-input" lay-verify="required"/></td>
			</tr>
			<tr>
				<td class="width-15 active form-group"><label
					class="pull-right">确认密码：</label></td>
				<td class="width-35"><input type="password" name="newPwd2" tag="确认密码"
					placeholder="请确认密码" class="layui-input" lay-verify="required"/></td>
			</tr>
		</table>
	</form>
</div>
<script>
	$(function(){
		var options={
			addUrl:"/user/json/updatePwd",//定义修改的url
			id:"updatePasswordForm",//定义表单编号,要求lay-flter也为此
			unionId:"id"//主键编号
		};
		var form=polar.form.Form(options);
		form.validate=function(that){
			var result=false;
			if(polar.form.Verification("#"+that.options.id)){
				if($('input[name="newPwd"]').val()!=$('input[name="newPwd2"]').val()){
					layer.msg("两次密码输入不一致，请重新输入!", {
						icon : 5,
						shift : 6
					});
					return false;
				}
			}else{
				return false;
			}
			return true;
		};
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
