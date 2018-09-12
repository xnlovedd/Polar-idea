<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
	<fieldset class="layui-elem-field">
		<legend>简介</legend>
		<div class="layui-field-box">
			<ul class="site-dir layui-layer-wrap" style="display: block;">
				<li style="list-style-type: circle;list-style-position: inside;margin: 6px;">内置的js文件封装了表格、表单、ajax请求、省市区联动、标签页切换等各种方法.</li>
				<li style="list-style-type: circle;list-style-position: inside;margin: 6px;">其依赖于jquery与layui.</li>
			</ul>
		</div>
	</fieldset>

	<pre class="layui-code" lay-skin="notepad" lay-encode="true">
&lt;%@ include file="/view/includes/FrameWorks.jsp"%>//引入js库，其会引入相关的js文件。
$(document).ready(function() {
&emsp;&emsp;//初始化组件
&emsp;&emsp;polar.init(function() {
&emsp;&emsp;&emsp;&emsp;//组件初始化成功，初始化标签页
&emsp;&emsp;&emsp;&emsp;polar.tab.init();
&emsp;&emsp;})
});
	</pre>
	<fieldset class="layui-elem-field">
		<legend>公共方法</legend>
		<div class="layui-field-box">
			<ul class="site-dir layui-layer-wrap" style="display: block;">
				<li style="list-style-type: circle;list-style-position: inside;margin: 6px;">公共方法使用时，以polar.开头</li>
			</ul>
			<table class="layui-table">
				<colgroup>
					<col width="150" >
					<col >
					<col >
				</colgroup>
				<thead>
				<tr>
					<th>方法名称</th>
					<th>示例</th>
					<th>说明</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td valign="top">isNull</td>
					<td valign="top">
						polar.isNull(str);//判断str是否为空
					</td>
					<td valign="top">
						判断对象是否为空
					</td>
				</tr>
				<tr>
					<td valign="top">isArray</td>
					<td valign="top">
						polar.isArray(str);//判断str是否为数组
					</td>
					<td valign="top">
					判断对象是否为数组
					</td>
				</tr>
				<tr>
					<td valign="top">uuid</td>
					<td valign="top">
						polar.uuid();//生成一个随机的32位编号
					</td>
					<td valign="top">
						生成一个随机的32位编号
					</td>
				</tr>
				<tr>
					<td valign="top">init</td>
					<td valign="top">
						polar.init(function(){<br/>
						&emsp;&emsp;console.log("初始化成功了");<br/>
						});//初始化组件
					</td>
					<td valign="top">初始化组件
					</td>
				</tr>
				</tbody>
			</table>
		</div>
	</fieldset>

	<fieldset class="layui-elem-field">
		<legend>公共配置文件</legend>
		<div class="layui-field-box">
			<ul class="site-dir layui-layer-wrap" style="display: block;">
				<li style="list-style-type: circle;list-style-position: inside;margin: 6px;">用来定义一些常量，此处可以随时修改</li>
				<li style="list-style-type: circle;list-style-position: inside;margin: 6px;">可以使用polar.constants.常量名称 来获取常量值</li>
				<li style="list-style-type: circle;list-style-position: inside;margin: 6px;" ><span class="red-bg">如非特殊需要，常量请不要修改</span></li>
			</ul>
			<table class="layui-table">
				<colgroup>
					<col width="150" >
					<col width="300">
				</colgroup>
				<thead>
				<tr>
					<th>常量名称</th>
					<th>说明</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td valign="top">noPermission</td>
					<td valign="top">
						在标准的数据格式中，其表示无权限访问的代码值。
					</td>
				</tr>
				<tr>
					<td valign="top">success</td>
					<td valign="top">
						在标准的数据格式中，其表示成功的代码值。
					</td>
				</tr>
				<tr>
					<td valign="top">anonymous</td>
					<td valign="top">
						在标准的数据格式中，其表示用户未登录的代码值，其会导致重定向至主页。
					</td>
				</tr>
				<tr>
					<td valign="top">forceDownLine</td>
					<td valign="top">
						在标准的数据格式中，其表示用户被强制下线的代码值，其会导致重定向至主页。
					</td>
				</tr>
				<tr>
					<td valign="top">viewPic</td>
					<td valign="top">
						查看附件的地址。
					</td>
				</tr>
				<tr>
					<td valign="top">uploadFile</td>
					<td valign="top">
						上传文件的地址
					</td>
				</tr>
				<tr>
					<td valign="top">navePage</td>
					<td valign="top">
						标签页中首页的地址
					</td>
				</tr>
				<tr>
					<td valign="top">logInPage</td>
					<td valign="top">
						登录页面地址
					</td>
				</tr>
				<tr>
					<td valign="top">mainPage</td>
					<td valign="top">
						主页的地址
					</td>
				</tr>
				<tr>
					<td valign="top">logInUrl</td>
					<td valign="top">
						登录接口地址
					</td>
				</tr>
				<tr>
					<td valign="top">logOutUrl</td>
					<td valign="top">
						退出登录接口地址
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
    });
</script>