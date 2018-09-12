<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="polar-content"
	cache='true' id="menuOuterDiv" >
	<input type="hidden" value='1' class="polar-page" />
	<input type="hidden" value='10' class="polar-rows" />
	<form class=" polar-list-form layui-form" role="form"  lay-filter='menuOuterDiv'>
		<blockquote class="layui-elem-quote polar-title">菜单管理</blockquote>
		<div style="display: none" class="polar-btn-inner-template">
			<shiro:hasPermission name="polar:menu:view:detail">
			<button class="layui-btn   layui-btn-primary layui-btn-xs  polar-detail-inner" polar-data="[id]">
				<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:menu:edit">
			<button class="layui-btn  layui-btn-primary layui-btn-xs polar-edit-inner" polar-data="[id]">
				<i class="fa fa-edit"></i> <span class="polar-btn-content">修改</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:menu:delete">
			<button class="layui-btn    layui-btn-primary layui-btn-xs polar-delete-inner" polar-data="[id]">
				<i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:menu:add">
			<button class="layui-btn  layui-btn-primary layui-btn-xs polar-down-inner" polar-data="[id]">
				<i class="fa fa-reorder"></i> <span class="polar-btn-content">添加下级菜单</span>
			</button>
			</shiro:hasPermission>
		</div>
	</form>
	<div  class="layui-inline polar-toolbar">
		<shiro:hasPermission name="polar:menu:add">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-add">
			<i class="fa fa-plus"></i> <span class="polar-btn-content">新增</span>
		</button>
		</shiro:hasPermission>
		<div class="pull-right">
			<button class="layui-btn  layui-btn-sm layui-btn-primary polar-refresh">
				<i class="fa fa-refresh"></i> <span class="polar-btn-content">刷新</span>
			</button>
		</div>
	</div>
	<div style="overflow-y:auto;">
		<table  class='layui-table' id="menuTable" lay-filter="menuTable"  style="table-layout: fixed;">
		<tbody></tbody>
	</table>
	</div>
	<script type="text/javascript">
	$(function(){
		var columns=[[  {
							"field" : "name",
							"title" : "名称",
							sort : true
							,tableWidth : 200
						}, {
							"field" : "path",
							"title" : "访问路径",
							sort : true
							,miniTableWidth:200,
           					 minWidth:200
						}, {
							"field" : "defaultOpen",
							"title" : "默认展开",
							sort : true
							,tableWidth : 100
							,formatter : function(row,options){
								if(row.defaultOpen==1){
									return "是";
								}else{
									return "否";
								}
							}
						}
							, {
							"field" : "icon",
							"title" : "图标示例",
							sort : true
							,tableWidth : 200
							,formatter : function(row,options){
								if(polar.isNull(row.icon)){
									return row.name+"";
								}else{
									return '<i class="fa fa-'+row.icon+'"></i>&nbsp;'+row.name;
								}
							}
						}
							
							, {
							"field" : "orderNum",
							"title" : "排序号",
							sort : true
							,tableWidth : 100
						}
						, {
							field : 'operate',
							title : '操作',
							formatter : function(row,options){
								var str=$("#menuOuterDiv .polar-list-form .polar-btn-inner-template").html().split('[id]').join(row.id);
								return str;
							}
							,fixed:"right"
							,tableWidth : 350,
							miniTableWidth:220
						} ]];
			var options={ //配置文件
				formFilter:"menuOuterDiv",
				id:"menuTable",//表编号
				outDivId:"menuOuterDiv",//最外层的div编号，用来重绘表格高度
				unionId:"id",//数据的唯一编号
				parentId:"parentId",
				netIdKey:"id",//网络请求时，传入的主键编号
				netMulitKey:"ids",//网络请求时，一组主键编号的key
				name:"菜单",//此模块的名称
				formWidth:'1000px',//表单宽度
				formHeight:'600px',//表单高度
				limits:[ 10, 20, 30, 50, 100 ]//页码数据

			};	
			var urls={
				listUrl:'/menu/json/pageList',//列表的url
				addPage:"/menu/web/add",//新增页面的url
				viewPage:"/menu/web/detail",//查看页面的url
				deleteSingle:"/menu/json/deleteById",//删除单条的url
				deleteMulit:"/menu/json/deleteMulitById",//删除多条数据的url
				updatePage:"/menu/web/update",//编辑页面的url
				updateField:"/menu/json/updateField" //更新单个字段的url	
			};
			var table=polar.table.tree(columns,options,urls);
			table.onDataDone=function(that){
				$("#"+that.options.outDivId).find("td .polar-down-inner").bind("click", function() {
					var id=$(this).attr('polar-data');
					var data={};
					data[that.options.parentId]=id;
					polar.layer.loadLayer(that.urls.addPage, true,
							{width:that.options.formWidth,height:that.options.formHeight,yesContent:"添加",yesBtn:true,title:"添加"+that.options.name,clearForm:true}, data);
				 }); 
			};
			table.init(table);
			$(window).resize(function() { 
				table.resizeTable();
			});	
	});
	</script>
</div>