<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
    <fieldset class="layui-elem-field">
        <legend>简介</legend>
        <div class="layui-field-box">
            <ul class="site-dir layui-layer-wrap" style="display: block;">
                <li style="list-style-type: circle;list-style-position: inside;margin: 6px;">内置的fns标签提供了对数据的一些基本操作，标签可以用于jsp页面中的任意地方</li>
            </ul>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>数据操作</legend>
        <div class="layui-field-box">
<pre class="layui-code" lay-skin="notepad" lay-encode="true">
//引入标签库
&lt;%@ taglib prefix="form" tagdir="/WEB-INF/tld/fns" %&gt;
由于引用不单单需要使用自定义的标签库，可能还会需要其他的标签库，因此，框架内提交了一个通用的引入页面：
&lt;%@ include file="/view/includes/tag.jsp"%&gt;
${"$"}{fns:getDict('groupId')}  //获取组编号为groupId的所有字典数据
</pre>

            <table class="layui-table">
                <colgroup>
                    <col width="150" >
                    <col width="150" >
                    <col >
                    <col >
                    <col >
                </colgroup>
                <thead>
                <tr>
                    <th>方法名称</th>
                    <th>返回类型</th>
                    <th>参数</th>
                    <th>示例</th>
                    <th>说明</th>
                </tr>
                </thead>
                <tbody>

                <tr>
                    <td valign="top">getDict</td>
                    <td valign="top">List</td>
                    <td valign="top">
                        String groupId
                    </td>
                    <td valign="top">
                        ${"$"}{fns:getDict('groupId')}
                    </td>
                    <td valign="top">
                        获取组编号为groupId的所有字典数据
                    </td>
                </tr>
                <tr>
                    <td valign="top">getDictJson</td>
                    <td valign="top">String</td>
                    <td valign="top">
                        String groupId
                    </td>
                    <td valign="top">
                        ${"$"}{fns:getDictJson('groupId')}
                    </td>
                    <td valign="top">
                        获取组编号为groupId的所有字典数据,其返回值为json数据
                    </td>
                </tr>
                <tr>
                    <td valign="top">allRoles</td>
                    <td valign="top">List</td>
                    <td valign="top">

                    </td>
                    <td valign="top">
                        ${"$"}{fns:allRoles()}
                    </td>
                    <td valign="top">
                        获取所有定义的角色信息
                    </td>
                </tr>
                <tr>
                    <td valign="top">allRolesJson</td>
                    <td valign="top">String</td>
                    <td valign="top">

                    </td>
                    <td valign="top">
                        ${"$"}{fns:allRolesJson()}
                    </td>
                    <td valign="top">
                        获取所有定义的角色信息,其返回值为json格式
                    </td>
                </tr>
                <tr>
                    <td valign="top">allPermissions</td>
                    <td valign="top">List</td>
                    <td valign="top">

                    </td>
                    <td valign="top">
                        ${"$"}{fns:allPermissions()}
                    </td>
                    <td valign="top">
                        获取所有定义的权限信息
                    </td>
                </tr>
                <tr>
                    <td valign="top">allPermissionsJson</td>
                    <td valign="top">String</td>
                    <td valign="top">

                    </td>
                    <td valign="top">
                        ${"$"}{fns:allPermissionsJson()}
                    </td>
                    <td valign="top">
                        获取所有定义的权限信息,其返回值为json格式
                    </td>
                </tr>
                <tr>
                    <td valign="top">getTree</td>
                    <td valign="top">List</td>
                    <td valign="top">
                        String groupId
                    </td>
                    <td valign="top">
                        ${"$"}{fns:getTree('groupId')}
                    </td>
                    <td valign="top">
                        获取树结构对象列表
                    </td>
                </tr>
                <tr>
                    <td valign="top">getTreeJson</td>
                    <td valign="top">String</td>
                    <td valign="top">
                        String groupId
                    </td>
                    <td valign="top">
                        ${"$"}{fns:getTreeJson('groupId')}
                    </td>
                    <td valign="top">
                        获取树结构对象列表,其返回值为json数据
                    </td>
                </tr>
                <tr>
                    <td valign="top">allGroup</td>
                    <td valign="top">List</td>
                    <td valign="top">

                    </td>
                    <td valign="top">
                        ${"$"}{fns:allGroup()}
                    </td>
                    <td valign="top">
                        获取字典中已定义的所有组名
                    </td>
                </tr>

                <tr>
                    <td valign="top">allTreeGroup</td>
                    <td valign="top">List</td>
                    <td valign="top">

                    </td>
                    <td valign="top">
                        ${"$"}{fns:allTreeGroup()}
                    </td>
                    <td valign="top">
                        获取树结构字典中已定义的所有组名
                    </td>
                </tr>

                <tr>
                    <td valign="top">allMenus</td>
                    <td valign="top">List</td>
                    <td valign="top">

                    </td>
                    <td valign="top">
                        ${"$"}{fns:allMenus()}
                    </td>
                    <td valign="top">
                       获取所有的菜单
                    </td>
                </tr>
                <tr>
                    <td valign="top">allMenusJson</td>
                    <td valign="top">String</td>
                    <td valign="top">

                    </td>
                    <td valign="top">
                        ${"$"}{fns:allMenusJson()}
                    </td>
                    <td valign="top">
                        获取所有的菜单,其返回值为json
                    </td>
                </tr>
                <tr>
                    <td valign="top">formatDateTime</td>
                    <td valign="top">String</td>
                    <td valign="top">
                        Date date
                    </td>
                    <td valign="top">
                        ${"$"}{fns:formatDateTime(test)}
                    </td>
                    <td valign="top">
                        将日期对象Date转为标准格式字符串yyyy-mm-dd hh:mm:ss显示,其中test为内置对象中,key为test的日期对象
                    </td>
                </tr>
                <tr>
                    <td valign="top">formatDateTimeCustom</td>
                    <td valign="top">String</td>
                    <td valign="top">
                        Date date,String formatter
                    </td>
                    <td valign="top">
                        ${"$"}{fns:formatDateTimeCustom(test,'yyyy-mm-dd hh:mm:ss')}
                    </td>
                    <td valign="top">
                        将日期对象按照指定格式转换为字符串
                    </td>
                </tr>
                <tr>
                    <td valign="top">getFileName</td>
                    <td valign="top">String</td>
                    <td valign="top">
                        String url
                    </td>
                    <td valign="top">
                        ${"$"}{fns:getFileName('/a/b/c.jpg')}
                    </td>
                    <td valign="top">
                        根据url获取文件名称
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