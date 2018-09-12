<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
    <blockquote class="layui-elem-quote">编码格式的树结构</blockquote>
    <div class="layui-form-item">
        <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
            <label class="layui-form-label"> 单选树：</label>
            <div class="layui-input-block">
                <form:codeSingleTree id="orgCode" values="[{\"text\":\"test1\",\"value\":\"010000\"},{\"text\":\"test2\",\"value\":\"010100\"},{\"text\":\"test3\",\"value\":\"010101\"}]"/>
            </div>
        </div>
        <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
            <label class="layui-form-label"> 多选树：</label>
            <div class="layui-input-block">
                <form:codeTree id="orgCode2" values="[{\"text\":\"test1\",\"value\":\"010000\"},{\"text\":\"test2\",\"value\":\"010100\"},{\"text\":\"test3\",\"value\":\"010101\"}]"/>
            </div>
        </div>
    </div>

    <fieldset class="layui-elem-field">
        <legend>单选树结构</legend>
        <div class="layui-field-box">
<pre class="layui-code" lay-skin="notepad" lay-encode="true">
&lt;form:codeSingleTree id="orgCode" values="${"$"}{fns:getTreeJson('groupId')}"/&gt;
</pre>

           <ul class="site-dir layui-layer-wrap" style="display: block;">
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">在上面的示例中，${"$"}{fns:getTreeJson('groupId')}表示：从树结构表中，取出树结构数据，其树结构必须为编码格式，且最多支持三层</li>
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">其支持的参数如下： </li>
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
                    <td valign="top">id</td>
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
                       元素的唯一编号，不会与别的id冲突
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
                    <td valign="top">title</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        选择组织机构
                    </td>
                    <td valign="top">
                      树结构标题
                    </td>
                </tr>
                <tr>
                    <td valign="top">width</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        200px
                    </td>
                    <td valign="top">
                        打开树结构控件的宽度
                    </td>
                </tr>
                <tr>
                    <td valign="top">height</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        400px
                    </td>
                    <td valign="top">
                        打开树结构控件的高度
                    </td>
                </tr>
                <tr>
                    <td valign="top">values</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        [{"text":"test1",value:"010000"},{"text":"test2",value:"010100"},{"text":"test3",value:"010101"}]
                    </td>
                    <td valign="top">
                        树结构的json数据
                    </td>
                </tr>

                </tbody>
            </table>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>多选树结构</legend>
        <div class="layui-field-box">
<pre class="layui-code" lay-skin="notepad" lay-encode="true">
&lt;form:codeTree id="orgCode" values="${"$"}{fns:getTreeJson('groupId')}"/&gt;
</pre>
            <ul class="site-dir layui-layer-wrap" style="display: block;">
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">在上面的示例中，${"$"}{fns:getTreeJson('groupId')}表示：从树结构表中，取出树结构数据，其树结构必须为编码格式，且最多支持三层</li>
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">其支持的参数与编码格式的树结构中单选树结构参数一致 </li>
            </ul>

        </div>
    </fieldset>
    <blockquote class="layui-elem-quote">父子编号的树结构标签</blockquote>
    <div class="layui-form-item">
        <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
            <label class="layui-form-label"> 单选树：</label>
            <div class="layui-input-block">

                <form:singelTree valueField="value" idField="value" parentIdField="pid" nameField="text" id="orgCode3" values="[{\"text\":\"test1\",\"value\":\"010000\"},{\"text\":\"test2\",\"value\":\"010100\",\"pid\":\"010000\"},{\"text\":\"test3\",\"value\":\"010101\",\"pid\":\"010100\"}]"/>
            </div>
        </div>
        <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
            <label class="layui-form-label"> 多选树：</label>
            <div class="layui-input-block">
                <form:tree valueField="value" idField="value" parentIdField="pid" nameField="text" id="orgCode4" values="[{\"text\":\"test1\",\"value\":\"010000\"},{\"text\":\"test2\",\"value\":\"010100\",\"pid\":\"010000\"},{\"text\":\"test3\",\"value\":\"010101\",\"pid\":\"010100\"}]"/>

            </div>
        </div>
    </div>

    <fieldset class="layui-elem-field">
        <legend>单选树结构</legend>
        <div class="layui-field-box">
<pre class="layui-code" lay-skin="notepad" lay-encode="true">
&lt;form:singelTree valueField="value" idField="value" parentIdField="pid" nameField="text" id="orgCode3" values="[{\"text\":\"test1\",\"value\":\"010000\"},{\"text\":\"test2\",\"value\":\"010100\",\"pid\":\"010000\"},{\"text\":\"test3\",\"value\":\"010101\",\"pid\":\"010100\"}]"/&gt;
</pre>

            <ul class="site-dir layui-layer-wrap" style="display: block;">
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">其支持的参数如下： </li>
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
                    <td valign="top">id</td>
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
                        元素的唯一编号，不会与别的id冲突
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
                    <td valign="top">title</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        选择组织机构
                    </td>
                    <td valign="top">
                        树结构标题
                    </td>
                </tr>
                <tr>
                    <td valign="top">width</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        200px
                    </td>
                    <td valign="top">
                        打开树结构控件的宽度
                    </td>
                </tr>
                <tr>
                    <td valign="top">height</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        400px
                    </td>
                    <td valign="top">
                        打开树结构控件的高度
                    </td>
                </tr>
                <tr>
                    <td valign="top">valueText</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                       test1
                    </td>
                    <td valign="top">
                        选中时，展示的文本内容
                    </td>
                </tr>
                <tr>
                    <td valign="top">values</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        [<br />&emsp;{"text":"test1","value":"1","pid":null},<br />&emsp;{"text":"test2","value":"2","pid":"1"},<br />&emsp;{"text":"test3","value":"3","pid":"2"}<br />]
                    </td>
                    <td valign="top">
                        树结构的json数据
                    </td>
                </tr>
                <tr>
                    <td valign="top">valueField</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        value
                    </td>
                    <td valign="top">
                       json数据中，保存值数据的字段名称
                    </td>
                </tr>
                <tr>
                    <td valign="top">idField</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        value
                    </td>
                    <td valign="top">
                        json数据中，标识此条数据唯一的字段名称
                    </td>
                </tr>
                <tr>
                    <td valign="top">parentIdField</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        pid
                    </td>
                    <td valign="top">
                        json数据中，标识此条数据父级编号的字段名称
                    </td>
                </tr>
                <tr>
                    <td valign="top">nameField</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        text
                    </td>
                    <td valign="top">
                        json数据中，标识其显示文本的字段名称
                    </td>
                </tr>
                <tr>
                    <td valign="top">textName</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        name
                    </td>
                    <td valign="top">
                        提交数据至后台时，提交的选中的值的文本内容。
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>多选树结构</legend>
        <div class="layui-field-box">
<pre class="layui-code" lay-skin="notepad" lay-encode="true">
&lt;form:tree valueField="value" idField="value" parentIdField="pid" nameField="text" id="orgCode3" values="[{\"text\":\"test1\",\"value\":\"010000\"},{\"text\":\"test2\",\"value\":\"010100\",\"pid\":\"010000\"},{\"text\":\"test3\",\"value\":\"010101\",\"pid\":\"010100\"}]"/&gt;

</pre>
            <ul class="site-dir layui-layer-wrap" style="display: block;">
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">其支持的参数与父子编码格式的树结构中单选树结构参数一致 </li>
            </ul>

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
