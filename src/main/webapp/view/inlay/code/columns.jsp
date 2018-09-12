<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>

<div class='form-div' id="columnFormDiv"
	style="background-color: white; height: 100%;  width: calc(100% - 10px); overflow: auto;">
	<button class="layui-btn    layui-btn-primary layui-btn-sm polar-add-row">
		<i class="fa fa-plus"></i>&nbsp;添加
	</button>
	<button class="layui-btn layui-btn-primary layui-btn-sm polar-delete">
		<i class="fa fa-minus"></i>&nbsp;删除
	</button>
	<button class="layui-btn layui-btn-primary layui-btn-sm polar-upRow">
		<i class="fa fa-arrow-up"></i>&nbsp;上移
	</button>
	<button class="layui-btn layui-btn-primary layui-btn-sm polar-downRow">
		<i class="fa fa-arrow-down"></i>&nbsp;下移
	</button>
	<button class="layui-btn layui-btn-primary layui-btn-sm polar-first">
		<i class="fa fa-long-arrow-up"></i>&nbsp;置顶
	</button>
	<button class="layui-btn layui-btn-primary layui-btn-sm polar-last">
		<i class="fa fa-long-arrow-down"></i>&nbsp;置尾
	</button>
	<form method="post" class="layui-form required-validate" id="columns"
		lay-filter='columns' style="margin-top: 10px;">
		<input type="hidden" value="${id}" id="tableId">
		<table class="layui-table" style="width: 1900px; margin: 0px">
			<colgroup>
				<col width="50"/>
				<col width="200"/>
				<col width="200"/>
				<col width="200"/>
				<col width="200"/>
				<col width="200"/>
				<col width="100"/>
				<col width="200"/>
				<col width="250"/>
				<col width="300"/>
			</colgroup>
			<thead>
				<tr>
					<th><form:ck name="select" filter="select" id="select" /></th>
					<th>字段名称</th>
					<th>java列名称</th>
					<th>中文名</th>
					<th>注释</th>
					<th>字段类型</th>
					<th>匹配方式</th>
					<th>扩展参数</th>
					<th>显示</th>
					<th>校验</th>
				</tr>
			</thead>
			<tbody id="columns_tb_inner_disable" style="display: none;">
				<tr>
					<td><form:ck name="select" /></td>
					<td><form:input name="name" placeholder="请输入字段名称" tag="字段名称"
							vertify="required" value="${column.name}" /></td>
					<td><form:input name="javaName" placeholder="请输入Java字段名称"
							tag="Java字段名称" vertify="required" />
					<td><form:input name="remark" placeholder="请输入中文名" tag="中文名"
							vertify="required" /></td>
					<td><form:input name="commont" placeholder="请输入注释" tag="注释"
							vertify="required" /></td>
					<td><select name="type">
							<option value="0">单行文本</option>
							<option value="1">文本域</option>
							<option value="2">整数</option>
							<option value="3">浮点数</option>
							<option value="4">日期</option>
							<option value="5">富文本编辑器</option>
							<option value="6">下拉列表</option>
							<option value="7">多选树形结构</option>
							<option value="15">单选树形结构</option>
							<option value="8">隐藏</option>
							<option value="9">大整数</option>
							<option value="11">省市区选择</option>
							<option value="13">单图片</option>
							<option value="14">单文件</option>
							<option value="10">多图片</option>
							<option value="12">多文件</option>
					</select></td>
					<td>
						<select name="matchStyle">
							<option value="0">=</option>
							<option value="1">like</option>
							<option value="2">&lt;</option>
							<option value="3">&gt;</option>
							<option value="4">&lt;=</option>
							<option value="5">&gt;=</option>
						</select></td>
					<td><form:input name="groupName" placeholder="请输入扩展参数" /></td>

					<td>
					<form:ck name="search" title="页面查询" /> 
					<form:ck name="listShown" title="列表显示" /> 
					<form:ck name="listReturn" title="列表返回" /> 
					<form:ck name="innerEdit" title="行内编辑" />
					</td>
					<td><form:ck name="required" title="必填" /> <form:ck
							name="orderBy" title="排序" /> <form:ck name="phone" title="手机号" />
						<form:ck name="email" title="邮箱" /> <form:ck name="identity"
							title="身份证号" /></td>
				</tr>

			</tbody>
		</table>
		<div
			style="width: 1900px; height: 390px; overFlow-y: scroll; overFlow-x: hidden;">
			<table id="columns_tb" class="layui-table"
				style="width: 1900px; margin: 0px;">
				<colgroup>
					<col width="50"/>
					<col width="200"/>
					<col width="200"/>
					<col width="200"/>
					<col width="200"/>
					<col width="200"/>
					<col width="100"/>
					<col width="200"/>
					<col width="250"/>
					<col width="300"/>
				</colgroup>
				<tbody id="columns_tb_inner">
					<c:forEach var="column" items="${columns}">
						<tr>
							<td ><form:ck name="select" /></td>
							<td><form:input name="name" placeholder="请输入字段名称" tag="字段名称"
									vertify="required" value="${column.name}" /></td>
							<td><form:input name="javaName" placeholder="请输入Java字段名称"
									tag="Java字段名称" vertify="required" value="${column.javaName}" />
							</td>
							<td><form:input name="remark" placeholder="请输入中文名" tag="中文名"
									vertify="required" value="${column.remark}" /></td>
							<td><form:input name="commont" placeholder="请输入注释" tag="注释"
									vertify="required" value="${column.commont}" /></td>
							<td><select name="type">
									<option value="0"
										<c:if test="${column.type==0}">selected='selected'</c:if>>单行文本</option>
									<option value="1"
										<c:if test="${column.type==1}">selected='selected'</c:if>>文本域</option>
									<option value="2"
										<c:if test="${column.type==2}">selected='selected'</c:if>>整数</option>
									<option value="3"
										<c:if test="${column.type==3}">selected='selected'</c:if>>浮点数</option>
									<option value="4"
										<c:if test="${column.type==4}">selected='selected'</c:if>>日期</option>
									<option value="5"
										<c:if test="${column.type==5}">selected='selected'</c:if>>富文本编辑器</option>
									<option value="6"
										<c:if test="${column.type==6}">selected='selected'</c:if>>下拉列表</option>
									<option value="7"
										<c:if test="${column.type==7}">selected='selected'</c:if>>多选树形结构</option>
									<option value="15"
										<c:if test="${column.type==15}">selected='selected'</c:if>>单选树形结构</option>
									<option value="8"
										<c:if test="${column.type==8}">selected='selected'</c:if>>隐藏</option>
									<option value="9"
										<c:if test="${column.type==9}">selected='selected'</c:if>>大整数</option>
									<option value="11"
										<c:if test="${column.type==11}">selected='selected'</c:if>>省市区选择</option>
								<option value="13"
										<c:if test="${column.type==13}">selected='selected'</c:if>>单图片</option>
								<option value="14"
										<c:if test="${column.type==12}">selected='selected'</c:if>>单文件</option>
								<option value="10"
										<c:if test="${column.type==10}">selected='selected'</c:if>>多图片</option>
								<option value="12"
										<c:if test="${column.type==12}">selected='selected'</c:if>>多文件</option>
							</select></td>
							<td>
							<select name="matchStyle">
								<option value="0" <c:if test="${column.matchStyle==0}">selected='selected'</c:if>>=</option>
								<option value="1" <c:if test="${column.matchStyle==1}">selected='selected'</c:if>>like</option>
								<option value="2" <c:if test="${column.matchStyle==2}">selected='selected'</c:if>>&lt;</option>
								<option value="3" <c:if test="${column.matchStyle==3}">selected='selected'</c:if>>&gt;</option>
								<option value="4" <c:if test="${column.matchStyle==4}">selected='selected'</c:if>>&lt;=</option>
								<option value="5" <c:if test="${column.matchStyle==5}">selected='selected'</c:if>>&gt;=</option>
							</select></td>
							<td><form:input name="groupName" placeholder="请输入扩展参数"
									value="${column.groupName}" /></td>

							<td>
								<form:ck name="search" value="${column.search}" title="页面查询" /> 
								<form:ck name="listShown" value="${column.listShown}" title="列表显示" />
								<form:ck name="listReturn" value="${column.listReturn}" title="列表返回" /> 
								<form:ck name="innerEdit" value="${column.innerEdit}" title="行内编辑" />
							</td>
							<td><form:ck name="required" value="${column.required}"
									title="必填" /> <form:ck name="orderBy"
									value="${column.orderBy}" title="排序" /> <form:ck name="phone"
									value="${column.phone}" title="手机号" /> <form:ck name="email"
									value="${column.email}" title="邮箱" /> <form:ck name="identity"
									value="${column.identity}" title="身份证号" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

		</div>
	</form>
</div>
<script>
	$(function(){
		var obj={
				id:"columnFormDiv"
				,addRow:function () {
					$("#columns_tb_inner").append($("#columns_tb_inner_disable").html());
					layui.form.render(null,'columns'); 
				}
				,removeRow:function() {
					$("#columns_tb_inner").find('input[name=select]').each(
							function(index, item) {
								if (item.checked) {
									$(this).parent().parent().remove();
								}
							});
					layui.form.render(null,'columns'); 
				}	
				,upRow:function(){
					var selectRow;
					var count = 0;
					var mIndex;
					$("#columns_tb_inner").find('input[name=select]').each(
							function(index, item) {
								if (item.checked) {
									//找到tr
									selectRow = $(this).parent().parent();
									count++;
									mIndex = index;
								}
								if (count > 1) {
									return false;
								}
							});
					if (count != 1) {
						polar.dialog.alert("提示", "请选择一项");
						return;
					}
					if (mIndex == 0) {
						polar.dialog.alert("提示", "当前已经是第一条了，无法上移");
						return;
					}
					selectRow.prev().before(selectRow.prop("outerHTML"));
					selectRow.remove();
					layui.form.render(null,'columns'); 
				}
				,first:function(){
					var selectRow;
					var count = 0;
					var mIndex;
					$("#columns_tb_inner").find('input[name=select]').each(
							function(index, item) {
								if (item.checked) {
									//找到tr
									selectRow = $(this).parent().parent();
									count++;
									mIndex = index;
								}
								if (count > 1) {
									return false;
								}
							});
					if (count != 1) {
						polar.dialog.alert("提示", "请选择一项");
						return;
					}
					if (mIndex == 0) {
						polar.dialog.alert("提示", "当前已经是第一条了，无法上移");
						return;
					}
					$("#columns_tb_inner").prepend(selectRow.prop("outerHTML"));
					selectRow.remove();
					layui.form.render(null,'columns'); 
				}
				,last:function(){
					var selectRow;
					var count = 0;
					var mIndex;
					$("#columns_tb_inner").find('input[name=select]').each(
							function(index, item) {
								if (item.checked) {
									//找到tr
									selectRow = $(this).parent().parent();
									count++;
									mIndex = index;
								}
								if (count > 1) {
									return false;
								}
							});
					if (count != 1) {
						polar.dialog.alert("提示", "请选择一项");
						return;
					}
					if (mIndex == $('#columns_tb_inner').children('tr').length-1) {
						polar.dialog.alert("提示", "当前已经是最后一条了，无法下移");
						return;
					}
					$("#columns_tb_inner").append(selectRow.prop("outerHTML"));
					selectRow.remove();
					layui.form.render(null,'columns'); 
				}
				,downRow:function() {
					var selectRow;
					var count = 0;
					var mIndex;
					$("#columns_tb_inner").find('input[name=select]').each(
							function(index, item) {
								if (item.checked) {
									//找到tr
									selectRow = $(this).parent().parent();
									count++;
									mIndex = index;
								}
								if (count > 1) {
									return false;
								}
							});
					if (count != 1) {
						polar.dialog.alert("提示", "请选择一项");
						return;
					}
					if (mIndex == $('#columns_tb_inner').children('tr').length-1) {
						polar.dialog.alert("提示", "当前已经是最后一条了，无法下移");
						return;
					}
					selectRow.next().after(selectRow.prop("outerHTML"));
					selectRow.remove();
					layui.form.render(null,'columns'); 
				}
				,submit:function(index) {
					if ($("#columns_tb_inner tr").length == 0) {
						polar.dialog.toast("列不能为空");
						return;
					}
					var args = {};
					var index2 = 0;
					var flag = polar.form.Verification('#columns_tb_inner');
					if (flag) {
						$("#columns_tb_inner tr")
								.each(
										function(index2, item2) {
											args["list[" + index2 + "].type"] = $(item2)
													.find('select[name="type"]').val();

                                            args["list[" + index2 + "].matchStyle"] = $(item2)
                                                .find('select[name="matchStyle"]').val();
											$(item2).find('input').each(
															function(index, item) {
																var name = $(this).attr(
																		"name");
																if (name != null
																		&& name != undefined
																		&& name != 'select') {
																	var value;
																	if ($(this)
																			.attr("type") == 'checkbox') {
																		if (item.checked) {
																			value = 1;
																		} else {
																			value = 0;
																		}
																	} else {
																		value = $(this)
																				.val();
																	}
																	args["list[" + index2+ "]." + name] = value;
																}
															});
											index2++;
										});
						args["tableId"] = $("#tableId").val();
						polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, '/code/json/updateColumns', true, {closeIndex:index}, args);
					}
				}
				,init:function(){
					var that=this;
					layui.form.render(null,'columns'); 
					layui.form.on('checkbox(select)', function(data) {
						var checked = data.elem.checked;
						$("#columns").find('input[name=select]').each(function(index, item) {
							item.checked = checked;
						});
						layui.form.render(null,'columns'); 
					});
					$("#"+that.id+" .polar-add-row").click(function(){
						that.addRow();
					});
					$("#"+that.id+" .polar-delete").click(function(){
						that.removeRow();
					});
					$("#"+that.id+" .polar-upRow").click(function(){
						that.upRow();
					});
					$("#"+that.id+" .polar-downRow").click(function(){
						that.downRow();
					});
					$("#"+that.id+" .polar-first").click(function(){
						that.first();
					});
					$("#"+that.id+" .polar-last").click(function(){
						that.last();
					});
					polar.form.target=this;
				}
		};
		obj.init();
	});

</script>
