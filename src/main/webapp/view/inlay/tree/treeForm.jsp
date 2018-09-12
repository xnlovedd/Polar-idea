<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class='form-div'>
	<form method="post" class="layui-form required-validate polar-form" id="treeForm" lay-filter="treeForm">
		<input type="hidden" name="id" value='${tree.id}' />

		<div class="layui-form-item ">
			<div class="layui-row">
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">选择组：</label>
					<div class="layui-input-block polar-form-content">
						<form:select  emptyValue='全部' filter="groupId" itemValues="${fns:allTreeGroup()}" value='${dict.groupId}'/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">组名：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="groupName" placeholder="请输入组名" tag="组名" value='${tree.groupName}' vertify="required"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">组编号：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="groupId" placeholder="请输入组编号" tag="组编号" value='${tree.groupId}' vertify="required"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">文本内容：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="text" placeholder="请输入文本内容" tag="文本内容" value='${tree.text}' vertify="required"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">值：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="value" placeholder="请输入值" tag="值" value='${tree.value}' vertify="required"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">别名：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="textAlias" placeholder="请输入别名" tag="别名" value='${tree.textAlias}' />
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">编号：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="textId" placeholder="请输入编号" tag="编号" value='${tree.textId}' />
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">父级编号：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="parentId" placeholder="请输入父级编号" tag="父级编号" value='${tree.parentId}' />
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">类型：</label>
					<div class="layui-input-block polar-form-content">
						<select name='type'>
							<option value="1"
									<c:if test='${tree.type== 1}'>selected='selected'</c:if>>编码类型</option>
							<option value="2"
									<c:if test='${tree.type== 2}'>selected='selected'</c:if>>父子编号类型</option>
						</select>
					</div>
				</div>



			</div>
		</div>
	</form>
</div>
<script>
	$(function(){
		var options={
			addUrl:"/tree/json/add",//定义新增的url
			upDateUrl:"/tree/json/updateAllById",//定义修改的url
			id:"treeForm",//定义表单编号,要求lay-flter也为此
			unionId:"id"//主键编号
		};
		var form=polar.form.Form(options);
		form.validate=function(that){
		return polar.form.Verification("#"+that.options.id);
		};
		form.done=function(that,layuiForm){//加载完成的回调
		
		var layedit = layui.layedit;
		that.indexs={};
		layuiForm.on('select(groupId)', function(data) {
			var value = data.value;
			var name=$(data.othis).find("dl .layui-this").html();
			$("#treeForm input[name='groupName']").val(name);
			$("#treeForm input[name='groupId']").val(value);
		});
		};
		form.onSubmit=function(that,data){
			var layedit = layui.layedit;
			return data;
		}
		form.init(form);
	});
</script>
