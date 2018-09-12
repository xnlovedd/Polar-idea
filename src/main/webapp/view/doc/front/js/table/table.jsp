<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
	<fieldset class="layui-elem-field">
		<legend>说明</legend>
		<div class="layui-field-box">
			<span class="red-bg">表格需要依赖于表格布局，具体参见css中的列表</span><br/>
			构建一个表格需要分为如下几个部分：<br/>
			1. 配置文件:options;<br/>
			2. 访问列表:urls;<br/>
			3. 列配置:columns;<br/>
			4. 初始化表格,绑定其窗口缩放动作.<br/>
            5. 构建不同表格时，使用不同的代码来构建，<span class="red-bg">其中，layui风格的表格与Bootstrap风格的表格列属性略有不同</span>：<br/>
            var table=polar.table.layui(columns,options,urls);//构建layui风格的表格<br/>
            var table=polar.table.layui(columns,options,urls);//构建bootstrap风格的表格<br/>
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
                        表格编号
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
                        dictFormFilter
                    </td>
                    <td valign="top">
                        搜索表单的过滤器名称，必填，初始化表格时，会依据此filter渲染表单
                    </td>
                </tr>
                <tr>
                    <td valign="top">outDivId</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        userTableListDiv
                    </td>
                    <td valign="top">
                        最外层的div编号，由于表格会充满屏幕，因此需要其来计算表格高度
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
                        在响应数据中，表示数据唯一的编号
                    </td>
                </tr>
                <tr>
                    <td valign="top">netIdKey</td>
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
                        在执行删除、修改、查看时，传入到后台表示数据唯一的key，其值为列表数据中，unionId对应的数据
                    </td>
                </tr>
                <tr>
                    <td valign="top">netMulitKey</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        ids
                    </td>
                    <td valign="top">
                        在执行批量操作时，传入到后台表示数据唯一的key，其值为列表数据中，unionId对应的数据
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
                    <td valign="top">limits</td>
                    <td valign="top">
                        Object[]
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        [ 10, 20, 30, 50, 100 ]
                    </td>
                    <td valign="top">
                        页码数据
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>列参数说明</legend>

        <div class="layui-field-box">
            <span class="red-bg">更为详细的内容请参照layui的数据表格</span>
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
                    <td valign="top">sort</td>
                    <td valign="top">
                        boolean
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        是否支持排序
                    </td>
                </tr>
                <tr>
                    <td valign="top">edit</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        text
                    </td>
                    <td valign="top">
                        行内编辑模式
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
                    <td valign="top">listUrl</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        /dict/json/pageList
                    </td>
                    <td valign="top">
                        获取列表数据的url，其值不能为空
                    </td>
                </tr>
                <tr>
                    <td valign="top">addPage</td>
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
                    <td valign="top">viewPage</td>
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
                    <td valign="top">deleteSingle</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        /dict/json/deleteById
                    </td>
                    <td valign="top">
                        删除单条数据的url
                    </td>
                </tr>
                <tr>
                    <td valign="top">deleteMulit</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        /dict/json/deleteMulitById
                    </td>
                    <td valign="top">
                        删除多条数据的url
                    </td>
                </tr>
                <tr>
                    <td valign="top">updatePage</td>
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
                <tr>
                    <td valign="top">updateField</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        /dict/json/updateField
                    </td>
                    <td valign="top">
                        更新单个字段的url
                    </td>
                </tr>
                <tr>
                    <td valign="top">exportExcell</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        /dict/json/exportExcell
                    </td>
                    <td valign="top">
                        导出excell的路径
                    </td>
                </tr>
                <tr>
                    <td valign="top">importExcell</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        /dict/json/importExcell
                    </td>
                    <td valign="top">
                        导入excell的路径
                    </td>
                </tr>
                <tr>
                    <td valign="top">importExcellModel</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        /dict/json/importExcellModel
                    </td>
                    <td valign="top">
                        导入excell模板下载路径
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
                    <td valign="top">calcTableColumns</td>
                    <td valign="top">
                        total, columns, px
                    </td>
                    <td valign="top">
                        table.calcTableColumns(total, columns, px);
                    </td>
                    <td valign="top">
                         用来重新计算每个列的宽度
                    </td>
                </tr>
                <tr>
                    <td valign="top">refresh</td>
                    <td valign="top">

                    </td>
                    <td valign="top">
                        table.refresh();
                    </td>
                    <td valign="top">
                        用来重新加载表格数据
                    </td>
                </tr>

                <tr>
                    <td valign="top">destroy</td>
                    <td valign="top">

                    </td>
                    <td valign="top">
                        table.destroy();
                    </td>
                    <td valign="top">
                        用来销毁表格
                    </td>
                </tr>
                <tr>
                    <td valign="top">reSetTable</td>
                    <td valign="top">
                        that
                    </td>
                    <td valign="top">
                        table.reSetTable(table);
                    </td>
                    <td valign="top">
                        用来重置表单
                    </td>
                </tr>
                <tr>
                    <td valign="top">reDrawColumns</td>
                    <td valign="top">
                        that
                    </td>
                    <td valign="top">
                        table.reDrawColumns(table);
                    </td>
                    <td valign="top">
                        重新计算表格宽度
                    </td>
                </tr>
                <tr>
                    <td valign="top">resizeTable</td>
                    <td valign="top">

                    </td>
                    <td valign="top">
                        table.resizeTable();
                    </td>
                    <td valign="top">
                        重新绘制表格的宽度以及高度
                    </td>
                </tr>
                <tr>
                    <td valign="top">getSelection</td>
                    <td valign="top">
                        that
                    </td>
                    <td valign="top">
                        table.getSelection(table);
                    </td>
                    <td valign="top">
                        获取选中行
                    </td>
                </tr>
                <tr>
                    <td valign="top">add</td>
                    <td valign="top">
                        that
                    </td>
                    <td valign="top">
                        table.add(table);
                    </td>
                    <td valign="top">
                        打开新增表单
                    </td>
                </tr>
                <tr>
                    <td valign="top">deleteTable</td>
                    <td valign="top">
                        that
                    </td>
                    <td valign="top">
                        table.deleteTable(table);
                    </td>
                    <td valign="top">
                        删除多条数据
                    </td>
                </tr>
                <tr>
                    <td valign="top">deleteTableById</td>
                    <td valign="top">
                        that
                    </td>
                    <td valign="top">
                        table.deleteTableById(id);
                    </td>
                    <td valign="top">
                        删除一条数据
                    </td>
                </tr>
                <tr>
                    <td valign="top">updateTable</td>
                    <td valign="top">
                        that
                    </td>
                    <td valign="top">
                        table.updateTable(table);
                    </td>
                    <td valign="top">
                        打开修改的页面
                    </td>
                </tr>
                <tr>
                    <td valign="top">viewTable</td>
                    <td valign="top">
                        that
                    </td>
                    <td valign="top">
                        table.viewTable(table);
                    </td>
                    <td valign="top">
                        打开查看的页面
                    </td>
                </tr>
                <tr>
                    <td valign="top">validate</td>
                    <td valign="top">
                        that, field, value
                    </td>
                    <td valign="top">
                        table.validate(that, field, value);
                    </td>
                    <td valign="top">
                        更新字段时调用的校验方法,返回true表示校验成功
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
                    <td valign="top">onQuery</td>
                    <td valign="top">
                        that, args
                    </td>
                    <td valign="top">
                        function( that, args){<br/>
                        &emsp;console.log("table对象:"+that);<br/>
                        &emsp;console.log("查询参数:"+args);<br/>
                        }
                    </td>
                    <td valign="top">
                        当表格查询列表时，回调此方法
                    </td>
                </tr>
                <tr>
                    <td valign="top">onDataDone</td>
                    <td valign="top">
                        that
                    </td>
                    <td valign="top">
                        function(that){<br/>
                        &emsp;console.log("table对象:"+that);<br/>
                        }
                    </td>
                    <td valign="top">
                        当表格数据加载完毕后，回调此方法。在此方法之前，表格数据加载完毕之后，会绑定单元格内的查看、修改、删除按钮的点击事件
                    </td>
                </tr>
                <tr>
                    <td valign="top">onInitDone</td>
                    <td valign="top">
                        that
                    </td>
                    <td valign="top">
                        function(that){<br/>
                        &emsp;console.log("table对象:"+that);<br/>
                        }
                    </td>
                    <td valign="top">
                        当表格初始化完成后，回调此方法。在此方法之前，表格初始化完成之后，会绑定toolbar内的新增、查看、修改、删除、导入、导出按钮的点击事件
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
示例代码：
    <pre class="layui-code" lay-skin="notepad" lay-encode="true">
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
</pre>
</div>

<script type="text/javascript">
    $(function(){
        layui.code({
			about:false
		});
    });
</script>