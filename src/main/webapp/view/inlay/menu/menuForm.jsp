<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class='form-div'>
	<form method="post" class="layui-form required-validate polar-form" id="menuForm" lay-filter="menuForm">
		<input type="hidden" name="id" value='${menu.id}' />
		<div class="layui-form-item ">
			<div class="layui-row">
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">上级菜单：</label>
					<div class="layui-input-block polar-form-content">
						<div class="form-group noMarginBottom">
							<form:singelTree width="220px" values="${fns:allMenusJson()}" id="menuFormParentId" name="parentId" value='${menu.parentId}' idField="id" parentIdField="parentId" nameField="text" valueField="id" textName="parentIdName"></form:singelTree>
							<span class="polar-hint">如不设置上级菜单，则会作为主目录显示</span>
						</div>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">名称：</label>
					<div class="layui-input-block polar-form-content">
						<div class="form-group noMarginBottom">
							<form:input name="name" placeholder="请输入名称" tag="名称" value='${menu.name}' vertify="required"/>
							<span class="polar-hint">菜单名称，将会在左侧显示</span>
						</div>
					</div>
				</div>

				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">排序号：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="orderNum" placeholder="请输入排序号" tag="排序号" value='${menu.orderNum}' vertify="required,number"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">默认展开：</label>
					<div class="layui-input-block polar-form-content">
						<div class="form-group noMarginBottom">
							<select name='defaultOpen'>
								<option value="0" <c:if test='${menu.defaultOpen== 0 }||${empty menu.defaultOpen}'>selected='selected'</c:if>>否</option>
								<option value="1" <c:if test='${menu.defaultOpen== 1}'>selected='selected'</c:if>>是</option>
							</select>
						</div>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">图标：</label>
					<div class="layui-input-block polar-form-content">
						<div class="form-group noMarginBottom">
							<form:input name="icon" placeholder="请输入图标" tag="图标" value='${menu.icon}' />
							<span class="polar-hint">菜单图标，具体样式请查阅Font-Awesome</span>
						</div>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">访问路径：</label>
					<div class="layui-input-block polar-form-content">
						<div class="form-group noMarginBottom">
							<form:input name="path" placeholder="请输入访问路径" tag="访问路径" value='${menu.path}' maxLength="200"/>
							<span class="polar-hint">访问路径，当菜单没有子项时，此处必须填写，否则可能会出现问题。</span>
						</div>
					</div>
				</div>
			</div>
		</div>

	</form>
</div>
<script>
	$(function(){
		var options={
			addUrl:"/menu/json/add",//定义新增的url
			upDateUrl:"/menu/json/updateAllById",//定义修改的url
			id:"menuForm",//定义表单编号,要求lay-flter也为此
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
			return data;
		}
		form.init(form);
	});
</script>
