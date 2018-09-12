<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="polar-content"
	cache='true' id="recordsOuterDiv" >
	<input type="hidden" value='1' class="polar-page" />
	<input type="hidden" value='10' class="polar-rows" />
	<form class="polar-list-form layui-form" role="form" lay-filter='recordsOuterDiv' >
		<blockquote class="layui-elem-quote polar-title">访问记录</blockquote>
		<div style="display: none" class="polar-btn-inner-template">
			<shiro:hasPermission name="polar:records:detail">
			<button class="layui-btn   layui-btn-primary layui-btn-xs  polar-detail-inner" polar-data="[id]">
				<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:records:delete">
			<button class="layui-btn    layui-btn-primary layui-btn-xs polar-delete-inner" polar-data="[id]">
				<i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
			</button>
			</shiro:hasPermission>
		</div>
		<div class="layui-form-item polar-scroll layui-row">
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">页面名称：</label>
				<div class="layui-input-block">
					<form:input name="pageName" placeholder="请输入页面名称" cache="true" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">访问路径：</label>
				<div class="layui-input-block">
					<form:input name="vistUrl" placeholder="请输入访问路径" cache="true" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">访问平台：</label>
				<div class="layui-input-block">
					<select name='vistPlatform' cache="true">
						<option value="">全部</option>
						<option value="1">电脑</option>
						<option value="2">手机</option>
					</select>
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">访问时间：</label>
				<div class="layui-input-block">
					<form:inputTime name="vistSearchDate" placeholder="请输入访问时间"  format="yyyy-MM-dd" cache="true" type="datetime" id="vistSearchDate" range="~"/>
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">访问人：</label>
				<div class="layui-input-block">
					<form:input name="vistPeople" placeholder="请输入访问人" cache="true" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">访问IP：</label>
				<div class="layui-input-block">
					<form:input name="vistIp" placeholder="请输入访问IP" cache="true" />
				</div>
			</div>
		</div>
	</form>
	<div class="layui-inline polar-toolbar">
		<shiro:hasPermission name="polar:records:detail">
		<button class="layui-btn  layui-btn-sm layui-btn-primary  polar-detail">
			<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:records:delete">
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
	<table data-striped="true" id="recordsTable" lay-filter="recordsTable"></table>
	<script type="text/javascript">
	$(function(){
		var columns=[[ {
							checkbox : true,
							tableWidth : 50
						}
							, {
							"field" : "pageName",
							"title" : "页面名称",
							miniTableWidth:100,
							sort : true,
							formatter : function(row,options){
								if(polar.isNull(row.pageName)){
									return "未知页面";
								}else{
									return row.pageName;
								}
							}
						}
							, {
							"field" : "vistUrl",
							"title" : "访问路径",
							sort : true,miniTableWidth:100
						}
							, {
							"field" : "vistPlatform",
							"title" : "访问平台",
							sort : true, miniTableWidth:100,
							formatter : function(row,options){
								if(row.vistPlatform==1){
									return "电脑";
								}else if(row.vistPlatform==2){
									return "手机";
								}else{
									return "未知";
								}
							}
						}
							, {
							"field" : "vistDate",
							"title" : "访问时间",
							sort : true,miniTableWidth:100
						}, {
							"field" : "vistIp",
							"title" : "访问IP",
							sort : true,
               				 miniTableWidth:100,
							formatter : function(row,options){
								if(polar.isNull(row.vistIp)){
									return "未知IP";
								}else{
									return row.vistIp;
								}
							}
						}
							, {
							"field" : "vistPeople",
							"title" : "访问人",
							sort : true,
           					 miniTableWidth:100,
							formatter : function(row,options){
								if(polar.isNull(row.vistPeople)){
									return "匿名用户";
								}else{
									return row.vistPeople;
								}
							}
						}
						, {
							field : 'operate',
							title : '操作',
							formatter : function(row,options){
							 return $("#recordsOuterDiv .polar-list-form .polar-btn-inner-template").html().split('[id]').join(row.id);
							}
						} ]];
			var options={ //配置文件
				formFilter:"recordsOuterDiv",
				id:"recordsTable",//表编号
				outDivId:"recordsOuterDiv",//最外层的div编号，用来重绘表格高度
				unionId:"id",//数据的唯一编号
				netIdKey:"id",//网络请求时，传入的主键编号
				netMulitKey:"ids",//网络请求时，一组主键编号的key
				name:"访问记录",//此模块的名称
				formWidth:'1000px',//表单宽度
				formHeight:'600px',//表单高度
				limits:[ 10, 20, 30, 50, 100 ]//页码数据

			};	
			var urls={
				listUrl:'/records/json/pageList',//列表的url
				addPage:"/records/web/add",//新增页面的url
				viewPage:"/records/web/detail",//查看页面的url
				deleteSingle:"/records/json/deleteById",//删除单条的url
				deleteMulit:"/records/json/deleteMulitById",//删除多条数据的url
				updatePage:"/records/web/update",//编辑页面的url
				updateField:"/records/json/updateField", //更新单个字段的url	
				exportExcell:"/records/json/exportExcell",//导出excell的路径
				importExcell:"/records/json/importExcell", //导入excell的路径
				importExcellModel:"/records/json/importExcellModel", //获取导入模板的路径
			};
			var table=polar.table.layui(columns,options,urls);
			table.init(table);
			$(window).resize(function() { 
				table.resizeTable();
			});	
	});
	</script>
</div>