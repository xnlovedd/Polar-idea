<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
    <fieldset class="layui-elem-field">
        <legend>简介</legend>
        <div class="layui-field-box">
            <ul class="site-dir layui-layer-wrap" style="display: block;">
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">下拉列表标签规定了下拉列表的样式，并且可以与内在的字典模块联合使用</li>
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">你必须使用layui.form.render()方法来渲染视图。</li>
            </ul>
        </div>
    </fieldset>

    <fieldset class="layui-elem-field">
        <legend>示例</legend>
        <div class="layui-field-box">
            <div class="layui-form-item layui-form">
                <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
                    <label class="layui-form-label">下拉列表:</label>
                    <div class="layui-input-block">
                        <form:select name="orgCode" itemValues="${fns:getDict('testName')}" readonly="readonly"   />
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>下拉列表</legend>
        <div class="layui-field-box">
<pre class="layui-code" lay-skin="notepad" lay-encode="true">
&lt;form:select name="orgCode" itemValues="${"$"}{fns:getDict('testName')}" readonly="readonly"  value="${"${name}"}" /&gt;
</pre>
            <ul class="site-dir layui-layer-wrap" style="display: block;">
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">在上面的示例中，value="${"${name}"}" 表示在el表达式中取值。 </li>
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">在上面的示例中，${"$"}{fns:getDict('testName')}表示：其item的数据从内置字典表中获取，其组名为testName</li>
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">下拉列表支持的参数如下： </li>
            </ul>
            <table class="layui-table">
                <colgroup>
                    <col width="150" >
                    <col width="100" >
                    <col width="50" >
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
                    <td valign="top">itemValues</td>
                    <td valign="top">
                        List
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        ${"$"}{fns:getDict('testName')}
                    </td>
                    <td valign="top">
                        元素的子项
                    </td>
                </tr>
                <tr>
                    <td valign="top">name</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        testName
                    </td>
                    <td valign="top">
                       元素的name值，表单提交时，此值作为key
                    </td>
                </tr>
                <tr>
                    <td valign="top">filter</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        myFilter
                    </td>
                    <td valign="top">
                        layui的filter,可以通过其刷新视图
                    </td>
                </tr>
                <tr>
                    <td valign="top">id</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        id
                    </td>
                    <td valign="top">
                       元素的id编号，建议不使用，id可能会造成冲突等各种问题
                    </td>
                </tr>
                <tr>
                    <td valign="top">value</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                       男
                    </td>
                    <td valign="top">
                        元素的默认值
                    </td>
                </tr>
                <tr>
                    <td valign="top">cache</td>
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
                       当tab页面切换时，如果cache为true,将会保存切换前的值，当下次切换回来时，此值仍然存在
                    </td>
                </tr>
                <tr>
                    <td valign="top">emptyValue</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        全部
                    </td>
                    <td valign="top">
                        下拉列表不选择时的值
                    </td>
                </tr>
                <tr>
                    <td valign="top">readonly</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        readonly
                    </td>
                    <td valign="top">
                        只读属性
                    </td>
                </tr>
                <tr>
                    <td valign="top">classes</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        testclass classA
                    </td>
                    <td valign="top">
                        class属性，多个class以空格隔开
                    </td>
                </tr>
                <tr>
                    <td valign="top">style</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        width:100px;height:200px
                    </td>
                    <td valign="top">
                       元素框的style属性
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
        layui.form.render();
    });
</script>