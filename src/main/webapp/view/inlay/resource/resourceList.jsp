<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="polar-content"
	cache='true' id="resourceOuterDiv"  >
	<input type="hidden" value='1' class="polar-page" />
	<input type="hidden" value='10' class="polar-rows" />
	<form class="polar-list-form layui-form"  role="form" lay-filter='resourceOuterDiv'>
		<blockquote class="layui-elem-quote polar-title">资源管理</blockquote>
		<div style="display: none" class="polar-btn-inner-template">
			<shiro:hasPermission name="polar:resource:view:detail">
			<button class="layui-btn   layui-btn-primary layui-btn-xs  polar-detail-inner" polar-data="[id]">
				<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:resource:edit">
			<button class="layui-btn  layui-btn-primary layui-btn-xs polar-edit-inner" polar-data="[id]">
				<i class="fa fa-edit"></i> <span class="polar-btn-content">修改</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:resource:permission">
			<button class="layui-btn    layui-btn-primary layui-btn-xs polar-permission-inner" polar-data="[id]">
				<i class="fa fa-lock"></i> <span class="polar-btn-content">设置权限</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:resource:delete">
			<button class="layui-btn    layui-btn-primary layui-btn-xs polar-delete-inner" polar-data="[id]">
				<i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
			</button>
			</shiro:hasPermission>
		</div>
		<div class="layui-form-item polar-scroll layui-row">
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">名称：</label>
				<div class="layui-input-block">
					<form:input name="name" placeholder="请输入名称" cache="true" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">中文名称：</label>
				<div class="layui-input-block">
					<form:input name="text" placeholder="请输入中文名称" cache="true" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">访问路径：</label>
				<div class="layui-input-block">
					<form:input name="path" placeholder="请输入访问路径" cache="true" />
				</div>
			</div>
		</div>
	</form>
	<div  class="layui-inline polar-toolbar">
		<shiro:hasPermission name="polar:resource:add">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-add">
			<i class="fa fa-plus"></i> <span class="polar-btn-content">新增</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:resource:view:detail">
		<button class="layui-btn  layui-btn-sm layui-btn-primary  polar-detail">
			<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:resource:edit">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-edit">
			<i class="fa fa-pencil"></i> <span class="polar-btn-content">编辑</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:resource:delete">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-delete">
			<i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
		</button>
		</shiro:hasPermission>
		<div class="pull-right">
			<shiro:hasPermission name="polar:resource:reload">
			<button class="layui-btn  layui-btn-sm layui-btn-primary polar-refresh-resource">
				<i class="fa fa-refresh"></i> <span class="polar-btn-content">重新加载资源</span>
			</button>
			</shiro:hasPermission>
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
	<table data-striped="true" id="resourceTable" lay-filter="resourceTable"></table>
	<script type="text/javascript">
	$(function(){
		var columns=[[ {
							checkbox : true,
							tableWidth : 50
						}
							, {
							"field" : "name",
							"title" : "名称",
							sort : true,miniTableWidth:100
							,edit:"text"
						}
							, {
							"field" : "text",
							"title" : "中文名称",
							sort : true,miniTableWidth:100
							,edit:"text"
						}
							, {
							"field" : "path",
							"title" : "访问路径",
							sort : true,miniTableWidth:100
							,edit:"text"
						}
							, {
							"field" : "orderNum",
							"title" : "排序号",
							sort : true,miniTableWidth:100
							,edit:"text"
						}
							, {
							"field" : "info",
							"title" : "描述",
							sort : true,miniTableWidth:100
							,edit:"text"
						}
						, {
							field : 'operate',
							title : '操作',
							formatter : function(row,options){
							 return $("#resourceOuterDiv .polar-list-form .polar-btn-inner-template").html().split('[id]').join(row.id);
							}
              			  ,miniTableWidth:100
						} ]];
			var options={ //配置文件
				formFilter:"resourceOuterDiv",
				id:"resourceTable",//表编号
				outDivId:"resourceOuterDiv",//最外层的div编号，用来重绘表格高度
				unionId:"id",//数据的唯一编号
				netIdKey:"id",//网络请求时，传入的主键编号
				netMulitKey:"ids",//网络请求时，一组主键编号的key
				name:"资源",//此模块的名称
				formWidth:'1000px',//表单宽度
				formHeight:'600px',//表单高度
				limits:[ 10, 20, 30, 50, 100 ]//页码数据
			};	
			var urls={
				listUrl:'/resource/json/pageList',//列表的url
				addPage:"/resource/web/add",//新增页面的url
				viewPage:"/resource/web/detail",//查看页面的url
				deleteSingle:"/resource/json/deleteById",//删除单条的url
				deleteMulit:"/resource/json/deleteMulitById",//删除多条数据的url
				updatePage:"/resource/web/update",//编辑页面的url
				updateField:"/resource/json/updateField", //更新单个字段的url	
				setPermission:"/resource/web/resourcePermission", //设置权限的url
				reloadResource:"/resource/json/reloadResource", //设置权限的url
			};
			var table=polar.table.layui(columns,options,urls);
			table.onDataDone=function(that){
				 $("#"+that.options.outDivId).find("td .polar-permission-inner").bind("click", function() {
					var id=$(this).attr('polar-data');
					var data={};
					data[that.options.unionId]=id;
					polar.layer.loadLayer(that.urls.setPermission, true, 
							{width:'250px',height:'500px',yesContent:"保存",yesBtn:true,title:"设置权限",clearForm:true}, data);
				 }); 
			};
			table.onInitDone=function(that){
				$("#"+that.options.outDivId+".polar-toolbar .polar-refresh-resource").click(function(){
					polar.dialog.confirm("提示", "重新加载将会使所有的资源生效，您确定要执行此操作吗？", function() {
						polar.loader.load( polar.loader.jsonSuccess, polar.loader.jsonError, that.urls.reloadResource, true, {refresh:false}, null);
					});
				});
			}
			table.init(table);
			$(window).resize(function() { 
				table.resizeTable();
			});	
	});
	</script>
</div>