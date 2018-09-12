<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
	<fieldset class="layui-elem-field">
		<legend>简介</legend>
		<div class="layui-field-box">
			<ul class="site-dir layui-layer-wrap" style="display: block;">
				<li style="list-style-type: circle;list-style-position: inside;margin: 6px;">对常用的对话框进行封装，包含常用的吐司、提示、加载框等</li>
			</ul>
		</div>
	</fieldset>
	<fieldset class="layui-elem-field">
		<legend>对话框</legend>
		<div class="layui-field-box">
			<ul class="site-dir layui-layer-wrap" style="display: block;">
				<li style="list-style-type: circle;list-style-position: inside;margin: 6px;">对话框使用时，以polar.dialog.方法名称进行调用</li>
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
					<td valign="top">toast</td>
					<td valign="top">
						polar.dialog.toast("测试吐司");//以吐司形式提示一句话
						<button class="layui-btn  layui-btn-blue layui-btn-xs polar-run">
							<i class="fa fa-eye"></i>  <span class="polar-btn-content">运行</span>
						</button>
					</td>

					<td valign="top">
						以吐司形式提示一句话，其会在3秒后消失
					</td>
				</tr>
				<tr>
					<td valign="top">confirm</td>
					<td valign="top">
						polar.dialog.confirm("提示","你确定要点这个按钮吗？",function(){<br/>
						&emsp;&emsp;alert("点击了确定按钮");<br/>
						});
						<button class="layui-btn  layui-btn-blue layui-btn-xs polar-run">
							<i class="fa fa-eye"></i>  <span class="polar-btn-content">运行</span>
						</button>
					</td>
					<td valign="top">
					带有确定和取消两个按钮的对话框，点击了确定会回调其方法，无论点击确定还是取消按钮，其总会关闭对话框
					</td>
				</tr>
				<tr>
					<td valign="top">prompt</td>
					<td valign="top">
						polar.dialog.prompt("请输入你的姓名",function(value){<br/>
						&emsp;&emsp;alert("输入的姓名："+value);<br/>
						});
						<button class="layui-btn  layui-btn-blue layui-btn-xs polar-run">
							<i class="fa fa-eye"></i>  <span class="polar-btn-content">运行</span>
						</button>
					</td>
					<td valign="top">
						带有输入框的提示框，无论点击确定还是取消按钮，其总会关闭对话框
					</td>
				</tr>

				<tr>
					<td valign="top">alert</td>
					<td valign="top">
						polar.dialog.alert("提示title","提示内容");<br/>
						<button class="layui-btn  layui-btn-blue layui-btn-xs polar-run">
							<i class="fa fa-eye"></i>  <span class="polar-btn-content">运行</span>
						</button>
					</td>
					<td valign="top">提示框，只有一个确定按钮，没有回调
					</td>
				</tr>
				<tr>
					<td valign="top">loading</td>
					<td valign="top">
						polar.dialog.loading();<br/>
						setTimeout("polar.dialog.closeLoading();",5000);<button class="layui-btn  layui-btn-blue layui-btn-xs polar-run">
						<i class="fa fa-eye"></i>  <span class="polar-btn-content">运行</span>
					</button>
					</td>
					<td valign="top">打开加载中的图层
					</td>
				</tr>
				<tr>
					<td valign="top">closeLoading</td>
					<td valign="top">
						polar.dialog.closeLoading();<br/>
					</td>
					<td valign="top">关闭加载中的图层
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