<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="polar-content" cache='true' id="userTableListDiv" >
	<input type="hidden" value='1' class="polar-page" />
	<input type="hidden" value='10' class="polar-rows" />
	<form class="polar-list-form layui-form" role="form"  lay-filter='dictFormFilter'>
		<blockquote class="layui-elem-quote polar-title">字典管理</blockquote>
		<div class="polar-btn-inner-template">
			<shiro:hasPermission name="polar:dict:view:detail">
			<button class="layui-btn layui-btn-primary layui-btn-xs polar-detail-inner" polar-data="[id]" >
				<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:dict:edit">
			<button class="layui-btn layui-btn-primary layui-btn-xs polar-edit-inner" polar-data ="[id]">
				<i class="fa fa-edit"></i> <span class="polar-btn-content">修改</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:dict:delete">
			<button class="layui-btn layui-btn-primary layui-btn-xs polar-delete-inner" polar-data="[id]">
				<i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
			</button>
			</shiro:hasPermission>
		</div>
		<div class="layui-form-item polar-scroll layui-row">
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">组名：</label>
				<div class="layui-input-block">
					<form:input name="groupName" placeholder="请输入组名" cache="true" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">组编号：</label>
				<div class="layui-input-block">
					<form:select name="groupId"  cache="true" emptyValue="全部" itemValues="${fns:allGroup()}"/>
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
				<label class="layui-form-label">备注：</label>
				<div class="layui-input-block">
					<form:input name="remark" placeholder="请输入备注" cache="true" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">排序号：</label>
				<div class="layui-input-block">
					<form:inputNumber name="orderNum" placeholder="请输入排序号" cache="true" />
				</div>
			</div>
		</div>
	</form>
	<div  class="layui-inline polar-toolbar">
		<shiro:hasPermission name="polar:dict:add">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-add">
			<i class="fa fa-plus"></i> <span class="polar-btn-content">新增</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:dict:view:detail">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-detail">
			<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:dict:edit">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-edit">
			<i class="fa fa-pencil"></i> <span class="polar-btn-content">编辑</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:dict:delete">
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
	<table  id="userContent_table" lay-filter="userContent_table">
	</table>
	<script type="text/javascript">
	$(function(){
		var columns=[[ {
			checkbox : true,
			tableWidth : 50
			}, 
			{
				"field" : "groupName",
				"title" : "组名",
				sort : true
				,miniTableWidth:100
				,edit:'text'
			}
				, {
				"field" : "groupId",
				"title" : "组编号",
				sort : true
                ,miniTableWidth:100
				,edit:'text'
			}
				, {
				"field" : "text",
				"title" : "文本内容",
				sort : true,
          	 	miniTableWidth:100,
				edit:'text'
			}
				, {
				"field" : "value",
				"title" : "值",
				sort : true
                ,miniTableWidth:100
				,edit:'text'
			}
				, {
				"field" : "remark",
				"title" : "备注",
				sort : true
                ,miniTableWidth:100
				,edit:'text'
			}
				, {
				"field" : "orderNum",
				"title" : "排序号",
				sort : true
                ,miniTableWidth:100
				,edit:'text'
			}
			, {
				field : 'operate',
				title : '操作',
				formatter  : function(row,options) {
					return $("#userTableListDiv .polar-list-form .polar-btn-inner-template").html().split('[id]').join(row.id);
				},
				tableWidth : 220,fixed:'right',miniTableWidth:150
			} ]];
		var options={ //配置文件
			id:"userContent_table",//表编号
			formFilter:"dictFormFilter",//table过滤器名称
			outDivId:"userTableListDiv",//最外层的div编号，用来重绘表格高度
			unionId:"id",//数据的唯一编号
			netIdKey:"id",//网络请求时，传入的主键编号
			netMulitKey:"ids",//网络请求时，一组主键编号的key
			name:"字典",//此模块的名称
			formWidth:'1000px',//表单宽度
			formHeight:'600px',//表单高度
			limits:[ 10, 20, 30, 50, 100 ]//页码数据
		};
		var urls={
			listUrl:'/dict/json/pageList',//列表的url
			addPage:"/dict/web/add",//新增页面的url
			viewPage:"/dict/web/detail",//查看页面的url
			deleteSingle:"/dict/json/deleteById",//删除单条的url
			deleteMulit:"/dict/json/deleteMulitById",//删除多条数据的url
			updatePage:"/dict/web/update",//编辑页面的url
			updateField:"/dict/json/updateField" //更新单个字段的url	
		};
		var table=polar.table.layui(columns,options,urls);
		table.validate=function(that,field,value){
		 	 if(field=='orderNum'){
	    		 if(!/(^$)|^\d+$/.test(value)){
	    			 layer.msg("排序号必须为数字", {
							icon : 5,
							shift : 6
						});
		    		 return false; 
	    		 }
	    	 }
		 	 return true;
		}
		table.init(table);
		$(window).resize(function() { 
			table.resizeTable();
		});
	});
	
	</script>
</div>