<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
	<fieldset class="layui-elem-field">
		<legend>示例</legend>
		<div class="layui-field-box">
			<pre class="layui-code" lay-skin="notepad" lay-encode="true">
			var options={
			   addUrl:"/dict/json/add",//定义新增的url
			   upDateUrl:"/dict/json/updateAllById",//定义修改的url
			   id:"dicteditForm",//定义表单编号,要求lay-flter也为此
			   unionId:"id"//主键编号
			};
			var form=polar.form.Form(options);
			form.init(form);
			</pre>
			options参数说明：
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
					<td valign="top">addUrl</td>
					<td valign="top">
						String
					</td>
					<td valign="top">
						/dict/json/add
					</td>
					<td valign="top">
						新增的url
					</td>
				</tr>
				<tr>
					<td valign="top">upDateUrl</td>
					<td valign="top">
						String
					</td>
					<td valign="top">
						/dict/json/updateAllById
					</td>
					<td valign="top">
						修改的url
					</td>
				</tr>
				<tr>
					<td valign="top">id</td>
					<td valign="top">
						String
					</td>
					<td valign="top">
						dictform
					</td>
					<td valign="top">
						form表单的编号，要求lay-filter也为这个值
					</td>
				</tr>
				<tr>
					<td valign="top">unionId</td>
					<td valign="top">
						String
					</td>
					<td valign="top">
						id
					</td>
					<td valign="top">
						主键编号
					</td>
				</tr>
				</tbody>
			</table>
			方法：
			<table class="layui-table">
				<colgroup>
					<col width="150" >
					<col  width="150" >
					<col  width="300">
					<col >
				</colgroup>
				<thead>
				<tr>
					<th>方法名称</th>
					<th>参数</th>
					<th>示例</th>
					<th>说明</th>
				</tr>
				</thead>
				<tbody>

				<tr>
					<td valign="top">validate</td>
					<td valign="top">
						that
					</td>
					<td valign="top">
						form.validate(form);
					</td>
					<td valign="top">
						校验数据
					</td>
				</tr>
				<tr>
					<td valign="top">done</td>
					<td valign="top">
						that, layuiForm
					</td>
					<td valign="top">
						function(that, layuiForm){<br/>
						}
					</td>
					<td valign="top">
						加载完成的回调
					</td>
				</tr>
				<tr>
					<td valign="top">onSubmitOptions</td>
					<td valign="top">
						args, that
					</td>
					<td valign="top">
						function(args, that){<br/>
						}
					</td>
					<td valign="top">
						提交表单前的回调
					</td>
				</tr>
				<tr>
					<td valign="top">beforeValidate</td>
					<td valign="top">

					</td>
					<td valign="top">
						function(){<br/>
						}
					</td>
					<td valign="top">
						校验前的回调
					</td>
				</tr>
				<tr>
					<td valign="top">submit</td>
					<td valign="top">
						index
					</td>
					<td valign="top">
						form.submit(1);
					</td>
					<td valign="top">
						提交表单，成功后关闭index的layer
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