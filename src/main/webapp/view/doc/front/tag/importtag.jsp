<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
<fieldset class="layui-elem-field">
    <legend>简介</legend>
    <div class="layui-field-box">
        <ul class="site-dir layui-layer-wrap" style="display: block;">
            <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">推荐使用下面的输入框，在项目输入框整体样式修改的时候，可以通过修改输入框的标签，一键修改</li>
        </ul>
    </div>
</fieldset>
<fieldset class="layui-elem-field">
    <legend>引入标签库</legend>
    <div class="layui-field-box">
<pre class="layui-code" lay-skin="notepad" lay-encode="true">
//引入标签库
&lt;%@ taglib prefix="form" tagdir="/WEB-INF/tags/form" %&gt;
由于引用不单单需要使用自定义的标签库，可能还会需要其他的标签库，因此，框架内提交了一个通用的引入页面：
&lt;%@ include file="/view/includes/tag.jsp"%&gt;
这个标签库包含：
 1. jsp常用的c标签(c)
 2. 框架自带的标签(form,fns)
 3. shiro的标签(shiro)
 4. 格式化标签(fmt)

</pre>
        <ul class="site-dir layui-layer-wrap" style="display: block;">
            <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">
                标签库引入完成后，就可以使用各种标签啦。
            </li>
            <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">
                <span class="red-bg">由于所有标签依赖于layui的from，其必须包含在layui-form中</span>
            </li>

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