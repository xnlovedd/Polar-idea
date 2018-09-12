<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="polar-content"
	cache='true' id="codetableListDiv" >
	<input type="hidden" value='1' class="polar-page" /> <input type="hidden"
		value='10' class="polar-rows" />
	<form class="polar-list-form layui-form" role="form" lay-filter="codetableListFormFilter">
		<blockquote class="layui-elem-quote polar-title">代码生成</blockquote>
		<div style="display: none" class="polar-btn-inner-template">
			<shiro:hasPermission name="polar:code:view:detail">
			<button class="layui-btn  layui-btn-primary layui-btn-xs  polar-detail-inner" polar-data="[id]">
				<i class="fa fa-eye"></i>  <span class="polar-btn-content">查看</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:code:edit">
			<button class="layui-btn  layui-btn-primary layui-btn-xs  polar-edit-inner" polar-data="[id]">
				<i class="fa fa-edit"></i>  <span class="polar-btn-content">修改</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:code:delete">
			<button class="layui-btn  layui-btn-primary layui-btn-xs  polar-delete-inner" polar-data="[id]">
				<i class="fa fa-remove"></i>  <span class="polar-btn-content">删除</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:code:columns">
			<button class="layui-btn   layui-btn-primary layui-btn-xs  polar-columns-inner" polar-data="[id]">
				<i class="fa fa-columns"></i>  <span class="polar-btn-content">列配置</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:code:setting">
			<button class="layui-btn   layui-btn-primary layui-btn-xs  polar-setting-inner" polar-data="[id]">
				<i class="fa fa-list"></i>  <span class="polar-btn-content">生成配置</span>
			</button>
			</shiro:hasPermission>
		</div>
		<div class="layui-form-item polar-scroll layui-row">
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">表名：</label>
				<div class="layui-input-block">
					<form:input name="tableName" placeholder="请输入表名或表中文名" cache="true" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">删除模式:</label>
				<div class="layui-input-block">
					<select name='deleteMode' cache="true">
						<option value="0">全部</option>
						<option value="1">仅物理删除</option>
						<option value="2">仅逻辑删除</option>
					</select>
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">主键类型：</label>
				<div class="layui-input-block">
					<select name='idType' cache="true">
						<option value="-1" selected="selected">全部</option>
						<option value="0">long</option>
						<option value="1">UUID</option>
					</select>
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">表单类型：</label>
				<div class="layui-input-block">
					<select name='tableType' cache="true">
						<option value="" >全部</option>
						<option value="0" >单表</option>
						<option value="1">树结构表单</option>
						<option value="2">父表</option>
						<option value="3">子表</option>
					</select>
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">模块名称：</label>
				<div class="layui-input-block">
					<form:input name="moduleName" placeholder="请输入模块中文或者英文名称"
						cache="true" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">作者</label>
				<div class="layui-input-block">
					<form:input name="author" placeholder="请输入作者" cache="true" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">访问路径：</label>
				<div class="layui-input-block">
					<form:input name="controllerWebPath" placeholder="请输入访问路径"
						cache="true" />
				</div>
			</div>
		</div>
	</form>
	<div class="layui-inline polar-toolbar">
		<shiro:hasPermission name="polar:code:detail">
		<button class="layui-btn  layui-btn-sm layui-btn-primary  polar-detail">
			<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:code:edit">
		<button class="layui-btn  layui-btn-sm layui-btn-primary  polar-edit">
			<i class="fa fa-pencil"></i> <span class="polar-btn-content">编辑</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:code:delete">
		<button class="layui-btn  layui-btn-sm layui-btn-primary  polar-delete">
			<i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:code:edit">
		<button class="layui-btn  layui-btn-sm layui-btn-primary  polar-import">
			<i class="fa fa-table"></i> <span class="polar-btn-content">导入表</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:code:columns">
		<button class="layui-btn  layui-btn-sm layui-btn-primary  polar-gen">
			<i class="fa fa-list-ul"></i> <span class="polar-btn-content">重置列属性</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:code:code">
		<button class="layui-btn  layui-btn-sm layui-btn-primary  polar-writeCode">
			<i class="fa fa-code"></i> <span class="polar-btn-content">生成代码</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:code:setting">
		<button class="layui-btn  layui-btn-sm layui-btn-primary  polar-setting">
			<i class="fa fa-list"></i> <span class="polar-btn-content">生成配置</span>
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
	<table data-striped="true" id="codecontent_table" lay-filter="codecontent_table" >
	</table>
	<script type="text/javascript">
	$(function(){
		var columns=[[ {
			checkbox : true,
			tableWidth:50
		}, {
			"field" : "tableName",
			"title" : "表名",
			sort : true,
			miniTableWidth:100,
			minWidth:150
		}, {
			"field" : "tableRemark",
			"title" : "名称",
			sort : true,
			edit : 'text',
			miniTableWidth:100
			,minWidth:150
		}, {
			field : 'deleteMode',
			title : '删除模式',
			sort : true,
			formatter  : function(row,options) {
				var value=row.deleteMode;
				if (value == 0) {
					return "全部";
				} else if (value == 1) {
					return "仅物理删除";
				} else {
					return "仅逻辑删除";
				}
			},
			miniTableWidth:100
            ,minWidth:150
		}, {
            field : 'tableType',
            title : '表单类型',
            sort : true,
            formatter  : function(row,options) {
                var value=row.tableType;
                if (value == 0) {
                    return "单表";
                } else if (value == 1) {
                    return "树结构表";
                } else if (value == 2) {
                    return "父表";
                }else {
                    return "子表";
                }
            },
            miniTableWidth:100
            ,minWidth:150
        }, {
			"field" : "controllerWebPath",
			"title" : "web路径",
			sort : true,
			miniTableWidth:100
            ,minWidth:150
		}, {
			"field" : "controllerJsonPath",
			"title" : "json路径",
			sort : true,
			miniTableWidth:100
            ,minWidth:150
		}, {
			"field" : "author",
			"title" : "作者",
			sort : true,
			miniTableWidth:100
            ,minWidth:150
		}, {
			field : 'operate',
			title : '操作'
            ,tableWidth : 400
            ,miniTableWidth:260,
			formatter  : function(row,options) {
				return $("#codetableListDiv .polar-list-form .polar-btn-inner-template").html().split('[id]').join(row.id);
			},
			fixed:'right'

		} ]];
		var options={ //配置文件
				id:"codecontent_table",//表编号
				formFilter:"codetableListFormFilter",//table过滤器名称
				outDivId:"codetableListDiv",//最外层的div编号，用来重绘表格高度
				unionId:"id",//数据的唯一编号
				netIdKey:"id",//网络请求时，传入的主键编号
				netMulitKey:"ids",//网络请求时，一组主键编号的key
				name:"表单",//此模块的名称
				formWidth:'1000px',//表单宽度
				formHeight:'600px',//表单高度
				limits:[ 10, 20, 30, 50, 100 ]//页码数据

			};
			var urls={
				listUrl:'/code/json/pageList',//列表的url
				addPage:"/code/web/add",//新增页面的url
				viewPage:"/code/web/detail",//查看页面的url
				deleteSingle:"/code/json/deleteById",//删除单条的url
				deleteMulit:"/code/json/deleteMulitById",//删除多条数据的url
				updatePage:"/code/web/update",//编辑页面的url
				updateField:"/code/json/updateField" ,//更新单个字段的url	
				genSetting:"/code/json/genSetting" //生成权限以及角色的url
			};
			var table=polar.table.layui(columns,options,urls);
			table.openColumns=function(id,that){
				polar.layer.loadLayer('/code/web/columns?id=' + id, true, 
						{width:'1000px',height:'600px',yesContent:"修改",yesBtn:true,title:"列配置",clearForm:true}, null);
			};
			table.onDataDone=function(that){
				//绑定行内列配置按钮点击事件
				 $("#"+that.options.outDivId).find("td .polar-columns-inner").bind("click", function() {
						var id=$(this).attr('polar-data');
						that.openColumns(id);
				 }); 
				//行内权限生成的点击事件
				 $("#"+that.options.outDivId).find("td .polar-setting-inner").bind("click", function() {
					 	var id=$(this).attr('polar-data');
							polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, that.urls.genSetting, true, null, {id:id});
				 }); 
			};
			table.onInitDone=function(that){
				//导入表的点击事件
				$("#"+that.options.outDivId+" .polar-toolbar .polar-import").click(function(){
					polar.layer.loadLayer('/code/web/importTable', true, 
							{width:'600px',height:'400px',yesBtn:true,title:"导入表",yesContent:"导入",clearForm:true}, null);
				});
				//重置列属性的点击事件
				$("#"+that.options.outDivId+" .polar-toolbar .polar-gen").click(function(){
					var arrselections = that.getSelection(that);
					if (arrselections.length != 1) {
						polar.dialog.alert('提示', '请选择一条数据');
					} else {
						polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, '/code/json/genColumns', true, null, {id:arrselections[0].id});
					}
				});
				//代码生成的点击事件
				$("#"+that.options.outDivId+" .polar-toolbar .polar-writeCode").click(function(){
					var arrselections = that.getSelection(that);
					if (arrselections.length != 1) {
						polar.dialog.alert('提示', '请选择一条数据');
					} else {
						polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, '/code/json/writeCodes', true, null, {id:arrselections[0].id});
					}
				});
				//权限生成的点击事件
				$("#"+that.options.outDivId+" .polar-toolbar .polar-setting").click(function(){
					var arrselections = that.getSelection(that);
					if (arrselections.length != 1) {
						polar.dialog.alert('提示', '请选择一条数据');
					} else {
						polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, that.urls.genSetting, true, null, {id:arrselections[0].id});
					}
				});
			}
	
			table.init(table);
			$(window).resize(function() { 
				table.resizeTable();
			});
	});
	</script>
</div>