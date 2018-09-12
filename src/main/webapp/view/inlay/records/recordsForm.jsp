<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class='form-div'>
	<form method="post" class="layui-form required-validate polar-form" id="recordsForm" lay-filter="recordsForm">
		<input type="hidden" name="id" value='${records.id}' />
		<div class="layui-form-item ">
			<div class="layui-row">
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">页面名称：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="pageName" placeholder="请输入页面名称" tag="页面名称" value='${records.pageName}' />
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">访问路径：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="vistUrl" placeholder="请输入访问路径" tag="访问路径" value='${records.vistUrl}' vertify="required"/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">访问平台：</label>
					<div class="layui-input-block polar-form-content">
						<select >
							<option >全部</option>
							<option value="1"
									<c:if test='${records.vistPlatform== 1}'>selected='selected'</c:if>>电脑</option>
							<option value="2"
									<c:if test='${records.vistPlatform== 2}'>selected='selected'</c:if>>手机</option>
							<option value="-1"
									<c:if test='${records.vistPlatform== -1}'>selected='selected'</c:if>>未知</option>
						</select>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">访问时间：</label>
					<div class="layui-input-block polar-form-content">
						<form:inputTime id="vistDateForm" name="vistDate" placeholder="请输入访问时间" cache="true" format="yyyy-MM-dd HH:mm:ss"  tag="访问时间" value='${fns:formatDateTimeCustom(records.vistDate,"yyyy-MM-dd HH:mm:ss")}'/>
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">访问人：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="vistPeople" placeholder="请输入访问人" tag="访问人" value='${empty records.vistPeople ?"匿名用户" : records.vistUrl}' />
					</div>
				</div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
					<label class="layui-form-label polar-form-title">访问地址：</label>
					<div class="layui-input-block polar-form-content">
						<form:input name="vistIp" placeholder="访问地址" tag="访问地址" value='${records.vistIp}' />
					</div>
				</div>
			</div>
		</div>


	</form>
</div>
<script>
	$(function(){
		var options={
			addUrl:"/records/json/add",//定义新增的url
			upDateUrl:"/records/json/updateAllById",//定义修改的url
			id:"recordsForm",//定义表单编号,要求lay-flter也为此
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
