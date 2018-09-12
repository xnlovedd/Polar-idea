<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="polar-content"
	cache='true' id="menuModelOuterDiv" >
	<input type="hidden" value='1' class="polar-page" />
	<input type="hidden" value='10' class="polar-rows" />
	<form class="polar-list-form layui-form" role="form"  lay-filter='menuModelOuterDiv'>
		<blockquote class="layui-elem-quote polar-title">菜单模板</blockquote>
		<div style="display: none" class="polar-btn-inner-template">
			<shiro:hasPermission name="polar:menumodel:view:detail">
			<button class="layui-btn   layui-btn-primary layui-btn-xs  polar-detail-inner" polar-data="[id]">
				<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:menumodel:edit">
			<button class="layui-btn  layui-btn-primary layui-btn-xs polar-edit-inner" polar-data="[id]">
				<i class="fa fa-edit"></i> <span class="polar-btn-content">修改</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:menumodel:delete">
			<button class="layui-btn    layui-btn-primary layui-btn-xs polar-delete-inner" polar-data="[id]">
				<i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:menumodel:default">
			<button class="layui-btn  layui-btn-primary layui-btn-xs polar-default-inner" polar-data="[id]">
				<i class="fa fa-paper-plane"></i> <span class="polar-btn-content">设为默认</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:menumodel:menu">
			<button class="layui-btn  layui-btn-primary layui-btn-xs polar-menu-inner" polar-data="[id]">
				<i class="fa  fa-paper-plane"></i> <span class="polar-btn-content">菜单配置</span>
			</button>
			</shiro:hasPermission>
		</div>
		<div class="layui-form-item polar-scroll layui-row">
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">模板名称：</label>
				<div class="layui-input-block">
					<form:input name="name" placeholder="请输入模板名称" cache="true" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">模板描述：</label>
				<div class="layui-input-block">
					<form:input name="info" placeholder="请输入模板描述" cache="true" />
				</div>
			</div>
		</div>
	</form>
	<div  class="layui-inline polar-toolbar">
		<shiro:hasPermission name="polar:menumodel:add">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-add">
			<i class="fa fa-plus"></i> <span class="polar-btn-content">新增</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:menumodel:view:detail">
		<button class="layui-btn  layui-btn-sm layui-btn-primary  polar-detail">
			<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:menumodel:edit">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-edit">
			<i class="fa fa-pencil"></i> <span class="polar-btn-content">编辑</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:menumodel:delete">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-delete">
			<i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
		</button>
		</shiro:hasPermission>
		<div class="pull-right">
			<button class="layui-btn  layui-btn-sm layui-btn-primary  polar-refresh">
				<i class="fa fa-refresh"></i> <span class="polar-btn-content">刷新</span>
			</button>
			<button class="layui-btn  layui-btn-sm layui-btn-primary  polar-reset">
				<i class="fa fa-circle-o-notch"></i> <span class="polar-btn-content">重置</span>
			</button>
			<button class="layui-btn  layui-btn-sm layui-btn-primary  polar-search">
				<i class="fa fa-search-plus"></i> <span class="polar-btn-content">搜索</span>
			</button>
		</div>
		
	</div>
	<table data-striped="true" id="menuModelTable" lay-filter="menuModelTable" ></table>
	<script type="text/javascript">
	$(function(){
		var columns=[[ {
							checkbox : true,
							tableWidth : 50
						}
							, {
							"field" : "name",
							"title" : "模板名称",
							sort : true,miniTableWidth:100
							,edit:"text",
							formatter : function(row,options){
								if(row.defaultMenu==1){
									return row.name+'<i class="fa fa-paper-plane" style="color:green"></i>';
								}else{
									return row.name;
								}
							}
						}
							, {
							"field" : "info",
							"title" : "模板描述",
							sort : true,miniTableWidth:100
							,edit:"text",
							weigth:1
						}
						, {
							field : 'operate',
							title : '操作',
							formatter : function(row,options){
							 	return $("#menuModelOuterDiv .polar-list-form .polar-btn-inner-template").html().split('[id]').join(row.id);
							}
							,tableWidth : 400,
							miniTableWidth:250
						} ]];
			var options={ //配置文件
				formFilter:"menuModelOuterDiv",
				id:"menuModelTable",//表编号
				outDivId:"menuModelOuterDiv",//最外层的div编号，用来重绘表格高度
				unionId:"id",//数据的唯一编号
				netIdKey:"id",//网络请求时，传入的主键编号
				netMulitKey:"ids",//网络请求时，一组主键编号的key
				name:"菜单模板",//此模块的名称
				formWidth:'1000px',//表单宽度
				formHeight:'600px',//表单高度
				limits:[ 10, 20, 30, 50, 100 ]//页码数据
			};
			var urls={
				listUrl:'/menuModel/json/pageList',//列表的url
				addPage:"/menuModel/web/add",//新增页面的url
				viewPage:"/menuModel/web/detail",//查看页面的url
				deleteSingle:"/menuModel/json/deleteById",//删除单条的url
				deleteMulit:"/menuModel/json/deleteMulitById",//删除多条数据的url
				updatePage:"/menuModel/web/update",//编辑页面的url
				updateField:"/menuModel/json/updateField", //更新单个字段的url	
				setDefault:"/menuModel/json/setDefault", 
				modelMenus:"/menuModel/web/modelMenus"
			};
			var table=polar.table.layui(columns,options,urls);
			table.onDataDone=function(that){
				 $("#"+that.options.outDivId).find("td .polar-default-inner").bind("click", function() {
					var id=$(this).attr('polar-data');
					polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, that.urls.setDefault, true, {refresh:true}, {id:id});
				}); 
				 $("#"+that.options.outDivId).find("td .polar-menu-inner").bind("click", function() {
						var id=$(this).attr('polar-data');
						var data={};
						data[that.options.unionId]=id;
						polar.layer.loadLayer(that.urls.modelMenus, true, 
								{width:'300px',height:'500px',yesContent:"保存",yesBtn:true,title:"菜单配置",clearForm:true}, data);

				}); 
			};
			table.init(table);
			$(window).resize(function() { 
				table.resizeTable();
			});	
	});
	</script>
</div>