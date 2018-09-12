<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class='form-div' id="dicteditFormDiv">
	<form method="post" class="layui-form required-validate polar-form" id="dicteditForm" lay-filter="dicteditForm">
		<input type="hidden" name="id" value='${dict.id}' />
		<div class="layui-form-item ">
			<div class="layui-row">
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">选择组：</label>
					<div class="layui-input-block polar-form-content">
						<form:select  emptyValue='全部' filter="groupId" itemValues="${fns:allGroup()}" value='${dict.groupId}'/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">组名：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="groupName" placeholder="请输入组名" tag="组名" value='${dict.groupName}' vertify="required"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">组编号：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="groupId" placeholder="请输入组编号" tag="组编号" value='${dict.groupId}' vertify="required"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">文本内容：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="text" placeholder="请输入文本内容" tag="文本内容" value='${dict.text}' vertify="required"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">值：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="value" placeholder="请输入值" tag="值" value='${dict.value}' vertify="required"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">备注：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="remark" placeholder="请输入备注" tag="备注" value='${dict.remark}' />
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">排序号：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="orderNum" placeholder="请输入排序号" tag="排序号" value='${dict.orderNum}' vertify="required,number"/>
					</div>
				</div>
			</div>
		</div>

	</form>
</div>
<script>
	$(function(){
		var options={
			addUrl:"/dict/json/add",//定义新增的url
			upDateUrl:"/dict/json/updateAllById",//定义修改的url
			id:"dicteditForm",//定义表单编号,要求lay-flter也为此
			unionId:"id"//主键编号
		};
		var form=polar.form.Form(options);
		form.done=function(that,layuiForm){//加载完成的回调
			layuiForm.on('select(groupId)', function(data) {
				var value = data.value;
				var name=$(data.othis).find("dl .layui-this").html();
				$("#dicteditForm input[name='groupName']").val(name);
				$("#dicteditForm input[name='groupId']").val(value);
			});
		};
		form.init(form);
	});
</script>
