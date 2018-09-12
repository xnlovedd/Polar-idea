<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class='form-div'>
	<form method="post" class="layui-form required-validate" id="menuModelForm" lay-filter="menuModelForm">
		<input type="hidden" name="id" value='${menuModel.id}' />
		<input type="hidden" name="defaultMenu" value='${menuModel.defaultMenu}' />
		<div class="layui-form-item ">
			<div class="layui-row">
				<div class="layui-inline layui-col-xs12 layui-col-sm12 layui-col-md12">
					<label class="layui-form-label polar-form-title">模板名称：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="name" placeholder="请输入模板名称" tag="模板名称" value='${menuModel.name}' vertify="required"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm12 layui-col-md12">
					<label class="layui-form-label polar-form-title">模板描述：</label>
					<div class="layui-input-block polar-form-content">
						<form:textarea name="info" vertify="required,maxLength,minLength" value="${menuModel.info}" ></form:textarea>
					</div>
				</div>
			</div>
		</div>

	</form>
</div>
<script>
	$(function(){
		var options={
			addUrl:"/menuModel/json/add",//定义新增的url
			upDateUrl:"/menuModel/json/updateAllById",//定义修改的url
			id:"menuModelForm",//定义表单编号,要求lay-flter也为此
			unionId:"id"//主键编号
		};
		var form=polar.form.Form(options);
		form.validate=function(that){
			return polar.form.Verification("#"+that.options.id);
		};
        var layedit = layui.layedit;
		form.done=function(that,layuiForm){//加载完成的回调
			that.indexs={};
            that.indexs["info2"]=layedit.build('info2'); //建立编辑器
		};
        form.beforeValidate=function(that){
            $('#info2').html(layedit.getContent(that.indexs['info2']));
            console.log( $('#info2').html());
		}
		form.onSubmit=function(that,data){
			var layedit = layui.layedit;
            console.log(data["info"]);
			return data;
		}
		form.init(form);
	});
</script>
