<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="polar-content"
	cache='true' id="treeTableListDiv" >
	<input type="hidden" value='1' class="polar-page" />
	<input type="hidden" value='10' class="polar-rows" />
	<form class=" polar-list-form layui-form" role="form" lay-filter='treeTableListDiv'>
		<blockquote class="layui-elem-quote polar-title">树结构管理</blockquote>
		<div style="display: none" class="polar-btn-inner-template">
			<shiro:hasPermission name="polar:tree:view:detail">
			<button class="layui-btn   layui-btn-primary layui-btn-xs  polar-detail-inner" polar-data="[id]">
				<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:tree:edit">
			<button class="layui-btn  layui-btn-primary layui-btn-xs polar-edit-inner" polar-data="[id]">
				<i class="fa fa-edit"></i> <span class="polar-btn-content">修改</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:tree:delete">
			<button class="layui-btn    layui-btn-primary layui-btn-xs polar-delete-inner" polar-data="[id]">
				<i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
			</button>
			</shiro:hasPermission>
		</div>
		<div class="layui-form-item polar-scroll layui-row">
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">类型：</label>
				<div class="layui-input-block">
					<select name='type' cache="true">
						<option value="">全部</option>
						<option value="1">编码类型</option>
						<option value="2">父子编号类型</option>
					</select>
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">所属组：</label>
				<div class="layui-input-block">
					<form:select name="groupId" emptyValue='全部'  itemValues="${fns:allTreeGroup()}" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">文本内容：</label>
				<div class="layui-input-block">
					<form:input name="text" placeholder="请输入文本内容" cache="true" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">值：</label>
				<div class="layui-input-block">
					<form:input name="value" placeholder="请输入值" cache="true" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">别名：</label>
				<div class="layui-input-block">
					<form:input name="textAlias" placeholder="请输入别名" cache="true" />
				</div>
			</div>
		
		</div>
	</form>
	<div  class="layui-inline polar-toolbar">
		<shiro:hasPermission name="polar:tree:add">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-add">
			<i class="fa fa-plus"></i> 新增
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:tree:view:detail">
		<button class="layui-btn  layui-btn-sm layui-btn-primary  polar-detail">
			<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:tree:edit">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-edit">
			<i class="fa fa-pencil"></i> <span class="polar-btn-content">编辑</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:tree:delete">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-delete">
			<i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
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
	<table data-striped="true" id="treeContent_table" lay-filter="treeContent_table"></table>
	<script type="text/javascript">
	$(function(){
		var columns=[[ {
							checkbox : true,
							tableWidth : 50
						}
							, {
							"field" : "groupId",
							"title" : "组编号",
							sort : true
               				 ,miniTableWidth:100
							,minWidth:100
						}
							, {
							"field" : "groupName",
							"title" : "组名",
							sort : true,miniTableWidth:100,minWidth:100
						}
							, {
							"field" : "text",
							"title" : "文本内容",
							sort : true
							,edit:"text",miniTableWidth:100,minWidth:100
						}
							, {
							"field" : "value",
							"title" : "值",
							sort : true
							,edit:"text",miniTableWidth:100,minWidth:100
						}
							, {
							"field" : "textAlias",
							"title" : "别名",
							sort : true,miniTableWidth:100,minWidth:100
							,edit:"text"
						}
							, {
							"field" : "textId",
							"title" : "编号",
							sort : true,miniTableWidth:100,minWidth:100
						}
							, {
							"field" : "parentId",
							"title" : "父级编号",
							sort : true,miniTableWidth:100,minWidth:100
						}
							, {
							"field" : "type",
							"title" : "类型",
							sort : true,
							formatter : function(row,options){
								 if(row.type==1){
									 return "编码类型";
								 }
								 return "父子编号类型";
							},miniTableWidth:100,minWidth:100
						}
						, {
							field : 'operate',
							title : '操作',
							formatter : function(row,options){
							 return $("#treeTableListDiv .polar-list-form .polar-btn-inner-template").html().split('[id]').join(row.id);
							}
							,tableWidth : 220
               				, miniTableWidth:150
							,fixed:'right'
						} ]];
			var options={ //配置文件
				formFilter:"treeTableListDiv",
				id:"treeContent_table",//表编号
				outDivId:"treeTableListDiv",//最外层的div编号，用来重绘表格高度
				unionId:"id",//数据的唯一编号
				netIdKey:"id",//网络请求时，传入的主键编号
				netMulitKey:"ids",//网络请求时，一组主键编号的key
				name:"树结构",//此模块的名称
				formWidth:'1000px',//表单宽度
				formHeight:'600px',//表单高度
				limits:[ 10, 20, 30, 50, 100 ]//页码数据

			};	
		 	var urls={
				listUrl:'/tree/json/pageList',//列表的url
				addPage:"/tree/web/add",//新增页面的url
				viewPage:"/tree/web/detail",//查看页面的url
				deleteSingle:"/tree/json/deleteById",//删除单条的url
				deleteMulit:"/tree/json/deleteMulitById",//删除多条数据的url
				updatePage:"/tree/web/update",//编辑页面的url
				updateField:"/tree/json/updateField" //更新单个字段的url	
			};
			var table=polar.table.layui(columns,options,urls);
			table.init(table);
			$(window).resize(function() { 
				table.resizeTable();
			});	 
	});
	</script>
</div>