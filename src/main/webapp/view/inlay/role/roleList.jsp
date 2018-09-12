<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="polar-content"
	cache='true' id="RoletableListDiv"  >
	<input type="hidden" value='1' class="polar-page" />
	<input type="hidden" value='10' class="polar-rows" />
	<form class="polar-list-form layui-form" role="form" lay-filter='RoletableListDiv' >
		<blockquote class="layui-elem-quote polar-title">角色管理</blockquote>
		<div style="display: none" class="polar-btn-inner-template">
			<shiro:hasPermission name="polar:role:view:detail">
			<button class="layui-btn   layui-btn-primary layui-btn-xs  polar-detail-inner" polar-data="[id]">
				<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:role:edit">
			<button class="layui-btn  layui-btn-primary layui-btn-xs polar-edit-inner" polar-data="[id]">
				<i class="fa fa-edit"></i> <span class="polar-btn-content">修改</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:role:add">
			<button class="layui-btn  layui-btn-primary layui-btn-xs polar-down-inner" polar-data="[id]">
				<i class="fa fa-info"></i> <span class="polar-btn-content">添加下级角色</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:role:delete">
			<button class="layui-btn    layui-btn-primary layui-btn-xs polar-delete-inner" polar-data="[id]">
				<i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:role:permission">
			<button class="layui-btn    layui-btn-primary layui-btn-xs polar-permission-inner" polar-data="[id]">
				<i class="fa fa-lock"></i> <span class="polar-btn-content">分配权限</span>
			</button>
			</shiro:hasPermission>
		</div>
	</form>
	<div class="layui-inline polar-toolbar">
		<shiro:hasPermission name="polar:role:add">
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
	<table id="roleContent_table" class='layui-table' style="table-layout: fixed;">
		<tbody></tbody>
	</table>
	</div>
	<script type="text/javascript">
	$(function(){
		var columns=[[ 
			{
				"field" : "text",
				"title" : "角色名称",
				sort : true,
				tableWidth:150
			},
		 {
			"field" : "name",
			"title" : "角色标识",
			sort : true  ,tableWidth:150
		}
			
		,  {
			"field" : "info",
			"title" : "角色描述",
			sort : true,miniTableWidth:200,minWidth:200
		}
			, {
			"field" : "orderNum",
			"title" : "排序",
			sort : true,tableWidth : 100
		}
		, {
			field : 'operate',
			title : '操作',
			formatter : function(row,options){
			 return $("#RoletableListDiv .polar-list-form .polar-btn-inner-template").html().split('[id]').join(row.id);
			}
			,tableWidth : 430,miniTableWidth:200
		} ]];
		var urls={
				listUrl:'/role/json/pageList',//列表的url
				addPage:"/role/web/add",//新增页面的url
				viewPage:"/role/web/detail",//查看页面的url
				deleteSingle:"/role/json/deleteById",//删除单条的url
				deleteMulit:"/role/json/deleteMulitById",//删除多条数据的url
				updatePage:"/role/web/update",//编辑页面的url
				updateField:"/role/json/updateField", //更新单个字段的url	
				permission:"/role/web/rolePermission" //角色权限的url
			};
		var options={ //配置文件
				formFilter:"RoletableListDiv",
				id:"roleContent_table",//表编号
				outDivId:"RoletableListDiv",//最外层的div编号，用来重绘表格高度
				unionId:"id",//数据的唯一编号
				parentId:"parentId",
				netIdKey:"id",//网络请求时，传入的主键编号
				netMulitKey:"ids",//网络请求时，一组主键编号的key
				name:"角色",//此模块的名称
				formWidth:'1000px',//表单宽度
				formHeight:'600px',//表单高度
				limits:[ 10, 20, 30, 50, 100 ]//页码数据

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
			 $("#"+that.options.outDivId).find("td .polar-permission-inner").bind("click", function() {
				 var id=$(this).attr('polar-data');
					var data={};
					data[that.options.unionId]=id;
					polar.layer.loadLayer(that.urls.permission, true, 
							{width:'250px',height:'500px',yesContent:"分配权限",yesBtn:true,title:"权限分配",clearForm:true}, data);
				}); 
		};
		table.init(table);
		$(window).resize(function() { 
			table.resizeTable();
		});	
	});
	</script>
</div>