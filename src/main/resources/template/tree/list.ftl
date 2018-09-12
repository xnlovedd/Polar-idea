<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<#assign parentCode ><#if code.idField==code.parentField>${code.idField}<#else><#list columns as mData><#if mData.name == code.parentField>${mData.javaName}</#if></#list></#if></#assign>
<#assign childCode ><#if code.childField==code.idField>${code.idField}<#else><#list columns as mData><#if mData.name == code.childField>${mData.javaName}</#if></#list></#if></#assign>
<#assign nameCode ><#if code.idField==code.nameField>${code.idField}<#else><#list columns as mData><#if mData.name == code.nameField>${mData.javaName}</#if></#list></#if></#assign>
<#assign valueCode ><#if code.idField==code.valueField>${code.idField}<#else><#list columns as mData><#if mData.name == code.valueField>${mData.javaName}</#if></#list></#if></#assign>
<div class="polar-content"
     cache='true' id="${code.moduleName}OuterDiv" >
	<input type="hidden" value='1' id="page" /> 
	<input type="hidden" value='10' id="rows" />
	<form class="polar-list-form layui-form" role="form"lay-filter="${code.moduleName}FormFilter"  >
		<blockquote class="layui-elem-quote polar-title">${code.tableRemark}</blockquote>
		<div  class="polar-btn-inner-template">
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
			<shiro:hasPermission name="${code.moduleName}:add">
                <button class="layui-btn  layui-btn-primary layui-btn-xs polar-down-inner" polar-data="[code]">
                    <i class="fa fa-plus"></i> <span class="polar-btn-content">添加</span>
                </button>
             </shiro:hasPermission>

		</div>

	</form>
	<div  class="layui-inline polar-toolbar">
		<shiro:hasPermission name="${code.moduleName}:add">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-add">
			<i class="fa fa-plus"></i> 新增
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="${code.moduleName}:excell:export">
		<button class="layui-btn    layui-btn-primary layui-btn-sm polar-excell-export" >
				<i class="fa fa-table"></i> 导出excell
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="${code.moduleName}:excell:import">
		<button class="layui-btn    layui-btn-primary layui-btn-sm polar-excell-importModel" >
				<i class="fa fa-th"></i> 导入模板
		</button>
		<button class="layui-btn    layui-btn-primary layui-btn-sm polar-excell-import" >
				<i class="fa fa-cloud-upload"></i> 导入数据
		</button>
		</shiro:hasPermission>
		<div class="pull-right">
			<button class="layui-btn  layui-btn-sm layui-btn-primary polar-refresh">
				<i class="fa fa-refresh"></i> 刷新
			</button>
		</div>
	</div>
    <div style="overflow-y:auto;">
        <table id="${code.moduleName}Table" class='layui-table' style="table-layout: fixed;">
            <tbody></tbody>
        </table>
    </div>
	<script type="text/javascript">
	$(function(){

		var columns=[[
						<#list columns as mData>
							<#if mData.listShown==1>
						{
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
						},
							</#if>
						</#list>
						 {
							field : 'operate',
							title : '操作',
							formatter : function(row,options){
							 var result=$("#${code.moduleName}OuterDiv .polar-list-form .polar-btn-inner-template").html().split('[id]').join(row.${code.idField});
							 result=result.split('[code]').join(row.${childCode});
							 return result;
							}
							,tableWidth : 300
                             ,miniTableWidth:170
						} ]];
			var options={ //配置文件
				id:"${code.moduleName}Table",//表编号
				formFilter:"${code.moduleName}FormFilter",
				outDivId:"${code.moduleName}OuterDiv",//最外层的div编号，用来重绘表格高度
				unionId:"${code.idField}",//数据的唯一编号
				netIdKey:"${code.idField}",//网络请求时，传入的主键编号
				name:"${code.tableRemark}",//此模块的名称
				formWidth:'1000px',//表单宽度
				formHeight:'600px',//表单高度
				limits:[ 10, 20, 30, 50, 100 ],//页码数据
                parentId:"${parentCode}",
				childId:"${childCode}"
			};	
			var urls={
				listUrl:'${code.controllerJsonPath}/list',//列表的url
				addPage:"${code.controllerWebPath}/add",//新增页面的url
				viewPage:"${code.controllerWebPath}/detail",//查看页面的url
				deleteSingle:"${code.controllerJsonPath}/deleteById",//删除单条的url
				updatePage:"${code.controllerWebPath}/update",//编辑页面的url
				exportExcell:"${code.controllerJsonPath}/exportExcell",//导出excell的路径
				importExcell:"${code.controllerJsonPath}/importExcell", //导入excell的路径
				importExcellModel:"${code.controllerJsonPath}/importExcellModel" //获取导入模板的路径
			};
      	  var table=polar.table.tree(columns,options,urls);
		table.onDataDone=function(that){
				<#list columns as mData>
					<#if mData.type==6>
						polar.ehco.cache("${mData.group.name}",'${"$"}{fns:getDictJson('${mData.group.name}')}');
					</#if >
					<#if mData.type==7>
						polar.ehco.cache("${mData.group.name}",'${"$"}{fns:getTreeJson('${mData.group.name}')}'');
					</#if >
				</#list>
                $("#"+that.options.outDivId).find("td .polar-down-inner").bind("click", function() {
                    var id=$(this).attr('polar-data');
                    var data={};
                    data[that.options.parentId]=id;
                    polar.layer.loadLayer(that.urls.addPage, true,
                            {width:that.options.formWidth,height:that.options.formHeight,yesContent:"添加",yesBtn:true,title:"添加"+that.options.name,clearForm:true}, data);
                });
            }
			table.init(table);
			$(window).resize(function() { 
				table.resizeTable();
			});	
	});
	</script>
</div>