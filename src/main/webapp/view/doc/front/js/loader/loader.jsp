<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
	<fieldset class="layui-elem-field">
		<legend>简介</legend>
		<div class="layui-field-box">
			加载器使用ajax加载远程数据，其内部封装好了各种逻辑，针对json格式的数据，提供加载成功和失败的回调
		</div>
	</fieldset>

	<pre class="layui-code" lay-skin="notepad" lay-encode="true">
	polar.loader.load(loadSuccess, loadError, url, loading, options, data);
	</pre>
	<fieldset class="layui-elem-field">
		<legend>参数说明</legend>
		<div class="layui-field-box">
			<table class="layui-table">
				<colgroup>
					<col width="150" >
					<col width="200">
					<col >
					<col >
				</colgroup>
				<thead>
				<tr>
					<th>参数名称</th>
					<th>参数类型</th>
					<th>示例</th>
					<th>说明</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td valign="top">loadSuccess</td>
					<td valign="top">function</td>
					<td valign="top">
function(contentType,url,loading,options,data){<br/>
						&emsp;if (loading) {//开启了加载框，关闭掉<br/>
						&emsp;&emsp;polar.dialog.closeLoading();//关闭加载中对话框<br/>
						&emsp;}<br/>
}<br/>
					</td>
					<td valign="top">
						加载成功的回调，其包含五个参数：<br/>
						&emsp;contentType:响应的contentType头文件<br/>
						&emsp;url:远程调用地址<br/>
						&emsp;loading:是否开启加载框<br/>
						&emsp;options:配置文件,与options一致<br/>
						&emsp;data:远程调用时，携带的参数
					</td>
				</tr>
				<tr>
					<td valign="top">loadError</td>
					<td valign="top">function</td>
					<td valign="top">
function(XMLHttpRequest, textStatus, errorThrown, url, loading, options, data){<br/>
&emsp;if (loading) {<br/>
&emsp;&emsp;polar.dialog.closeLoading();//关闭加载中对话框<br/>
&emsp;}<br/>
}
					</td>
					<td valign="top">
						加载失败的回调，参数如下：<br/>
						&emsp;XMLHttpRequest:具体见jquery,ajax<br/>
						&emsp;textStatus:响应状态码<br/>
						&emsp;errorThrown:错误信息<br/>
						&emsp;url:远程调用地址<br/>
						&emsp;loading:是否开启加载框<br/>
						&emsp;options:配置文件,与options一致<br/>
						&emsp;data:远程调用时，携带的参数
					</td>
				</tr>
				<tr>
					<td valign="top">url</td>
					<td valign="top">String</td>
					<td valign="top">
						/test
					</td>
					<td valign="top">
						远程调用地址
					</td>
				</tr>
				<tr>
					<td valign="top">loading</td>
					<td valign="top">boolean</td>
					<td valign="top">
						true
					</td>
					<td valign="top">
						加载数据时，是否打开加载框
					</td>
				</tr>
				<tr>
					<td valign="top">options</td>
					<td valign="top">Object</td>
					<td valign="top">
{<br/>
&emsp;&emsp;closeIndex:10,//关闭的图层编号<br/>
&emsp;&emsp;refresh:true,//刷新当前的表格<br/>
&emsp;&emsp;onRequestOk:function(data){//请求成功的回调<br/>
&emsp;&emsp;&emsp; console.log("数据请求成功了，其code:"+data.code+",message:"+data.msg+",count:"+data.count);<br/>
&emsp; &emsp;}<br/>
}
					</td>
					<td valign="top">
						参数也可自己定义,当加载器加载数据成功/失败后，会将配置文件回传给回调方法.<br/>
						当使用内置JSON回调时，这些配置文件才会生效<br/>
						<span class="red-bg">其他高级参数见图层的配置文件说明</span>
					</td>
				</tr>
				<tr>
					<td valign="top">data</td>
					<td valign="top">Object</td>
					<td valign="top">
{<br/>
&emsp;name:"polarloves",<br/>
&emsp;age:20<br/>
}
					</td>
					<td valign="top">
						加载数据时,携带的参数.
					</td>
				</tr>
				</tbody>
			</table>
		</div>
	</fieldset>
	<blockquote class="layui-elem-quote">内置JSON格式的回调</blockquote>

	<fieldset class="layui-elem-field">
		<legend>成功回调</legend>
		<div class="layui-field-box">
			<pre class="layui-code" lay-skin="notepad" lay-encode="true">
			polar.loader.load(polar.loader.jsonSuccess, loadError, url, loading, options, data);
			</pre>
			在上述代码中,加载成功的回调使用了内置json回调方法,在内部,其做了如下几件事：<br/>
			&emsp;1. 关闭加载框.<br/>
			&emsp;2. 判断响应头文件是否为json格式，如果不是json格式，其表示请求出现异常，提示异常。<br/>
			&emsp;3. 依据标准协议判断其是否请求成功，协议格式为:{code:"",msg:"",data:"",count:10}<br/>
			&emsp;4. 回调配置文件中onRequestOk方法<br/>
			&emsp;5. 关闭指定图层<br/>
		</div>
	</fieldset>
	<fieldset class="layui-elem-field">
		<legend>失败回调</legend>

		<div class="layui-field-box">
				<pre class="layui-code" lay-skin="notepad" lay-encode="true">
		polar.loader.load(polar.loader.jsonSuccess, jsonError, url, loading, options, data);
		</pre>
			失败回调目前只执行一个逻辑：<br/>
			&emsp;提示：网络异常，请检查您的网络连接方式
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