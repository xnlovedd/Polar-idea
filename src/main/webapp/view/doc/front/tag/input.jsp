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
        <legend>示例</legend>
        <div class="layui-field-box">

            <div class="layui-form-item">
                <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
                    <label class="layui-form-label">普通输入:</label>
                    <div class="layui-input-block">
                        <form:input name="orgCode" placeholder="请输入机构编码" tag="机构编码" value="${name}" vertify="maxLength,minLength,required"/>
                    </div>
                </div>
                <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
                    <label class="layui-form-label">整数输入：</label>
                    <div class="layui-input-block">
                        <form:inputNumber name="orgCode" placeholder="请输入机构编码" tag="机构编码" value="${name}" vertify="maxLength,minLength,required"/>
                    </div>
                </div>
                <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
                    <label class="layui-form-label">浮点数：</label>
                    <div class="layui-input-block">
                        <form:inputNumeric name="orgCode" placeholder="请输入机构编码" tag="机构编码" value="${name}" vertify="maxLength,minLength,required"/>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>普通输入框</legend>
        <div class="layui-field-box">

<pre class="layui-code" lay-skin="notepad" lay-encode="true">
&lt;form:input name="orgCode" placeholder="请输入机构编码" readonly="readonly" tag="机构编码" value="${"${name}"}" vertify="maxLength,minLength,required"/&gt;
</pre>
            <ul class="site-dir layui-layer-wrap" style="display: block;">
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">在上面的示例中，value="${"${name}"}" 表示在el表达式中取值。 </li>
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">普通的输入框支持的参数如下： </li>
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
                    <td valign="top">placeholder</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        请输入值
                    </td>
                    <td valign="top">
                        元素的提示语
                    </td>
                </tr>
                <tr>
                    <td valign="top">tag</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        姓名
                    </td>
                    <td valign="top">
                        元素的标签，主要用于数据校验中，如非空校验不通过，会提示：姓名不能为空
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
                    <td valign="top">vertify</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        required,phone
                    </td>
                    <td valign="top">
                        数据校验规则，支持如下规则：phone(手机号),email(邮箱),url,number(整数),date(日期),numeric(数字),identity(身份证),maxLength(最大长度),minLength(最小长度).<br />
                        多个校验规则以,隔开<br />
                    </td>
                </tr>
                <tr>
                    <td valign="top">maxLength</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        50
                    </td>
                    <td valign="top">
                        输入框最多输入字数，默认最多为50个字符，如果想要不限制，则其中为-1<br />
                        如果想要其生效，则vertify必须包含maxLength属性
                    </td>
                </tr>
                <tr>
                    <td valign="top">minLength</td>
                    <td valign="top">
                        String
                    </td>
                    <td valign="top">
                        false
                    </td>
                    <td valign="top">
                        10
                    </td>
                    <td valign="top">
                        输入框最少输入字数，如果不输入，其不限制
                        <br />
                        如果想要其生效，则vertify必须包含minLength属性
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
                        输入框的style属性
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>整数输入框</legend>
        <div class="layui-field-box">
<pre class="layui-code" lay-skin="notepad" lay-encode="true">
&lt;form:inputNumber name="orgCode" placeholder="请输入机构编码" readonly="readonly" tag="机构编码" value="${"${name}"}" vertify="maxLength,minLength,required"/&gt;
</pre>
            <ul class="site-dir layui-layer-wrap" style="display: block;">
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">在上面的示例中，value="${"${name}"}" 表示在el表达式中取值。 其只能输入整数</li>
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;" ><span class="red-bg">其支持的参数和普通的输入框一致</span> </li>
            </ul>

        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>浮点数输入框</legend>
        <div class="layui-field-box">
<pre class="layui-code" lay-skin="notepad" lay-encode="true">
&lt;form:inputNumeric name="orgCode" placeholder="请输入机构编码" readonly="readonly" tag="机构编码" value="${"${name}"}" vertify="maxLength,minLength,required"/&gt;
</pre>
            <ul class="site-dir layui-layer-wrap" style="display: block;">
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">在上面的示例中，value="${"${name}"}" 表示在el表达式中取值。其只能输入整数或者带小数点的数字 </li>
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;" ><span class="red-bg">其支持的参数和普通的输入框一致</span> </li>
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