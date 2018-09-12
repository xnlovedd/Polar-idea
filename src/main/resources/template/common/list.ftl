<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="polar-content"
	cache='true' id="${code.moduleName}OuterDiv" >
    <input type="hidden" value='1' class="polar-page" />
    <input type="hidden" value='10' class="polar-rows" />
	<form class="polar-list-form layui-form" role="form" lay-filter="${code.moduleName}FormFilter" >
		<blockquote class="layui-elem-quote polar-title">${code.tableRemark}</blockquote>
		<div class="polar-btn-inner-template">
			<shiro:hasPermission name="${code.moduleName}:view:detail">
			<button class="layui-btn   layui-btn-primary layui-btn-xs  polar-detail-inner" polar-data="[id]">
				<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="${code.moduleName}:edit">
			<button class="layui-btn  layui-btn-primary layui-btn-xs polar-edit-inner" polar-data="[id]">
				<i class="fa fa-edit"></i> <span class="polar-btn-content">修改</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="${code.moduleName}:delete">
			<button class="layui-btn    layui-btn-primary layui-btn-xs polar-delete-inner" polar-data="[id]">
				<i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
			</button>
			</shiro:hasPermission>
		</div>
		<div class="layui-form-item polar-scroll  layui-row">
			<#list columns as mData>
			<#if mData.search==1>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">${mData.remark}：</label>
				<#if mData.type!=11>
				<div class="layui-input-block">
				</#if>
					<#if mData.type==0||mData.type==1>
					<form:input name="${mData.javaName}" placeholder="请输入${mData.remark}" cache="true" />
					<#elseif mData.type==2||mData.type==9>
					<form:inputNumber name="${mData.javaName}" placeholder="请输入${mData.remark}" cache="true" />
					<#elseif mData.type==3>
					<form:inputNumeric name="${mData.javaName}" placeholder="请输入${mData.remark}" cache="true" />
					<#elseif mData.type==6>
					<form:select name="${mData.javaName}" <#if mData.group.emptyValue??>emptyValue="${mData.group.emptyValue}"<#else>emptyValue="全部"</#if>  cache="true" itemValues="${"$"}{fns:getDict('${ mData.group.name}')}"/>
					<#elseif mData.type==4>
					<form:inputTime name="${mData.javaName}" placeholder="请输入${mData.remark}"  <#if mData.group.format??>format="${mData.group.format}"<#else>format="yyyy-MM-dd"</#if>  cache="true" <#if mData.group.type??>type="${mData.group.type}"<#else>type="data"</#if>  id="${mData.javaName}List"/>
					<#elseif mData.type==7>
					<form:codeTree id="${mData.javaName}List" name="${mData.javaName}" values="${"$"}{fns:getTreeJson('${mData.group.name}')}"></form:codeTree>
					<#elseif mData.type==11>
					<form:area name="${mData.javaName}" cache="true" id="${code.moduleName}List-${mData.javaName}"></form:area>
					<#else>
					<form:input name="${mData.javaName}" placeholder="请输入${mData.remark}" cache="true" />
					</#if>
				<#if mData.type!=11>
				</div>
				</#if>
			</div>
			</#if>
			</#list>
		</div>
	</form>
    <div class="layui-inline polar-toolbar">
		<shiro:hasPermission name="${code.moduleName}:add">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-add">
			<i class="fa fa-plus"></i> <span class="polar-btn-content">新增</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="${code.moduleName}:view:detail">
		<button class="layui-btn  layui-btn-sm layui-btn-primary  polar-detail">
			<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="${code.moduleName}:edit">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-edit">
			<i class="fa fa-pencil"></i> <span class="polar-btn-content">编辑</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="${code.moduleName}:delete">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-delete">
			<i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="${code.moduleName}:excell:export">
		<button class="layui-btn    layui-btn-primary layui-btn-sm polar-excell-export" >
				<i class="fa fa-table"></i> <span class="polar-btn-content">导出excell</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="${code.moduleName}:excell:import">
		<button class="layui-btn    layui-btn-primary layui-btn-sm polar-excell-importModel" >
				<i class="fa fa-th"></i> <span class="polar-btn-content">导入模板</span>
		</button>
		<button class="layui-btn    layui-btn-primary layui-btn-sm polar-excell-import" >
				<i class="fa fa-cloud-upload"></i> <span class="polar-btn-content">导入数据</span>
		</button>
		</shiro:hasPermission>
		<div class="pull-right">
			<button class="layui-btn  layui-btn-sm layui-btn-primary polar-refresh">
				<i class="fa fa-refresh"></i> <span class="polar-btn-content">刷新</span>
			</button>
			<button class="layui-btn  layui-btn-sm layui-btn-primary polar-reset">
				<i class="fa fa-circle-o-notch"></i> <span class="polar-btn-content">重置</span>
			</button>
			<button class="layui-btn  layui-btn-sm layui-btn-primary polar-search">
				<i class="fa fa-search-plus"></i> <span class="polar-btn-content">搜索</span>
			</button>
		</div>
	</div>
<#if code.listModule==1>
	<table data-striped="true" id="${code.moduleName}Table"></table>
			<#else>
	<table data-striped="true" id="${code.moduleName}Table" lay-filter="${code.moduleName}Table"></table>
</#if>
	<script type="text/javascript">
	$(function(){
	<#if code.listModule==1>
		var columns=[ {
					checkbox : true,
					'class' : "i-checks blue-th",
					tableWidth : 50
					}
					<#list columns as mData>
						<#if mData.listShown==1>
					, {
						"field" : "${mData.javaName}",
						"title" : "${mData.remark}",
						sortable : <#if mData.orderBy==1>true<#else>false</#if>,
						'class' : "blue-th"
                        ,minWidth:100
                        ,weigth:1
						<#if mData.innerEdit==1>
						,editable : {
							type : 'text',
							emptytext : '空'
						}
						</#if>
						<#if mData.type==6||mData.type==7>
						,formatter: function(value, row, index) {
							return polar.ehco.ehcoData('${mData.group.name}',value);
                        }
						</#if>
					}
						</#if>
					</#list>
					, {
						field : 'operate',
						title : '操作',
						'class' : "blue-th",
						formatter : function(value, row, index) {
							return $("#${code.moduleName}OuterDiv .polar-list-form .polar-btn-inner-template").html().split('[id]').join(row.id);
						}
						,tableWidth : 220
                		,miniTableWidth:150
					} ];
	<#else>
		var columns=[[ {
							checkbox : true,
							tableWidth : 50
						}
						<#list columns as mData>
							<#if mData.listShown==1>
							, {
							"field" : "${mData.javaName}",
							"title" : "${mData.remark}",
							sort : <#if mData.orderBy==1>true<#else>false</#if>
                            ,minWidth:100
							,weigth:1
							<#if mData.innerEdit==1>
							,edit:"text"
							</#if>
							<#if mData.type==6||mData.type==7>
							,formatter: function(row,options) {
							    return polar.ehco.ehcoData('${mData.group.name}',row.${mData.javaName});
                             }
							</#if>
						}
							</#if>
						</#list>
						, {
							field : 'operate',
							title : '操作',
							formatter : function(row,options){
							 return $("#${code.moduleName}OuterDiv .polar-list-form .polar-btn-inner-template").html().split('[id]').join(row.${code.idField});
							}
							,tableWidth : 220
                			,miniTableWidth:150
						} ]];
	</#if>
			var options={ //配置文件
				formFilter:"${code.moduleName}FormFilter",
				id:"${code.moduleName}Table",//表编号
				outDivId:"${code.moduleName}OuterDiv",//最外层的div编号，用来重绘表格高度
				unionId:"${code.idField}",//数据的唯一编号
				netIdKey:"${code.idField}",//网络请求时，传入的主键编号
				netMulitKey:"ids",//网络请求时，一组主键编号的key
				name:"${code.tableRemark}",//此模块的名称
				formWidth:'1000px',//表单宽度
				formHeight:'600px',//表单高度
				limits:[ 10, 20, 30, 50, 100 ]//页码数据
			};	
			var urls={
				listUrl:'${code.controllerJsonPath}/pageList',//列表的url
				addPage:"${code.controllerWebPath}/add",//新增页面的url
				viewPage:"${code.controllerWebPath}/detail",//查看页面的url
				deleteSingle:"${code.controllerJsonPath}/deleteById",//删除单条的url
				deleteMulit:"${code.controllerJsonPath}/deleteMulitById",//删除多条数据的url
				updatePage:"${code.controllerWebPath}/update",//编辑页面的url
				updateField:"${code.controllerJsonPath}/updateField", //更新单个字段的url	
				exportExcell:"${code.controllerJsonPath}/exportExcell",//导出excell的路径
				importExcell:"${code.controllerJsonPath}/importExcell", //导入excell的路径
				importExcellModel:"${code.controllerJsonPath}/importExcellModel" //获取导入模板的路径
			};
			<#if code.listModule==1>
			var table=polar.table.boot(columns,options,urls);
			<#else>
			var table=polar.table.layui(columns,options,urls);
			</#if>
			<#assign sql>
			<#list columns as mData>
			<#if mData.type==11>
			clearProvince("${mData.javaName}");
			</#if>
			</#list>
			</#assign>
			<#if sql?trim?length!=0>
			table.onReset=function(that){
				${sql}
			};
			table.onDataDone=function(that){
				<#list columns as mData>
					<#if mData.type==6>
						polar.ehco.cache("${mData.group.name}",'${"$"}{fns:getDictJson('${mData.group.name}')}');
					</#if >
					<#if mData.type==7>
						polar.ehco.cache("${mData.group.name}",'${"$"}{fns:getTreeJson('${mData.group.name}')}'');
					</#if >
				</#list>
			}
			</#if>
			table.init(table);
			$(window).resize(function() { 
				table.resizeTable();
			});	
	});
	</script>
</div>