<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
    <fieldset class="layui-elem-field">
        <legend>示例</legend>
        <div class="layui-field-box">
            <div class="layui-form-item layui-form">
                <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
                    <label class="layui-form-label">单图片上传:</label>
                    <div class="layui-input-block">
                        <form:img name="orgCode"  />
                    </div>
                </div>
                <div class="layui-inline layui-col-xs12 layui-col-sm12 layui-col-md12">
                    <label class="layui-form-label">多图片上传:</label>
                    <div class="layui-input-block">
                        <form:multiImg name="orgCode2" max="3" />
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>单图片上传</legend>
        <div class="layui-field-box">
<pre class="layui-code" lay-skin="notepad" lay-encode="true">
&lt;form:img name="orgCode"  /&gt;
</pre>

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
                        true
                    </td>
                    <td valign="top">
                        testName
                    </td>
                    <td valign="top">
                        元素的name值，表单提交时，此值作为key
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
                        1
                    </td>
                    <td valign="top">
                        元素的默认值,如果为1，则其会被选中
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
                        图片显示的宽度，默认80px
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
                        图片显示的高度，默认80px
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>多图片上传</legend>
        <div class="layui-field-box">
            多文件上传时，如设置name为testName，则为配合spring mvc其上传的key为：testName[0],testName[1],testName[2]
<pre class="layui-code" lay-skin="notepad" lay-encode="true">
&lt;form:multiImg name="orgCode" max="3" /&gt;
</pre>

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
                        true
                    </td>
                    <td valign="top">
                        testName
                    </td>
                    <td valign="top">
                        元素的name值，表单提交时，此值作为key
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
                        1
                    </td>
                    <td valign="top">
                        元素的默认值,如果为1，则其会被选中
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
                        图片显示的宽度，默认80px
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
                        图片显示的高度，默认80px
                    </td>
                </tr>
                <tr>
                    <td valign="top">max</td>
                    <td valign="top">
                        int
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        3
                    </td>
                    <td valign="top">
                        最大上传数量，为-1时不限制
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