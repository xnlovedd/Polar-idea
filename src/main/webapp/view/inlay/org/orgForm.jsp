<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class='form-div'>
	<form method="post" class="layui-form required-validate polar-form" id="orgForm" lay-filter="orgForm">
		<input type="hidden" name="id" value='${org.id}' />
        <div class="layui-form-item ">
            <div class="layui-row">
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
                    <label class="layui-form-label polar-form-title">机构名称：</label>
                    <div class="layui-input-block polar-form-content">
					<form:input name="name" placeholder="请输入机构名称"   tag="机构名称" value='${org.name}' vertify="maxLength,minLength,required"/>
                    </div>
                </div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
                    <label class="layui-form-label polar-form-title">上级部门：</label>
                    <div class="layui-input-block polar-form-content">
					<form:singelTree values="${org_allEntities}" id="parentId" name="parentId" value='${org.parentId}'  idField="id" parentIdField="parentId" nameField="name" valueField="id" ></form:singelTree>
                    </div>
                </div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
                    <label class="layui-form-label polar-form-title">机构编码：</label>
                    <div class="layui-input-block polar-form-content">
                        <c:choose >
                            <c:when test="${not empty org.id}">
                                <form:input name="orgCode" placeholder="请输入机构编码" readonly="readonly" tag="机构编码" value='${org.orgCode}' vertify="maxLength,minLength,required"/>
                            </c:when>
                            <c:otherwise>
                                <form:input name="orgCode" placeholder="请输入机构编码"  tag="机构编码" value='${org.orgCode}' vertify="maxLength,minLength,required"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
				<div class="layui-inline layui-col-xs12 layui-col-sm12 layui-col-md12">
                    <label class="layui-form-label polar-form-title">机构介绍：</label>
                    <div class="layui-input-block polar-form-content">
					<form:textarea name="orgDescribe"    tag="机构介绍" value='${org.orgDescribe}' vertify="maxLength,minLength,required"/>
                    </div>
                </div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
                    <label class="layui-form-label polar-form-title">联系人：</label>
                    <div class="layui-input-block polar-form-content">
					<form:input name="contactPeople" placeholder="请输入联系人"   tag="联系人" value='${org.contactPeople}' vertify="maxLength,minLength"/>

                    </div>
                </div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
                    <label class="layui-form-label polar-form-title">联系电话：</label>
                    <div class="layui-input-block polar-form-content">
					<form:input name="contactPhone" placeholder="请输入联系电话"   tag="联系电话" value='${org.contactPhone}' vertify="maxLength,minLength,phone"/>

                    </div>
                </div>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
                    <label class="layui-form-label polar-form-title">联系邮箱：</label>
                    <div class="layui-input-block polar-form-content">
					<form:input name="contactEmail" placeholder="请输入联系邮箱"   tag="联系邮箱" value='${org.contactEmail}' vertify="maxLength,minLength,email"/>

                    </div>
                </div>
            </div>
         </div>
	</form>
</div>
<script>
	$(function(){
		var options={
			addUrl:"/org/json/add",//定义新增的url
			upDateUrl:"/org/json/updateAllById",//定义修改的url
			id:"orgForm",//定义表单编号,要求lay-flter也为此
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
        form.beforeValidate=function(that){
            var layedit = layui.layedit;
        }
		form.onSubmit=function(that,data){
			var layedit = layui.layedit;
			return data;
		}
		form.init(form);
	});
</script>
