<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
    <fieldset class="layui-elem-field">
        <legend>列表样式</legend>
        <div class="layui-field-box">
<pre class="layui-code" lay-skin="notepad" lay-encode="true">
<div class="polar-content" > //此处为最外层的一个div，不可省略
    <form class="polar-list-form layui-form" role="form"  lay-filter='XXForm'>
        <div class="polar-btn-inner-template">
            //此处为表格每一列的操作栏对应的模板
        </div>
        <div class="layui-form-item polar-scroll layui-row">
            <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
                    <label class="layui-form-label">组名：</label>
                    <div class="layui-input-block">
                        //此处为搜索时的元素
                    </div>
            </div>
        </div>
    </form>
    <div  class="layui-inline polar-toolbar">
            //工具栏
    </div>
    <table  id="XX" lay-filter="XX" ></table>
</div>
</pre>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>class说明</legend>
        <div class="layui-field-box">
            <table class="layui-table">
                <colgroup>
                    <col width="150" >
                    <col >
                </colgroup>
                <thead>
                <tr>
                    <th>名称</th>
                    <th>说明</th>
                </tr>
                </thead>
                <tbody>

                <tr>
                    <td valign="top">polar-content</td>
                    <td valign="top">
                        1.内容面板，其会充满父布局，同时带有白色的背景。<br/>
                    </td>
                </tr>
                <tr>
                    <td valign="top">polar-list-form</td>
                    <td valign="top">
                        1.表示在此列表中,其为搜索的form表单，其不可为空。<br/>
                        2.当为浏览器视图时，其会自动隐藏。<br/>
                        3.为使其内部控件可以被渲染，隐藏，需要设置lay-filter属性。<br/>
                    </td>
                </tr>
                <tr>
                    <td valign="top">polar-scroll</td>
                    <td valign="top">
                        1.可以上下滑动。<br/>
                    </td>
                </tr>
                <tr>
                    <td valign="top">polar-toolbar</td>
                    <td valign="top">
                        1.表示在列表项中，其为工具栏，不可为空。<br/>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
</div>

<script type="text/javascript">
    $(function(){
        layui.code({
            about:false
        });
        $(".polar-run").bind("click",function () {
            var ele=$(this).parent();
            var str=ele.html().substr(0,ele.html().indexOf("<button"));
            str=str.split('<br/>').join("")
            str=str.split('<br>').join("")
            var val = new Function(str);
            val();
        });
    });
</script>