<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<#assign parentCode ><#if code.idField==code.parentField>${code.idField}<#else><#list columns as mData><#if mData.name == code.parentField>${mData.javaName}</#if></#list></#if></#assign>
<#assign childCode ><#if code.childField==code.idField>${code.idField}<#else><#list columns as mData><#if mData.name == code.childField>${mData.javaName}</#if></#list></#if></#assign>
<#assign nameCode ><#if code.idField==code.nameField>${code.idField}<#else><#list columns as mData><#if mData.name == code.nameField>${mData.javaName}</#if></#list></#if></#assign>
<#assign valueCode ><#if code.idField==code.valueField>${code.idField}<#else><#list columns as mData><#if mData.name == code.valueField>${mData.javaName}</#if></#list></#if></#assign>
<div class='form-div'>
	<form method="post" class="layui-form required-validate polar-form" id="${code.moduleName}Form" lay-filter="${code.moduleName}Form">
		<input type="hidden" name="${code.idField}" value='${"$"}{${code.moduleName}.${code.idField}}' />
		<#list columns as mData>
		<#if mData.type==8>
		<input type="hidden" name="${mData.javaName}" value='${"$"}{${code.moduleName}.${mData.javaName}}' />
		</#if>
		</#list>
        <div class="layui-form-item ">
            <div class="layui-row">
		<#list columns as mData>
			<#if mData.type!=8>
				<#if mData.type==5||mData.type==1||mData.type==10||mData.type==12||mData.type==13||mData.type==14>
				<div class="layui-inline layui-col-xs12 layui-col-sm12 layui-col-md12">
				<#else>
				<div class="layui-inline layui-col-xs12 layui-col-sm6 layui-col-md6">
				</#if>
                    <label class="layui-form-label polar-form-title">${mData.remark}：</label>
                    <div class="layui-input-block polar-form-content">
				<#if code.validateType==1>
						<div class="form-group noMarginBottom">
				</#if>
					<#if mData.name==code.parentField>
					<form:singelTree values="${"$"}{${code.moduleName}_allEntities}" id="${parentCode}" name="${parentCode}" value='${"$"}{${code.moduleName}.${mData.javaName}}'  idField="${code.idField}" parentIdField="${parentCode}" nameField="${nameCode}" valueField="${valueCode}" ></form:singelTree>
					<#else>
					<#if mData.type==0||mData.type==2||mData.type==3||mData.type==9>
					<#assign sql>maxLength,minLength,<#if mData.required==1>required,</#if><#if mData.phone==1>phone,</#if><#if mData.email==1>email,</#if><#if mData.identity==1>identity,</#if><#if mData.type==4>date,</#if><#if mData.type==2||mData.type==9>number,</#if><#if mData.type==3>numeric,</#if></#assign>
					<form:input name="${mData.javaName}" placeholder="请输入${mData.remark}" <#if mData.group.maxLength??>maxLength="${mData.group.maxLength}"</#if> <#if mData.group.minLength??>minLength="${mData.group.minLength}"</#if> tag="${mData.remark}" value='${"$"}{${code.moduleName}.${mData.javaName}}' <#if sql?contains(",")>vertify="${sql?substring(0, sql?last_index_of(","))}"</#if>/>
					<#elseif mData.type==6>
					<form:select name="${mData.javaName}" itemValues="${"$"}{fns:getDict('${mData.group.name}')}" <#if mData.group.emptyValue??>emptyValue="${mData.group.emptyValue}"<#else></#if> />
					<#elseif mData.type==4>
					<form:inputTime id="${mData.javaName}Form" name="${mData.javaName}" placeholder="请输入${mData.remark}" cache="true" <#if mData.group.format??>format="${mData.group.format}"<#else>format="yyyy-MM-dd"</#if>  tag="${mData.remark}" value='${"$"}{fns:formatDateTimeCustom(${code.moduleName}.${mData.javaName},"<#if mData.group.format??>${mData.group.format}<#else>yyyy-MM-dd</#if>")}'/>
					<#if mData.type==5||mData.type==1><#assign sql>maxLength,minLength,<#if mData.required==1>required,</#if></#assign></#if>
					<#elseif mData.type==5>
					<form:richtext name="${mData.javaName}"  <#if mData.group.maxLength??>maxLength="${mData.group.maxLength}"</#if> <#if mData.group.minLength??>minLength="${mData.group.minLength}"</#if> tag="${mData.remark}" value='${"$"}{${code.moduleName}.${mData.javaName}}' <#if sql?contains(",")>vertify="${sql?substring(0, sql?last_index_of(","))}"</#if>/>
					<#elseif mData.type==1>
					<form:textarea name="${mData.javaName}"  <#if mData.group.maxLength??>maxLength="${mData.group.maxLength}"</#if> <#if mData.group.minLength??>minLength="${mData.group.minLength}"</#if> tag="${mData.remark}" value='${"$"}{${code.moduleName}.${mData.javaName}}' <#if sql?contains(",")>vertify="${sql?substring(0, sql?last_index_of(","))}"</#if>/>
					<#elseif mData.type==10>
					<form:multiImg name="${mData.javaName}" value='${"$"}{${code.moduleName}.${mData.javaName}}' <#if mData.group.width??>width="${mData.group.width}"<#else>width="80px"</#if> <#if mData.group.height??>height="${mData.group.height}"<#else>height="80px"</#if> <#if mData.group.max??>max="${mData.group.max}"<#else>max="-1"</#if> ></form:multiImg>
					<#elseif mData.type==12>
					<form:files name="${mData.javaName}" <#if mData.group.type??>type="${mData.group.type}"<#else>type="file"</#if> value='${"$"}{${code.moduleName}.${mData.javaName}}' <#if mData.group.max??>max="${mData.group.max}"<#else>max="-1"</#if> ></form:files>
					<#elseif mData.type==11>
					<form:area name="${mData.javaName}" value="${"$"}{${code.moduleName}.${mData.javaName}}" id="${code.moduleName}Form-${mData.javaName}"></form:area>
					<#elseif mData.type==13>
					<form:img name="${mData.javaName}" value='${"$"}{${code.moduleName}.${mData.javaName}}' <#if mData.group.width??>width="${mData.group.width}"<#else>width="80px"</#if> <#if mData.group.height??>height="${mData.group.height}"<#else>height="80px"</#if> ></form:img>
					<#elseif mData.type==14>
					<form:file name="${mData.javaName}" <#if mData.group.type??>type="${mData.group.type}"<#else>type="file"</#if> value='${"$"}{${code.moduleName}.${mData.javaName}}'  ></form:file>
					<#elseif mData.type==15>
					<form:codeSingleTree id="${mData.javaName}Form" name="${mData.javaName}" values="${"$"}{fns:getTreeJson('${mData.group.name}')}"></form:codeSingleTree>
					<#else>
					<form:codeTree id="${mData.javaName}Form" name="${mData.javaName}" values="${"$"}{fns:getTreeJson('${mData.group.name}')}"></form:codeTree>
					</#if>
					</#if>

				<#if code.validateType==1>
						</div>
				</#if>
                    </div>
                </div>
			</#if>
		</#list>
            </div>
         </div>
	</form>
</div>
<script>
	$(function(){
		var options={
			addUrl:"${code.controllerJsonPath}/add",//定义新增的url
			upDateUrl:"${code.controllerJsonPath}/updateAllById",//定义修改的url
			id:"${code.moduleName}Form",//定义表单编号,要求lay-flter也为此
			unionId:"${code.idField}"//主键编号
		};
		var form=polar.form.Form(options);
		form.validate=function(that){
		<#if code.validateType==1>
		var bootstrapValidator = $("#"+that.options.id).data('bootstrapValidator');
		bootstrapValidator.validate();
		return bootstrapValidator.isValid();
		<#else>
		return polar.form.Verification("#"+that.options.id);
		</#if>
		};
		form.done=function(that,layuiForm){//加载完成的回调
			<#if code.validateType==1>
			$("#"+that.options.id).bootstrapValidator({
			message : '数据格式不合法',
			excluded : [ ':disabled' ],
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			}
			<#assign sql2>
			<#list columns as mData>
				<#assign sql>
					<#if mData.required==1>
						notEmpty : {
							message : '${mData.remark}不能为空'
						},
					</#if>
					<#if mData.phone==1>
						regexp : {
							regexp : /^1\d{10}$/,
							message : '${mData.remark}必须为手机号'
						},
					</#if>
					<#if mData.email==1>
						regexp : {
							regexp : /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/,
							message : '${mData.remark}必须为邮箱'
						},
					</#if>
					<#if mData.identity==1>
						regexp : {
							regexp : /(^\d{15}$)|(^\d{17}(x|X|\d)$)/,
							message : '${mData.remark}必须身份证号'
						},
					</#if>
					<#if mData.type==4>
						regexp : {
							regexp : /^(\d{4})[-\/](\d{1}|0\d{1}|1[0-2])([-\/](\d{1}|0\d{1}|[1-2][0-9]|3[0-1]))*$/,
							message : '${mData.remark}必须为日期'
						},
					</#if>
					<#if mData.type==2>
						regexp : {
							regexp : /^\d+$/,
							message : '${mData.remark}必须为整数'
						},
					</#if>
					<#if mData.type==3>
						regexp : {
							regexp : /^-?([1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0)$/,
							message : '${mData.remark}必须为数字'
						},
					</#if>
				</#assign>
				<#if sql?contains(",") >
				${mData.javaName}:{
					validators:{
${sql?substring(0, sql?last_index_of(","))}
					}
				},
				</#if>
			</#list>
			</#assign>
				<#if sql2?contains(",") >
			,fields : {
${sql2?substring(0, sql2?last_index_of(","))}
			}
				</#if>
		});
		<#else>
		</#if>
		
		var layedit = layui.layedit;
		that.indexs={};
		<#list columns as mData>
		<#if mData.type==5>
		that.indexs["${mData.javaName}"]=layedit.build('${mData.javaName}'); //建立编辑器
		</#if>
		</#list>
		
		};
        form.beforeValidate=function(that){
            var layedit = layui.layedit;
            <#list columns as mData>
				<#if mData.type==5>
			$('#${mData.javaName}').html(layedit.getContent(that.indexs['${mData.javaName}']));
				</#if>
			</#list>
        }
		form.onSubmit=function(that,data){
			var layedit = layui.layedit;
			<#list columns as mData>
			<#if mData.type==5>
			data["${mData.javaName}"]=layedit.getContent(that.indexs['${mData.javaName}']);
			</#if>
			</#list>
			return data;
		}
		form.init(form);
	});
</script>
