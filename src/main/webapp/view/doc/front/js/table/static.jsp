<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
	<fieldset class="layui-elem-field">
		<legend>说明</legend>
		<div class="layui-field-box">
静态表格主要用于父子表中，其不带分页，不与普通的表格冲突,此表格应该放入form中，已完成其样式的渲染
		</div>
	</fieldset>

    <fieldset class="layui-elem-field">
        <legend>配置文件说明</legend>
        <div class="layui-field-box">
            <table class="layui-table">
                <colgroup>
                    <col width="150" >
                    <col width="100" >
                    <col width="100" >
                    <col >
                    <col >
                </colgroup>
                <thead>
                <tr>
                    <th>参数名称</th>
                    <th>类型</th>
                    <th>必填</th>
                    <th>示例</th>
                    <th>说明</th>
                </tr>
                </thead>
                <tbody>

                <tr>
                    <td valign="top">id</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        userContent_table
                    </td>
                    <td valign="top">
                        此静态表格的唯一编号
                    </td>
                </tr>
                <tr>
                    <td valign="top">toolbar</td>
                    <td valign="top">
                        dom
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        $("#dict")
                    </td>
                    <td valign="top">
                       工具条的dom对象
                    </td>
                </tr>
                <tr>
                    <td valign="top">table</td>
                    <td valign="top">
                        dom
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        $("#dict")
                    </td>
                    <td valign="top">
                        表格的dom对象
                    </td>
                </tr>
                <tr>
                    <td valign="top">formWidth</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        1000px
                    </td>
                    <td valign="top">
                        打开查看、修改时表单的宽度
                    </td>
                </tr>
                <tr>
                    <td valign="top">formHeight</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        800px
                    </td>
                    <td valign="top">
                        打开查看、修改时表单的高度
                    </td>
                </tr>

                <tr>
                    <td valign="top">listName</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        list
                    </td>
                    <td valign="top">
                       表单提交时，将会以list[index].xx形式提交至后台
                    </td>
                </tr>
                <tr>
                    <td valign="top">formFilter</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        formFilter
                    </td>
                    <td valign="top">
                        form的filter
                    </td>
                </tr>
                <tr>
                    <td valign="top">unionId</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        id
                    </td>
                    <td valign="top">
                        数据唯一标识
                    </td>
                </tr>
                <tr>
                    <td valign="top">name</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        字典
                    </td>
                    <td valign="top">
                        此模块的名称
                    </td>
                </tr>

                </tbody>
            </table>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>列参数说明</legend>

        <div class="layui-field-box">
            <table class="layui-table">
                <colgroup>
                    <col width="150" >
                    <col width="100" >
                    <col width="100" >
                    <col >
                    <col >
                </colgroup>
                <thead>
                <tr>
                    <th>参数名称</th>
                    <th>类型</th>
                    <th>必填</th>
                    <th>示例</th>
                    <th>说明</th>
                </tr>
                </thead>
                <tbody>

                <tr>
                    <td valign="top">field</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        name
                    </td>
                    <td valign="top">
                        字段名称
                    </td>
                </tr>
                <tr>
                    <td valign="top">title</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        名称
                    </td>
                    <td valign="top">
                        字段标题
                    </td>
                </tr>

                <tr>
                    <td valign="top">miniTableWidth</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        100
                    </td>
                    <td valign="top">
                        移动端时，列宽度
                    </td>
                </tr>
                <tr>
                    <td valign="top">tableWidth</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        100
                    </td>
                    <td valign="top">
                        PC端时，列宽度
                    </td>
                </tr>
                <tr>
                    <td valign="top">minWidth</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        100
                    </td>
                    <td valign="top">
                        列最小宽度
                    </td>
                </tr>
                <tr>
                    <td valign="top">weight</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        1
                    </td>
                    <td valign="top">
                        列权重
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>URL参数说明</legend>

        <div class="layui-field-box">
            <span class="red-bg">以下支持的列参数，在toolbar中会按照class与对应的按钮绑定</span>
            <table class="layui-table">
                <colgroup>
                    <col width="150" >
                    <col width="100" >
                    <col width="100" >
                    <col >
                    <col >
                </colgroup>
                <thead>
                <tr>
                    <th>参数名称</th>
                    <th>类型</th>
                    <th>必填</th>
                    <th>示例</th>
                    <th>说明</th>
                </tr>
                </thead>
                <tbody>


                <tr>
                    <td valign="top">addUrl</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        /dict/web/add
                    </td>
                    <td valign="top">
                       打开新增页面的url
                    </td>
                </tr>
                <tr>
                    <td valign="top">detailUrl</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        /dict/web/detail
                    </td>
                    <td valign="top">
                        打开详情页面的url
                    </td>
                </tr>

                <tr>
                    <td valign="top">updateUrl</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        /dict/web/updatePage
                    </td>
                    <td valign="top">
                        编辑页面的url
                    </td>
                </tr>

                </tbody>
            </table>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>内置方法说明</legend>

        <div class="layui-field-box">
            表格内置了部分方法，可以通过obj.方法名称 调用,以下参数中的that均指表格本身
            <table class="layui-table">
                <colgroup>
                    <col width="150" >
                    <col  width="150" >
                    <col  width="300">
                    <col >
                </colgroup>
                <thead>
                <tr>
                    <th>方法名称</th>
                    <th>参数</th>
                    <th>示例</th>
                    <th>说明</th>
                </tr>
                </thead>
                <tbody>

                <tr>
                    <td valign="top">deleteRow</td>
                    <td valign="top">
                        id
                    </td>
                    <td valign="top">
                        table.deleteRow(id);
                    </td>
                    <td valign="top">
                        删除一条数据
                    </td>
                </tr>
                <tr>
                    <td valign="top">addRow</td>
                    <td valign="top">
                        row
                    </td>
                    <td valign="top">
                        table.addRow(row);
                    </td>
                    <td valign="top">
                        添加一条数据，id不能为空
                    </td>
                </tr>
                <tr>
                    <td valign="top">updateRow</td>
                    <td valign="top">
                        row
                    </td>
                    <td valign="top">
                        table.updateRow(row);
                    </td>
                    <td valign="top">
                        更新一条数据，id不能为空
                    </td>
                </tr>
                <tr>
                    <td valign="top">getRowById</td>
                    <td valign="top">
                        id
                    </td>
                    <td valign="top">
                     var row= table.getRowById(id);
                    </td>
                    <td valign="top">
                        依据id获取一行数据
                    </td>
                </tr>
                <tr>
                    <td valign="top">getSelectRow</td>
                    <td valign="top">

                    </td>
                    <td valign="top">
                        var row= table.getSelectRow();
                    </td>
                    <td valign="top">
                        获取选中的数据
                    </td>
                </tr>
                <tr>
                    <td valign="top">init</td>
                    <td valign="top">

                    </td>
                    <td valign="top">
                        table.init();
                    </td>
                    <td valign="top">
                        初始化表格
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>回调方法说明</legend>

        <div class="layui-field-box">
            内置部分回调方法，如果重写了这些方法，则会回调这些方法
            <table class="layui-table">
                <colgroup>
                    <col width="150" >
                    <col  width="150" >
                    <col  width="300">
                    <col >
                </colgroup>
                <thead>
                <tr>
                    <th>方法名称</th>
                    <th>参数</th>
                    <th>示例</th>
                    <th>说明</th>
                </tr>
                </thead>
                <tbody>

                <tr>
                    <td valign="top">onInitDone</td>
                    <td valign="top">

                    </td>
                    <td valign="top">
                        function( ){<br/>
                        &emsp;
                        }
                    </td>
                    <td valign="top">
                        表格初始化成功的回掉
                    </td>
                </tr>
                <tr>
                    <td valign="top">onRenderDataDone</td>
                    <td valign="top">

                    </td>
                    <td valign="top">
                        function(){<br/>

                        }
                    </td>
                    <td valign="top">
                        数据渲染成功的回掉
                    </td>
                </tr>

                </tbody>
            </table>
        </div>
    </fieldset>
示例代码：
    <pre class="layui-code" lay-skin="notepad" lay-encode="true">
var options={
   toolbar:$("#ChildToolbar"),//工具条的dom对象
   table:$("#Table"),//表格的dom对象
   formWidth:"1000px",//页面宽度
   formHeight:"800px",//页面高度
   listName:"dict",//列表name
   formFilter:"dictForm",//外面form的filter属性
   unionId:"id",//数据唯一标识
   name:字典",//模块名称
   id:"dict"
};
var urls={
   addUrl:"/add",//添加页面的url
   detailUrl:"/detail",//详情页面的url
   updateUrl:"/update"//修改页面的url
};
polar.table.staticTable(options,urls,columns,[]).init();

</pre>
</div>

<script type="text/javascript">
    $(function(){
        layui.code({
			about:false
		});
    });
</script>