<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="polar-content"
     cache='true' id="orgOuterDiv" >
	<input type="hidden" value='1' id="page" /> 
	<input type="hidden" value='10' id="rows" />
	<form class="polar-list-form layui-form" role="form"  lay-filter="orgOuterDiv">
		<blockquote class="layui-elem-quote polar-title">机构</blockquote>
		<div style="display: none" class="polar-btn-inner-template">
			<shiro:hasPermission name="polar:org:view:detail">
			<button class="layui-btn   layui-btn-primary layui-btn-xs  polar-detail-inner" polar-data="[id]">
				<i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:org:edit">
			<button class="layui-btn  layui-btn-primary layui-btn-xs polar-edit-inner" polar-data="[id]">
				<i class="fa fa-edit"></i> <span class="polar-btn-content">修改</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:org:delete">
			<button class="layui-btn    layui-btn-primary layui-btn-xs polar-delete-inner" polar-data="[id]">
				<i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
			</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="polar:org:add">
                <button class="layui-btn  layui-btn-primary layui-btn-xs polar-down-inner" polar-data="[code]">
                    <i class="fa fa-plus"></i> <span class="polar-btn-content">添加</span>
                </button>
             </shiro:hasPermission>
			<shiro:hasPermission name="polar:org:permission">
				<button class="layui-btn    layui-btn-primary layui-btn-xs polar-permission-inner" polar-data="[id]">
					<i class="fa fa-lock"></i> <span class="polar-btn-content">分配权限</span>
				</button>
			</shiro:hasPermission>
		</div>

	</form>
	<div  class="layui-inline polar-toolbar">
		<shiro:hasPermission name="polar:org:add">
		<button class="layui-btn  layui-btn-sm layui-btn-primary polar-add">
			<i class="fa fa-plus"></i> 新增
		</button>
		</shiro:hasPermission>
<%--		<shiro:hasPermission name="polar:org:excell:export">
		<button class="layui-btn    layui-btn-primary layui-btn-sm polar-excell-export" >
				<i class="fa fa-table"></i> 导出excell
		</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="polar:org:excell:import">
		<button class="layui-btn    layui-btn-primary layui-btn-sm polar-excell-importModel" >
				<i class="fa fa-th"></i> 导入模板
		</button>
		<button class="layui-btn    layui-btn-primary layui-btn-sm polar-excell-import" >
				<i class="fa fa-cloud-upload"></i> 导入数据
		</button>
		</shiro:hasPermission>--%>
		<div class="pull-right">
			<button class="layui-btn  layui-btn-sm layui-btn-primary polar-refresh">
				<i class="fa fa-refresh"></i> 刷新
			</button>
		</div>
	</div>
    <div style="overflow-y:auto;">
        <table id="orgTable" class='layui-table' style="table-layout: fixed;">
            <tbody></tbody>
        </table>
    </div>
	<script type="text/javascript">
	$(function(){

		var columns=[[
						{
							"field" : "name",
							"title" : "机构名称",
							sort : true
                            ,minWidth:100
                            ,weigth:1
						},
					/*	{
							"field" : "parentId",
							"title" : "上级部门",
							sort : true
                            ,minWidth:100
                            ,weigth:1
						},*/
						{
							"field" : "orgCode",
							"title" : "机构编码",
							sort : true
                            ,minWidth:100
                            ,weigth:1
						},
						{
							"field" : "contactPeople",
							"title" : "联系人",
							sort : true
                            ,minWidth:100
                            ,weigth:1
						},
						{
							"field" : "contactPhone",
							"title" : "联系电话",
							sort : true
                            ,minWidth:100
                            ,weigth:1
						},
						 {
							field : 'operate',
							title : '操作',
							formatter : function(row,options){
							 var result=$("#orgOuterDiv .polar-list-form .polar-btn-inner-template").html().split('[id]').join(row.id);
							 result=result.split('[code]').join(row.id);
							 return result;
							}
							,tableWidth : 350
                             ,miniTableWidth:220
						} ]];
			var options={ //配置文件
				id:"orgTable",//表编号
				outDivId:"orgOuterDiv",//最外层的div编号，用来重绘表格高度
				unionId:"id",//数据的唯一编号
				netIdKey:"id",//网络请求时，传入的主键编号
				netMulitKey:"ids",//网络请求时，一组主键编号的key
				name:"机构",//此模块的名称
				formWidth:'1000px',//表单宽度
				formHeight:'600px',//表单高度
				limits:[ 10, 20, 30, 50, 100 ],//页码数据
                parentId:"parentId",
				childId:"id",
				formFilter:"orgOuterDiv"
			};	
			var urls={
				listUrl:'/org/json/list',//列表的url
				addPage:"/org/web/add",//新增页面的url
				viewPage:"/org/web/detail",//查看页面的url
				deleteSingle:"/org/json/deleteById",//删除单条的url
				deleteMulit:"/org/json/deleteMulitById",//删除多条数据的url
				updatePage:"/org/web/update",//编辑页面的url
				exportExcell:"/org/json/exportExcell",//导出excell的路径
				importExcell:"/org/json/importExcell", //导入excell的路径
				importExcellModel:"/org/json/importExcellModel", //获取导入模板的路径
                permission:"/org/web/orgPermission" //角色权限的url
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
        }
			table.init(table);
			$(window).resize(function() { 
				table.resizeTable();
			});	
	});
	</script>
</div>