<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
    <fieldset class="layui-elem-field">
        <legend>统一异常处理</legend>
        <div class="layui-field-box">
        在出现各种异常时，异常全部抛出，交由spring mvc的handAdapter来处理
            <pre class="layui-code" lay-skin="notepad" lay-encode="true">
                剩下的我不想写了，自己看代码去吧。
            </pre>
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