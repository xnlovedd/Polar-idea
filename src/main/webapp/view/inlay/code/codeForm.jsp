<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class='form-div' id="tableFormDiv"
	style="background-color: white; height: 100%; width: calc(100% - 10px);">
	<form method="post" class="layui-form required-validate " id="tableForm" lay-filter="tableForm">
		<input type="hidden" name="id" value='${code.id}' /> <input
			type="hidden" name="tableName" value='${code.tableName}' />
		<div class="layui-tab layui-tab-brief " lay-filter="tab_code">
			<ul class="layui-tab-title">
				<li class="layui-this" lay-id="tab_0">基本配置</li>
				<li lay-id="tab_1">控制器配置</li>
				<li lay-id="tab_2">服务配置</li>
				<li lay-id="tab_3">持久化配置</li>
				<li lay-id="tab_4">页面配置</li>
			</ul>
			<div class="layui-tab-content" style="height: 435px; overflow: auto">
				<div class="layui-tab-item layui-show">
					<table style="width: 100%;" class="layui-table">
						<tr>
							<td class="width-15 active form-group"><label
								class="pull-right">表名：</label></td>
							<td class="width-35"><input type="text" autocomplete="off"
								class="layui-input " disabled value='${code.tableName}'></td>
							<td class="width-15 active"><label class="pull-right">中文名：</label></td>
							<td class="width-35" valign="top">
								<div class="form-group noMarginBottom">
									<form:input name="tableRemark" placeholder="请输入表中文名"
										value="${code.tableRemark}" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="width-15 active form-group"><label
								class="pull-right">模板类型：</label></td>
							<td class="width-35" ><div class="layui-form" lay-filter="moduleType">
								<select name='moduleType' >
									<option value="0"
										<c:if test='${code.moduleType== 0}'>selected='selected'</c:if>>全使用Map</option>
									<option value="1"
										<c:if test='${code.moduleType== 1}'>selected='selected'</c:if>>全使用实体类</option>
									<option value="2"
										<c:if test='${code.moduleType== 2}'>selected='selected'</c:if>>列表实体，详情/单个Map</option>
									<option value="3"
										<c:if test='${code.moduleType== 3}'>selected='selected'</c:if>>列表Map，详情/单个实体</option>
								</select></div></td>

							<td class="width-15 active form-group"><label
									class="pull-right">表单类型：</label></td>
							<td class="width-35"><select name='tableType' lay-filter="tableType">
								<option value="0"
										<c:if test='${code.tableType== 0}'>selected='selected'</c:if>>单表</option>
								<option value="1"
										<c:if test='${code.tableType== 1}'>selected='selected'</c:if>>树结构表单</option>
								<option value="2"
										<c:if test='${code.tableType== 2}'>selected='selected'</c:if>>父表</option>
								<option value="3"
										<c:if test='${code.tableType== 3}'>selected='selected'</c:if>>子表</option>
							</select></td>
						</tr>

						<tr class="childField">
							<td class="width-15 active form-group"><label
									class="pull-right"><i class="fa fa-child" style="color: brown"></i>父表：</label></td>
							<td class="width-35" valign="top">
								<div class="form-group noMarginBottom">

									<select name="parentTableId">
										<c:forEach items="${allMainTables}" var='dict'>
											<option value="${dict.id}"  <c:if test="${dict.id==code.parentTableId}">selected='selected'</c:if> >${dict.tableName}</option>
										</c:forEach>
									</select>
								</div>
							<td class="width-15 active"><label class="pull-right"><i class="fa fa-child" style="color: brown"></i>父表外键字段：</label></td>
							<td class="width-35" valign="top">
								<div class="form-group noMarginBottom">
									<form:input name="childTableField" placeholder="请输入子表中父表外键字段"
												value="${code.childTableField}" />
									<span style="color:brown">在列配置中，请将此字段属性设为隐藏</span>
								</div>
							</td>
						</tr>

						<tr class="treeField">
							<td class="width-15 active form-group"><label
									class="pull-right"><i class="fa fa-tree" style="color: green"></i>父编号字段：</label></td>
							<td class="width-35" valign="top">
							<div class="form-group noMarginBottom">
								<form:input name="parentField" placeholder="请输入父编号字段"
											value="${code.parentField}" />
							</div>
							<td class="width-15 active"><label class="pull-right"><i class="fa fa-tree" style="color: green"></i>子编号字段：</label></td>
							<td class="width-35" valign="top">
								<div class="form-group noMarginBottom">
									<form:input name="childField" placeholder="请输入子编号字段"
												value="${code.childField}" />
								</div>
							</td>
						</tr>

						<tr class="treeField">
							<td class="width-15 active form-group"><label
									class="pull-right"><i class="fa fa-tree" style="color: green"></i>名称字段：</label></td>
							<td class="width-35" valign="top">
								<div class="form-group noMarginBottom">
									<form:input name="nameField" placeholder="请输入名称字段"
												value="${code.nameField}" />
								</div>
							<td class="width-15 active"><label class="pull-right"><i class="fa fa-tree" style="color: green"></i>值字段：</label></td>
							<td class="width-35" valign="top">
								<div class="form-group noMarginBottom">
									<form:input name="valueField" placeholder="请输入值字段"
												value="${code.valueField}" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="width-15 active"><label class="pull-right">删除模式：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<select name='deleteMode' id='deleteMode'
										lay-filter="deleteMode">
										<option value="0"
											<c:if test='${code.deleteMode== 0 or code.deleteMode== null}'>selected='selected'</c:if>>全部</option>
										<option value="1"
											<c:if test='${code.deleteMode== 1}'>selected='selected'</c:if>>仅物理删除</option>
										<option value="2"
											<c:if test='${code.deleteMode== 2}'>selected='selected'</c:if>>仅逻辑删除</option>
									</select>
								</div></td>
							<td class="width-15 active"><label class="pull-right">主键类型：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<select name='idType'>
										<option value="0"
											<c:if test='${code.idType== 0}'>selected='selected'</c:if>>long</option>
										<option value="1"
											<c:if test='${code.idType==1}'>selected='selected'</c:if>>UUID</option>
									</select>
								</div></td>

						</tr>
						<tr class='mode'>
							<td class="width-15 active"><label class="pull-right">有效性名称：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="effectivenessField" placeholder="请输入有效性字段名称"
										value="${code.effectivenessField}" />
								</div></td>
							<td class="width-15 active"><label class="pull-right">有效性类型：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<select name='effectivenessType'>
										<option value="0"
											<c:if test='${code.effectivenessType== 0}'>selected='selected'</c:if>>字符串</option>
										<option value="1"
											<c:if test='${code.effectivenessType==1}'>selected='selected'</c:if>>数值</option>
									</select>
								</div></td>
						</tr>
						<tr class='mode'>
							<td class="width-15 active"><label class="pull-right">有效值：</label></td>
							<td class="width-35">
								<div class="form-group noMarginBottom">
									<form:input name="effectivenessValue" placeholder="请输入有效值"
										value="${code.effectivenessValue}" />
								</div>
							</td>
							<td class="width-15 active"><label class="pull-right">无效值：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="unEffectivenessValue" placeholder="请输入无效值"
										value="${code.unEffectivenessValue}" />
								</div></td>
						</tr>
						<tr>
							<td class="width-15 active"><label class="pull-right">主键名称：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="idField" placeholder="请输入主键名称"
										value="${code.idField}" />
								</div></td>
							<td class="width-15 active"><label class="pull-right">包名：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="packageName" placeholder="请输入包名"
										value="${code.packageName}" />
								</div></td>
						</tr>
						<tr>
							<td class="width-15 active"><label class="pull-right">模块名称：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="moduleName" placeholder="请输入模块英文名称"
										value="${code.moduleName}" />
								</div></td>
							<td class="width-15 active"><label class="pull-right">作者：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="author" placeholder="请输入作者"
										value="${code.author}" />
								</div></td>
						</tr>

						<tr>
							<td class="width-15 active" valign="top"><label
								class="pull-right">模块注释：</label></td>
							<td class="width-35" colspan="3"><div
									class="form-group noMarginBottom">
									<textarea name="moduleRemark" placeholder="请输入模块注释"
										class="layui-textarea">${code.moduleRemark}</textarea>
								</div></td>
						</tr>
					</table>
				</div>
				<div class="layui-tab-item">
					<table style="width: 100%;" class="layui-table">
						<tr>
							<td class="width-15 active form-group title" colspan="4"><label
								class="pull-left">Web端配置</label></td>
						</tr>
						<tr>
							<td class="width-15 active form-group"><label
								class="pull-right">访问路径：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="controllerWebPath" placeholder="请输入Web端访问路径"
										value="${code.controllerWebPath}" />
								</div></td>
							<td class="width-15 active"><label class="pull-right">类名：</label></td>
							<td class="width-35" valign="top">
								<div class="form-group noMarginBottom">
									<form:input name="controllerWebName" placeholder="请输入Web端控制器类名"
										value="${code.controllerWebName}" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="width-15 active"><label class="pull-right">标签：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="controllerWebTag" placeholder="请输入Web端控制器标签"
										value="${code.controllerWebTag}" />
								</div></td>
						</tr>
						<tr>
							<td class="width-15 active form-group title" colspan="4"><label
								class="pull-left">Json端配置</label></td>
						</tr>
						<tr>
							<td class="width-15 active form-group"><label
								class="pull-right">访问路径：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="controllerJsonPath"
										placeholder="请输入Json端访问路径" value="${code.controllerJsonPath}" />
								</div></td>
							<td class="width-15 active"><label class="pull-right">类名：</label></td>
							<td class="width-35" valign="top">
								<div class="form-group noMarginBottom">
									<form:input name="controllerJsonName"
										placeholder="请输入Json端控制器类名" value="${code.controllerJsonName}" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="width-15 active"><label class="pull-right">标签：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="controllerJsonTag"
										placeholder="请输入Json端控制器标签" value="${code.controllerJsonTag}" />
								</div></td>
						</tr>
					</table>
				</div>
				<div class="layui-tab-item">
					<table style="width: 100%;" class="layui-table">
						<tr>
							<td class="width-15 active form-group"><label
								class="pull-right">接口类名：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="serviceName" placeholder="请输入接口类名"
										value="${code.serviceName}" />
								</div></td>
							<td class="width-15 active"><label class="pull-right">标签：</label></td>
							<td class="width-35" valign="top">
								<div class="form-group noMarginBottom">
									<form:input name="serviceTag" placeholder="请输入标签"
										value="${code.serviceTag}" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="width-15 active"><label class="pull-right">实现类类名：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="serviceImplName" placeholder="请输入实现类类名"
										value="${code.serviceImplName}" />
								</div></td>
						</tr>
					</table>


				</div>
				<div class="layui-tab-item">
					<table style="width: 100%;" class="layui-table">
						<tr>
							<td class="width-15 active form-group title" colspan="4"><label
								class="pull-left">Dao配置</label></td>
						</tr>
						<tr>
							<td class="width-15 active form-group"><label
								class="pull-right">类名：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="daoName" placeholder="请输入Dao层类名"
										value="${code.daoName}" />
								</div></td>
							<td class="width-15 active"><label class="pull-right">标签：</label></td>
							<td class="width-35" valign="top">
								<div class="form-group noMarginBottom">
									<form:input name="daoTag" placeholder="请输入标签"
										value="${code.daoTag}" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="width-15 active form-group"><label
								class="pull-right">实体类名：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="entityName" placeholder="请输入实体类类名"
										value="${code.entityName}" />
								</div></td>
							<td class="width-15 active form-group"><label
								class="pull-right">实体类别名：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="entityAlias" placeholder="请输入实体类别名"
										value="${code.entityAlias}" />
								</div></td>
						</tr>
						<tr>
							<td class="width-15 active form-group title" colspan="4"><label
								class="pull-left">Mapper配置</label></td>
						</tr>
						<tr>
							<td class="width-15 active form-group"><label
								class="pull-right">文件夹名称：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="mapperFloderName"
										placeholder="请输入Mapper文件的文件夹名称"
										value="${code.mapperFloderName}" />
								</div></td>
							<td class="width-15 active"><label class="pull-right">文件名称：</label></td>
							<td class="width-35" valign="top">
								<div class="form-group noMarginBottom">
									<form:input name="mapperFileName" placeholder="请输入Mapper文件名称"
										value="${code.mapperFileName}" />
								</div>
							</td>
						</tr>
					</table>
				</div>
				<div class="layui-tab-item">
					<table style="width: 100%;" class="layui-table">

						<tr>
							<td class="width-15 active"><label class="pull-right">校验方式：</label></td>
							<td class="width-35" valign="top">
								<div class="form-group noMarginBottom">
									<select name='validateType'>
										<option value="0"
											<c:if test='${code.validateType== 0}'>selected='selected'</c:if>>layui</option>
										<option value="1"
											<c:if test='${code.validateType== 1}'>selected='selected'</c:if>>bootstrapValidate</option>
									</select>
								</div>
							</td>
							<td class="width-15 active"><label class="pull-right">列表模板：</label></td>
							<td class="width-35" valign="top">
								<div class="form-group noMarginBottom">
									<select name='listModule'>
										<option value="0"
											<c:if test='${code.listModule== 0}'>selected='selected'</c:if>>layui-table</option>
										<option value="1"
											<c:if test='${code.listModule== 1}'>selected='selected'</c:if>>bootstrap-table</option>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<td class="width-15 active form-group"><label
								class="pull-right">列表页面名称：</label></td>
							<td class="width-35"><div class="form-group noMarginBottom">
									<form:input name="jspListName" placeholder="请输入列表页面名称"
										value="${code.jspListName}" />
								</div></td>
							<td class="width-15 active"><label class="pull-right">编辑页面名称：</label></td>
							<td class="width-35" valign="top">
								<div class="form-group noMarginBottom">
									<form:input name="jspEditName" placeholder="请输入编辑页面名称"
										value="${code.jspEditName}" />
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</form>
</div>
<script>
	$(function() {
		var obj = {
			init : function() {
				var form = layui.form; //只有执行了这一步，部分表单元素才会修饰成功
				form.render(); //更新全部
				form.on('select(deleteMode)', function(data) {
					var value = data.value;
					if (value != '1') {
						//显示有效性字段选项卡。
						$('.mode').each(function(index) {
							$(this).show();
							$(this).find('input').removeAttr("disabled");
						});
					} else {
						$('.mode').each(function(index) {
							$(this).hide();
							$(this).find('input').attr({
								"disabled" : "disabled"
							});
						});
					}
				});
                form.on('select(tableType)', function(data) {
                    var value = data.value;
                    if (value == '1') {
                        //显示树形表单相关的属性
                        $('.treeField').each(function(index) {
                            $(this).show();
                            $(this).find('input').removeAttr("disabled");
                        });
                        $('.childField').each(function(index) {
                            $(this).hide();
                            $(this).find('input').attr({
                                "disabled" : "disabled"
                            });
                            $(this).find('select').attr({
                                "disabled" : "disabled"
                            });
                        });
                    }else if(value == '3'){
                        $('.childField').each(function(index) {
                            $(this).show();
                            $(this).find('input').removeAttr("disabled");
                            $(this).find('select').removeAttr("disabled");
                        });
                        $('.treeField').each(function(index) {
                            $(this).hide();
                            $(this).find('input').attr({
                                "disabled" : "disabled"
                            });
                        });
                        $("select[name='moduleType']").val("1");
                        form.render('select','moduleType');
                    }else {
                        $('.childField').each(function(index) {
                            $(this).hide();
                            $(this).find('input').attr({
                                "disabled" : "disabled"
                            });
                            $(this).find('select').attr({
                                "disabled" : "disabled"
                            });
                        });
                        $('.treeField').each(function(index) {
                            $(this).hide();
                            $(this).find('input').attr({
                                "disabled" : "disabled"
                            });

                        });
                    }
                });
                var tableType = '${code.tableType}';
                if (tableType == '1') {
                    //显示树形表单相关的属性
                    $('.treeField').each(function(index) {
                        $(this).show();
                        $(this).find('input').removeAttr("disabled");
                    });
                    $('.childField').each(function(index) {
                        $(this).hide();
                        $(this).find('input').attr({
                            "disabled" : "disabled"
                        });
                        $(this).find('select').attr({
                            "disabled" : "disabled"
                        });
                    });
                }else if(tableType == '3'){
                    $('.childField').each(function(index) {
                        $(this).show();
                        $(this).find('input').removeAttr("disabled");
                        $(this).find('select').removeAttr("disabled");
                    });
                    $('.treeField').each(function(index) {
                        $(this).hide();
                        $(this).find('input').attr({
                            "disabled" : "disabled"
                        });
                    });

                }else {
                    $('.childField').each(function(index) {
                        $(this).hide();
                        $(this).find('input').attr({
                            "disabled" : "disabled"
                        });
                        $(this).find('select').attr({
                            "disabled" : "disabled"
                        });
                    });
                    $('.treeField').each(function(index) {
                        $(this).hide();
                        $(this).find('input').attr({
                            "disabled" : "disabled"
                        });

                    });
                }

				var value = '${code.deleteMode}';
				if (value != '1') {
					//显示有效性字段选项卡。
					$('.mode').each(function(index) {
						$(this).show();
						$(this).find('input').removeAttr("disabled");
					});
				} else {
					$('.mode').each(function(index) {
						$(this).hide();
						$(this).find('input').attr({
							"disabled" : "disabled"
						});
					});
				}
				$('#tableForm').bootstrapValidator({
					message : '数据格式不合法',
					excluded : [ ':disabled' ],
					feedbackIcons : {
						valid : 'glyphicon glyphicon-ok',
						invalid : 'glyphicon glyphicon-remove',
						validating : 'glyphicon glyphicon-refresh'
					},
					fields : {
						tableRemark : {
							validators : {
								notEmpty : {
									message : '表名不能为空'
								}
							}
						},
                        childTableField : {
                            validators : {
                                notEmpty : {
                                    message : '子表中，必须有字段保存父表编号！'
                                }
                            }
                        },
                        parentTableId : {
                            validators : {
                                notEmpty : {
                                    message : '选择子表时，父表不能为空！'
                                }
                            }
                        },
                        parentField : {
                            validators : {
                                notEmpty : {
                                    message : '父编号不能为空'
                                }
                            }
                        },
                       nameField : {
                            validators : {
                                notEmpty : {
                                    message : '名称字段不能为空'
                                }
                            }
                        },
                       valueField : {
                            validators : {
                                notEmpty : {
                                    message : '值字段不能为空'
                                }
                            }
                        },
                       childField : {
                            validators : {
                                notEmpty : {
                                    message : '子编号不能为空'
                                }
                            }
                        },
						effectivenessField : {
							validators : {
								notEmpty : {
									message : '有效性字段不能为空'
								}
							}
						},
						effectivenessValue : {
							validators : {
								notEmpty : {
									message : '有效值不能为空'
								}
							}
						},
						unEffectivenessValue : {
							validators : {
								notEmpty : {
									message : '无效值不能为空'
								}
							}
						},
						idField : {
							validators : {
								notEmpty : {
									message : '主键名称不能为空'
								}
							}
						},
						packageName : {
							validators : {
								notEmpty : {
									message : '包名不能为空'
								}
							}
						},
						moduleName : {
							validators : {
								notEmpty : {
									message : '模块名称不能为空'
								}
							}
						},
						moduleRemark : {
							validators : {
								notEmpty : {
									message : '模块注释不能为空'
								}
							}
						},
						author : {
							validators : {
								notEmpty : {
									message : '作者不能为空'
								}
							}
						},
						controllerWebPath : {
							validators : {
								notEmpty : {
									message : '访问路径不能为空'
								}
							}
						},
						controllerJsonPath : {
							validators : {
								notEmpty : {
									message : '访问路径不能为空'
								}
							}
						},
						controllerWebName : {
							validators : {
								notEmpty : {
									message : '类名不能为空'
								},
								regexp : {
									regexp : /^[a-zA-Z0-9]*$/,
									message : '类名必须有字母和数字组成'
								}
							}
						},
						controllerJsonName : {
							validators : {
								notEmpty : {
									message : '类名不能为空'
								},
								regexp : {
									regexp : /^[a-zA-Z0-9]*$/,
									message : '类名必须有字母和数字组成'
								}
							}
						},
						controllerWebTag : {
							validators : {
								notEmpty : {
									message : '标签不能为空'
								}
							}
						},
						controllerJsonTag : {
							validators : {
								notEmpty : {
									message : '标签不能为空'
								}
							}
						},
						serviceName : {
							validators : {
								notEmpty : {
									message : '接口类名不能为空'
								},
								regexp : {
									regexp : /^[a-zA-Z0-9]*$/,
									message : '类名必须有字母和数字组成'
								}
							}
						},
						serviceTag : {
							validators : {
								notEmpty : {
									message : '标签不能为空'
								}
							}
						},
						serviceImplName : {
							validators : {
								notEmpty : {
									message : '实现类类名不能为空'
								},
								regexp : {
									regexp : /^[a-zA-Z0-9]*$/,
									message : '类名必须有字母和数字组成'
								}
							}
						},
						daoName : {
							validators : {
								notEmpty : {
									message : '类名不能为空'
								},
								regexp : {
									regexp : /^[a-zA-Z0-9]*$/,
									message : '类名必须有字母和数字组成'
								}
							}
						},
						daoTag : {
							validators : {
								notEmpty : {
									message : '标签不能为空'
								}
							}
						},
						mapperFileName : {
							validators : {
								notEmpty : {
									message : 'mapper文件名称不能为空'
								}
							}
						},
						jspListName : {
							validators : {
								notEmpty : {
									message : '列表页面名称不能为空'
								}
							}
						},
						jspEditName : {
							validators : {
								notEmpty : {
									message : '编辑页面名称不能为空'
								}
							}
						},
						entityName : {
							validators : {
								notEmpty : {
									message : '实体类名不能为空'
								}
							}
						},
						entityAlias : {
							validators : {
								notEmpty : {
									message : '实体类别名不能为空'
								}
							}
						}
					}
				});
				polar.form.target = this;
			},
			submit : function(index) {
				var bootstrapValidator = $("#tableForm").data(
						'bootstrapValidator');
				bootstrapValidator.validate();
				if (!bootstrapValidator.isValid()) {
					$('#tableForm .layui-tab-item') .each( function(index) {
										var flag = false;
										$(this) .find('.help-block') .each( function(index) {
															if ($(this).css(
																	'display') != 'none') {
																flag = true;
																return;
															}
														});
										if (flag) {
											polar.dialog.toast($(
													'#tableForm .layui-tab-title li:eq('
															+ index + ")")
													.html()
													+ "填写有误，请重新填写!");
											var element = layui.element;
											element.tabChange('tab_code',
													'tab_' + index);
											return false;
										}
									});
				} else {
					//提交表单
					var data = $("#tableForm").serialize();
					polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, '/code/json/updateAllById', true, {closeIndex:index,refresh:true}, data);
				}
			}
		}
		obj.init();
	});
</script>
