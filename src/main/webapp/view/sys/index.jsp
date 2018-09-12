<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<style>
.title li{
padding: 5px;
font-style: normal;
list-style-type: circle;
list-style-position: inside;
}
.title em{
font-style: normal;
}
</style>
<div class="layui-side-scroll" style="width: 100%;background-color: white;">

<div class='form-div'  >
<blockquote class="layui-elem-quote">框架</blockquote>
 <fieldset class="layui-elem-field">
  <legend >说明</legend>
  <div class="layui-field-box">
   <ul class="site-dir layui-layer-wrap" style="display: block;">
	  <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">这个人比较懒，说明也没说。</li>
  </ul>
  </div>
</fieldset>
<blockquote class="layui-elem-quote">内置对象</blockquote>
 <fieldset class="layui-elem-field">
  <legend>说明</legend>
  <div class="layui-field-box">
   <ul class="site-dir layui-layer-wrap" style="display: block;">
	  <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">这个人比较懒，说明也没说。</li>
  </ul>
  </div>
</fieldset>
<blockquote class="layui-elem-quote" >日志管理</blockquote>
 <fieldset class="layui-elem-field">
  <legend >说明</legend>
  <div class="layui-field-box">
   <ul class="site-dir layui-layer-wrap" style="display: block;">
	  <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">这个人比较懒，说明也没说。</li>
  </ul>
  </div>
</fieldset>
<blockquote class="layui-elem-quote" >历史版本</blockquote>
 <fieldset class="layui-elem-field">
  <legend >历史版本</legend>
  <div class="layui-field-box">
   <ul class="layui-timeline">
  <li class="layui-timeline-item">
    <i class="layui-icon layui-timeline-axis">&#xe63f;</i>
    <div class="layui-timeline-content layui-text">
      <h3 class="layui-timeline-title">2017-12-20</h3>
      <p>初始稳定版本发布，整合Spring MVC,shiro,redis,druid,ehcache。</p>
      <p>支持负载均衡、分布式部署。</p>
    </div>
  </li>
  <li class="layui-timeline-item">
    <i class="layui-icon layui-timeline-axis">&#xe63f;</i>
    <div class="layui-timeline-content layui-text">
      <h3 class="layui-timeline-title">2017-12-20</h3>
       <p>下一个版本将支持MongoDb，敬请期待</p>
    </div>
  </li>
</ul>
  </div>
</fieldset>
<blockquote class="layui-elem-quote" id="table">表格</blockquote>
 <fieldset class="layui-elem-field">
  <legend id="table-in">说明</legend>
  <div class="layui-field-box">
   <ul class="site-dir layui-layer-wrap" style="display: block;">
	  <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">使用简洁，代码干净。</li>
      <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">提供两种模板：layui-table、bootstrap-table。</li>
      <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">模板切换方便，仅需修改一到两个配置文件。</li>
  </ul>
  </div>
</fieldset>
<fieldset class="layui-elem-field" id="table-boot">
  <legend>bootstarp-table</legend>
  <div class="layui-field-box">
   <ul class="site-dir layui-layer-wrap" style="display: block;">
	  <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">开源框架，其扩展控件支持行内编辑、拖拽等。</li>
      <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">提供两种模板：layui-table、bootstrap-table。</li>
  </ul>
  </div>
</fieldset>
<fieldset class="layui-elem-field" id="table-layui">
  <legend>layui-table</legend>
  <div class="layui-field-box">
   <ul class="site-dir layui-layer-wrap" style="display: block;">
	  <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">代码简洁，修改方便，推荐使用此表格。</li>
      <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">样式好看，易于扩展。</li>
      <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">发布时间较短，有一些问题，但是官方能够及时更新BUG。</li>
  </ul>
  </div>
</fieldset>
<fieldset class="layui-elem-field" id="table-use">
  <legend>使用</legend>
  <div class="layui-field-box">
  	bootstrap-table:
    <pre class="layui-code" lay-skin="notepad" lay-encode="true">
var columns={};//列属性定义，具体查看bootstrap-table的列属性
var options={ //配置文件
 queryForm:"queryForm",//搜索表单的编号
 id:"content_table",//表编号
 tableFilter:"content_table",//table过滤器名称
 toolbarId:"toolbar",//工具条ID
 outDivId:"tableListDiv",//最外层的div编号，用来重绘表格高度
 unionId:"id",//数据的唯一编号
 netIdKey:"id",//网络请求时，传入的主键编号
 netMulitKey:"ids",//网络请求时，一组主键编号的key
 name:"字典",//此模块的名称
 formWidth:'1000px',//表单宽度
 formHeight:'600px',//表单高度
 limits:[ 10, 20, 30, 50, 100 ],//页码数据
  difference:10 //差值
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
 var table=polar.table.boot(columns,options,urls);//重点，bootstrap和Layui在此区分
  table.init(table);
 });
	</pre>
	layui-table
	 <pre class="layui-code" lay-skin="notepad">
var columns=[{}];//列属性定义，具体查看layuitable的列属性
var options={ //配置文件
         queryForm:"queryForm",//搜索表单的编号
         id:"content_table",//表编号
         tableFilter:"content_table",//table过滤器名称
         toolbarId:"toolbar",//工具条ID
         outDivId:"tableListDiv",//最外层的div编号，用来重绘表格高度
         unionId:"id",//数据的唯一编号
         netIdKey:"id",//网络请求时，传入的主键编号
         netMulitKey:"ids",//网络请求时，一组主键编号的key
         name:"字典",//此模块的名称
         formWidth:'1000px',//表单宽度
         formHeight:'600px',//表单高度
         limits:[ 10, 20, 30, 50, 100 ],//页码数据
         difference:10 //差值
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
 table.init(table);
});
	</pre>
</div>
</fieldset>
 <div style="display: none" id="menu">
 <div  class="layui-layer-content title" style="height: 100%;">
 <ul class="site-dir layui-layer-wrap" style="display: block;">
  <li><a href="#table">表格</a></li>
  <ul style="margin-left: 15px;">
    <li><a href="#table-in" class=""><em>说明</em></a></li>
    <li><a href="#table-boot">title<em>bootstrap-table</em></a></li>
    <li><a href="#table-layui">content<em>layui-table</em></a></li>
    <li><a href="#table-use" class=""><em>使用</em></a></li>
  </ul>
</ul>
 </div>
 </div>
</div>
</div>
<script type="text/javascript">
$(function(){
	var index=layer.open({
		  type: 1 //此处以iframe举例
		  ,title: '菜单'
		  ,area: ['200px', '400px']
		  ,shade: 0
		  ,closeBtn:0
		  ,offset: [($(window).height()-400)/2+'px',$(window).width()-30-200+'px' ]
		  ,maxmin: true
		  ,content: $("#menu").html()
		  ,resize:false,
		  maxmin:false,
		  shade:0
		});
	polar.table.target={
		destroy:function(){
	layer.close(index);
		}
	};
	 layui.code(); 
});
</script>