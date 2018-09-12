<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
    <fieldset class="layui-elem-field">
        <legend>示例</legend>
        <div class="layui-field-box">
            <div class="layui-form-item layui-form">

                <div class="layui-inline layui-col-xs12 layui-col-sm12 layui-col-md12">
                    <div class="layui-input-block">
                        <form:richtext name="test111" value="测试文本域"    />
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>富文本编辑器</legend>
        <div class="layui-field-box">
<pre class="layui-code" lay-skin="notepad" lay-encode="true">
&lt;form:richtext name="orgCode"  value="1" /&gt;
你必须使用下列方法构建富文本编辑器：
 layui.layedit.build('orgCode');
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
        layui.layedit.build('test111');
        //  layui.form.render();
    });
</script>