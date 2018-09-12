<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
	<fieldset class="layui-elem-field">
		<legend>简介</legend>
		<div class="layui-field-box">
			<ul class="site-dir layui-layer-wrap" style="display: block;">
				<li style="list-style-type: circle;list-style-position: inside;margin: 6px;">用于打开一个图层，包含远程图层、本地图层</li>
			</ul>
		</div>
	</fieldset>
	<fieldset class="layui-elem-field">
		<legend>配置文件说明</legend>
		<div class="layui-field-box">
			<ul class="site-dir layui-layer-wrap" style="display: block;">
				<li style="list-style-type: circle;list-style-position: inside;margin: 6px;">此配置文件适用于本地和远程图层</li>
			</ul>
			<pre class="layui-code" lay-skin="notepad" lay-encode="true">
var options={
   width:100px,//图层宽度
   height:100px,//图层高度
   yesBtn:true,//带有确定按钮
   yesContent:"保存",//确定按钮的文本内容
   yesCall:function(index, layero){ //确定按钮点击事件
      console.log("当前图层的index:"+index);
   },
   success:function(layero,index){ //图层打开的回调
      console.log("图层打开了，当前图层的index:"+index);
   },
   end:function(){ //图层关闭的回调
      console.log("图层关闭了，当前图层的index:"+index);
   },
   title:"测试图层",//图层标题
};
	</pre>
			<table class="layui-table">
				<colgroup>
					<col width="150" >
					<col width="100" >
					<col >
					<col >
				</colgroup>
				<thead>
				<tr>
					<th>参数名称</th>
					<th>类型</th>
					<th>示例</th>
					<th>说明</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td valign="top">width</td>
					<td valign="top">
						String
					</td>
					<td valign="top">
						200px
					</td>
					<td valign="top">
						图层的宽度，当图层宽度超过屏幕宽度时，使用屏幕宽度,当然，也可以使用百分比
					</td>
				</tr>
				<tr>
					<td valign="top">height</td>
					<td valign="top">
						String
					</td>
					<td valign="top">
						200px
					</td>
					<td valign="top">
						图层的高度，当图层高度超过屏幕高度时，使用屏幕高度,当然，也可以使用百分比
					</td>
				</tr>
				<tr>
					<td valign="top">yesBtn</td>
					<td valign="top">
						boolean
					</td>
					<td valign="top">
						true
					</td>
					<td valign="top">
						是否含有确定按钮
					</td>
				</tr>
				<tr>
					<td valign="top">yesContent</td>
					<td valign="top">
						String
					</td>
					<td valign="top">
						保存
					</td>
					<td valign="top">
						确定按钮的文本内容，仅当yesBtn为true时才生效。
					</td>
				</tr>
				<tr>
					<td valign="top">yesCall</td>
					<td valign="top">
						function
					</td>
					<td valign="top">
						function (index, layero) {<br/>
						&emsp;&emsp;polar.form.target.submit(index);//提交当前的form表单<br/>
						};
					</td>
					<td valign="top">
						确定按钮点击时的回调方法
					</td>
				</tr>
				<tr>
					<td valign="top">success</td>
					<td valign="top">
						function
					</td>
					<td valign="top">
						function (layero,index) {<br/>
						&emsp;&emsp;console.log("图层打开了，当前图层的index:"+index);<br/>
						};
					</td>
					<td valign="top">
						图层打开成功后的回调
					</td>
				</tr>
				<tr>
					<td valign="top">end</td>
					<td valign="top">
						function
					</td>
					<td valign="top">
						function (layero,index) {<br/>
						&emsp;&emsp;console.log("图层关闭了，当前图层的index:"+index);<br/>
						};
					</td>
					<td valign="top">
						图层关闭后的回调,当此参数为空时，会清空保存的form对象
					</td>
				</tr>
				<tr>
					<td valign="top">title</td>
					<td valign="top">
						String
					</td>
					<td valign="top">
						测试图层
					</td>
					<td valign="top">
						图层的标题
					</td>
				</tr>
				</tbody>
			</table>
		</div>
	</fieldset>
	<blockquote class="layui-elem-quote">方法</blockquote>
	<fieldset class="layui-elem-field">
		<legend>加载远程地址的图层</legend>
		<div class="layui-field-box">
			<pre class="layui-code" lay-skin="notepad" lay-encode="true">
				polar.layer.loadLayer(url, loading, options, data);
			</pre>
			<table class="layui-table">
				<colgroup>
					<col width="150" >
					<col width="100" >
					<col >
					<col >
				</colgroup>
				<thead>
				<tr>
					<th>参数名称</th>
					<th>类型</th>
					<th>示例</th>
					<th>说明</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td valign="top">url</td>
					<td valign="top">
						String
					</td>
					<td valign="top">
						/test
					</td>
					<td valign="top">
						远程加载地址
					</td>
				</tr>
				<tr>
					<td valign="top">loading</td>
					<td valign="top">
						boolean
					</td>
					<td valign="top">
						true
					</td>
					<td valign="top">
						加载过程中是否打开加载中对话框
					</td>
				</tr>
				<tr>
					<td valign="top">options</td>
					<td valign="top">
						Object
					</td>
					<td valign="top">

					</td>
					<td valign="top">
						配置文件
					</td>
				</tr>
				<tr>
					<td valign="top">data</td>
					<td valign="top">
						Object
					</td>
					<td valign="top">
						{<br/>
						&emsp;name:"polarloves",<br/>
						&emsp;age:20<br/>
						}
					</td>
					<td valign="top">
						加载图层时携带的数据。
					</td>
				</tr>

				</tbody>
			</table>
		</div>
	</fieldset>
	<fieldset class="layui-elem-field">
		<legend>打开图层</legend>
		<div class="layui-field-box">
			<pre class="layui-code" lay-skin="notepad" lay-encode="true">
				polar.layer.layer(data, width, height, options);
			</pre>
			<table class="layui-table">
				<colgroup>
					<col width="150" >
					<col width="100" >
					<col >
					<col >
				</colgroup>
				<thead>
				<tr>
					<th>参数名称</th>
					<th>类型</th>
					<th>示例</th>
					<th>说明</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td valign="top">data</td>
					<td valign="top">
						String
					</td>
					<td valign="top">
						&lt;div>这是一个简单的图层&lt;/div>
					</td>
					<td valign="top">
						图层数据
					</td>
				</tr>
				<tr>
					<td valign="top">width</td>
					<td valign="top">
						String
					</td>
					<td valign="top">
						1000px
					</td>
					<td valign="top">
						图层宽度
					</td>
				</tr>
				<tr>
					<td valign="top">height</td>
					<td valign="top">
						String
					</td>
					<td valign="top">
						500px
					</td>
					<td valign="top">
						图层高度
					</td>
				</tr>
				<tr>
					<td valign="top">options</td>
					<td valign="top">
						Object
					</td>
					<td valign="top">

					</td>
					<td valign="top">
						配置文件
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