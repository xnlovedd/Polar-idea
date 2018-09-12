<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
    <fieldset class="layui-elem-field">
        <legend>表单样式</legend>
        <div class="layui-field-box">
<pre class="layui-code" lay-skin="notepad" lay-encode="true">
<div class='form-div' id="dicteditFormDiv">
    <form method="post" class="layui-form required-validate polar-form" id="dicteditForm" lay-filter="dicteditForm">
    </form>
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
                    <td valign="top">polar-form</td>
                    <td valign="top">
                        1.表示其为表单，必填。<br/>
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