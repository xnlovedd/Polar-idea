<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
    <fieldset class="layui-elem-field">
        <legend>区域选择</legend>
        <div class="layui-field-box">
            <form method="post" class="layui-form" lay-filter="testForm">
            <div class="layui-form-item">
                <div class="layui-inline layui-col-xs12 layui-col-sm12 layui-col-md12">
                    <label class="layui-form-label"> 区域选择：</label>
                    <div class="layui-input-block" >
                        <form:area id="area11" name="orgCode"  value="110101" />
                    </div>
                </div>
            </div>
            </form>
<pre class="layui-code" lay-skin="notepad" lay-encode="true">

       &lt;form method="post" class="layui-form" lay-filter="testForm"&gt;
            &lt;div class="layui-form-item"&gt;
                &lt;div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3"&gt;
                    &lt;label class="layui-form-label"&gt; 单选树：&lt;/label&gt;
                     &lt;div class="layui-input-block" &gt;
                        &lt;form:area id="area11" name="orgCode"  value="110101" /&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
           &lt;/div&gt;
        &lt;/form&gt;
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
                    <td valign="top">id</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        true
                    </td>
                    <td valign="top">
                        1
                    </td>
                    <td valign="top">
                        元素的唯一编号。
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
                        110101
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