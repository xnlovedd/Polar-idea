<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class='form-div' id="tableImportDiv"
	style="background-color: white; height: 100%; width: calc(100% - 10px);">
	<form method="post" class="layui-form required-validate"
		id="importForm">
		<table style="width: 100%;" class="layui-table" lay-skin="nob">
			<tr>
				<td class="width-30"><label class="pull-right">表：</label></td>
				<td class="width-70"><div class="form-group noMarginBottom">
						<select lay-filter="tableNames">
							<c:forEach var="list" items="${tableList}">
								<option value="${list.comments},${list.name}">${list.name}</option>
							</c:forEach>
						</select>
					</div></td>
			</tr>
			<tr>
				<td class="width-30"><label class="pull-right">表名：</label></td>
				<td class="width-70"><div class="form-group noMarginBottom">
						<input type="text" name="tableName" id="tableName"
							autocomplete="off" class="layui-input "
							value='${tableList[0].name}' />
					</div></td>
			</tr>
			<tr>
				<td class="width-30"><label class="pull-right">表中文名：</label></td>
				<td class="width-70"><div class="form-group noMarginBottom">
						<input type="text" name="commont" id="commont" autocomplete="off"
							class="layui-input " value='${tableList[0].comments}' />
					</div></td>
			</tr>
			<tr>
				<td class="width-30"><label class="pull-right">模块名称：</label></td>
				<td class="width-70"><div class="form-group noMarginBottom">
						<input type="text" name="moduleName" autocomplete="off"
							id="moduleName" class="layui-input " value='${tableList[0].name}' />
					</div></td>
			</tr>
		</table>

	</form>
</div>
<script>
	$(function() {
		var obj = {
			init : function() {
				var form = layui.form; //只有执行了这一步，部分表单元素才会修饰成功
				form.render(); //更新全部
				form.on('select(tableNames)', function(data) {
					var strs = new Array(); //定义一数组 
					strs = data.value.split(","); //字符分割 
					$("#tableName").val(strs[1]);
					$("#commont").val(strs[0]);
					$("#moduleName").val(strs[1]);
				});
				$('#importForm').bootstrapValidator({
					message : '数据格式不合法',
					excluded : [ ':disabled' ],
					feedbackIcons : {
						valid : 'glyphicon glyphicon-ok',
						invalid : 'glyphicon glyphicon-remove',
						validating : 'glyphicon glyphicon-refresh'
					},
					fields : {
						commont : {
							validators : {
								notEmpty : {
									message : '表中文名不能为空'
								}
							}
						},
						tableName : {
							validators : {
								notEmpty : {
									message : '表名不能为空'
								}
							}
						},
						moduleName : {
							validators : {
								notEmpty : {
									message : '模块名不能为空'
								}
							}
						}
					}
				});
				polar.form.target=this;
			},
			submit : function(index) {
				var bootstrapValidator = $("#importForm").data(
						'bootstrapValidator');
				bootstrapValidator.validate();
				if (!bootstrapValidator.isValid()) {
				} else {
					//提交表单
					var data = $("#importForm").serialize();
					polar.loader.load( polar.loader.jsonSuccess, polar.loader.jsonError, '/code/json/importTable', true, {closeIndex:index,refresh:true}, data);
				}
			}
		};
		obj.init();
	});
</script>
