<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="polar-content"
	cache='true' id="logsTableListDiv" >
	<input type="hidden" value='1' class="polar-page" />
	<input type="hidden" value='10' class="polar-rows" />
	<form class="polar-list-form"  role="layui-form" lay-filter="logsFormFilter">
		<blockquote class="layui-elem-quote polar-title">日志管理</blockquote>
		<div style="display: none" class="polar-btn-inner-template">
			<shiro:hasPermission name="polar:log:view:detail">
			<button class="layui-btn  layui-btn-primary layui-btn-xs polar-detail-inner" polar-data="[id]">
				<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:log:delete">
			<button class="layui-btn    layui-btn-primary layui-btn-xs polar-delete-inner" polar-data="[id]">
				<i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
			</button>
			</shiro:hasPermission>
		</div>
		<div class="layui-form-item polar-scroll layui-row">
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">登录用户：</label>
				<div class="layui-input-block">
					<form:input name="userId" placeholder="请输入当前登录用户" cache="true" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">时间：</label>
				<div class="layui-input-block">
					<form:inputTime id="time" placeholder="请输入开始时间" cache="true" format="yyyy-MM-dd" range="~" />
				</div>
			</div>
			<div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
				<label class="layui-form-label">接口名称：</label>
				<div class="layui-input-block">
					<form:input name="interfaceName" placeholder="请输入接口名称" cache="true" />
				</div>
			</div>
		</div>
	</form>
	<div class="layui-inline polar-toolbar">
		<shiro:hasPermission name="polar:log:view:detail">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-detail">
			<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:log:delete">
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
	<table  id="logsContent_table" lay-filter="logsContent_table" >
	</table>
	<script type="text/javascript">
	
	$(function(){
		var columns=[[ {
			checkbox : true,
			tableWidth:50
		}, {
			"field" : "message",
			"title" : "错误信息",
			sort : true,minWidth:200
		}
			, {
			"field" : "createTime",
			"title" : "发生时间",miniTableWidth:100,
			sort : true,minWidth:200
		}
			, {
			"field" : "interfaceName",
			"title" : "接口名称",miniTableWidth:100,
			sort : true,minWidth:160
		}, {
			"field" : "userId",
			"title" : "登录用户",miniTableWidth:100,
			sort : true,minWidth:160
		}
		, {
			field : 'operate',
			title : '操作',
			formatter : function(row,options) {
				return $("#logsTableListDiv .polar-list-form .polar-btn-inner-template").html().split('[id]').join(row.id);
			},
			tableWidth:150
            ,miniTableWidth:100
				,fixed:'right'
		} ]];
		var options={ //配置文件
			id:"logsContent_table",//表编号
            formFilter:"logsFormFilter",
			outDivId:"logsTableListDiv",//最外层的div编号，用来重绘表格高度
			unionId:"id",//数据的唯一编号
			netIdKey:"id",//网络请求时，传入的主键编号
			netMulitKey:"ids",//网络请求时，一组主键编号的key
			name:"日志",//此模块的名称
			formWidth:'1000px',//表单宽度
			formHeight:'600px',//表单高度
			limits:[ 10, 20, 30, 50, 100 ]//页码数据

		};
		var urls={
			listUrl:'/logs/json/pageList',//列表的url
			addPage:"/logs/web/add",//新增页面的url
			viewPage:"/logs/web/detail",//查看页面的url
			deleteSingle:"/logs/json/deleteById",//删除单条的url
			deleteMulit:"/logs/json/deleteMulitById",//删除多条数据的url
			updatePage:"/logs/web/update",//编辑页面的url
			updateField:"/logs/json/updateField" //更新单个字段的url	
		};
		var table=polar.table.layui(columns,options,urls);
		table.onQuery=function(that,params){
			var time=$('#time').val();
			if(time!=null&&time!='undefined'&&time!=''){
				params["startTime"] = time.split('~')[0].replace(/(^\s*)|(\s*$)/g, "")+" 00:00:00";
				params["endTime"] = time.split('~')[1].replace(/(^\s*)|(\s*$)/g, "")+" 23:59:59";
			}
			return params;
		}
		table.init(table);
		$(window).resize(function() { 
			table.resizeTable();
		});
	});
	</script>
</div>