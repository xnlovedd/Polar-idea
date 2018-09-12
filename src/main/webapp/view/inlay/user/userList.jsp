<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8" %>
<%@ include file="/view/includes/tag.jsp" %>
<div class="polar-content"
     cache='true' id="usertableListDiv"  >
    <input type="hidden" value='1' class="polar-page"/>
    <input type="hidden" value='10' class="polar-rows"/>
    <form class=" polar-list-form layui-form" role="form" lay-filter='usertableListFormFilter'>
        <blockquote class="layui-elem-quote polar-title">用户管理</blockquote>
        <div style="display: none" id="listBtn2">
            <div class="polar-detail-inner" polar-data="[id]" style="cursor:pointer">
                <span style="color:#019858">[userName]</span>
            </div>
        </div>
        <div style="display: none" class="polar-btn-inner-template-disable">
            <shiro:hasPermission name="polar:user:edit">
                <button class="layui-btn  layui-btn-primary layui-btn-xs polar-edit-inner" polar-data="[id]">
                    <i class="fa fa-edit"></i> <span class="polar-btn-content">修改</span>
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="polar:user:role:empty">
                <button class="layui-btn  layui-btn-primary layui-btn-xs polar-role-inner" polar-data="[id]">
                    <i class="fa fa-cogs"></i> <span class="polar-btn-content">角色分配</span>
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="polar:user:delete">
                <button class="layui-btn    layui-btn-primary layui-btn-xs polar-delete-inner" polar-data="[id]">
                    <i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="polar:user:menu">
                <button class="layui-btn    layui-btn-primary layui-btn-xs polar-menu-inner" polar-data="[id]">
                    <i class="fa fa-reorder"></i> <span class="polar-btn-content">设置菜单</span>
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="polar:online:view">
                <button class="layui-btn    layui-btn-primary layui-btn-xs polar-online-user" polar-data="[id]">
                    <i class="fa fa-reorder"></i> <span class="polar-btn-content">在线用户</span>
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="polar:user:disableUser">
                <button class="layui-btn  layui-btn-primary layui-btn-xs polar-disableUser" polar-data="[id]">
                    <i class="fa fa-edit"></i> <span class="polar-btn-content">禁用</span>
                </button>
            </shiro:hasPermission>
        </div>
        <div style="display: none" class="polar-btn-inner-template-enable">
            <shiro:hasPermission name="polar:user:edit">
                <button class="layui-btn  layui-btn-primary layui-btn-xs polar-edit-inner" polar-data="[id]">
                    <i class="fa fa-edit"></i> <span class="polar-btn-content">修改</span>
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="polar:user:role:empty">
                <button class="layui-btn  layui-btn-primary layui-btn-xs polar-role-inner" polar-data="[id]">
                    <i class="fa fa-cogs"></i> <span class="polar-btn-content">角色分配</span>
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="polar:user:delete">
                <button class="layui-btn    layui-btn-primary layui-btn-xs polar-delete-inner" polar-data="[id]">
                    <i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="polar:user:menu">
                <button class="layui-btn    layui-btn-primary layui-btn-xs polar-menu-inner" polar-data="[id]">
                    <i class="fa fa-reorder"></i> <span class="polar-btn-content">设置菜单</span>
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="polar:online:view">
                <button class="layui-btn    layui-btn-primary layui-btn-xs polar-online-user" polar-data="[id]">
                    <i class="fa fa-reorder"></i> <span class="polar-btn-content">在线用户</span>
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="polar:user:enableUser">
                <button class="layui-btn  layui-btn-primary layui-btn-xs polar-enableUser" polar-data="[id]">
                    <i class="fa fa-edit"></i> <span class="polar-btn-content">启用</span>
                </button>
            </shiro:hasPermission>
        </div>
        <div class="layui-form-item polar-scroll layui-row">
            <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
                <label class="layui-form-label">用户状态：</label>
                <div class="layui-input-block">
                    <select name='state' cache="true">
                        <option value="">全部</option>
                        <option value="0">已禁用</option>
                        <option value="1">正常</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
                <label class="layui-form-label">昵称：</label>
                <div class="layui-input-block">
                    <form:input name="nickName" placeholder="请输入昵称" cache="true"/>
                </div>
            </div>
            <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
                <label class="layui-form-label">创建日期：</label>
                <div class="layui-input-block">
                    <form:inputTime name="createDate" format="yyyy-MM-dd" cache="true" type="date" id="createDateList"/>
                </div>
            </div>
            <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
                <label class="layui-form-label">登录日期：</label>
                <div class="layui-input-block">
                    <form:inputTime name="logInDate" format="yyyy-MM-dd" cache="true" type="date" id="logInDateList"/>
                </div>
            </div>
            <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
                <label class="layui-form-label">手机号：</label>
                <div class="layui-input-block">
                    <form:input name="phone" placeholder="请输入手机号" cache="true"/>
                </div>
            </div>
            <div class="layui-inline layui-col-xs12 layui-col-sm4 layui-col-md3">
                <label class="layui-form-label">邮箱：</label>
                <div class="layui-input-block">
                    <form:input name="email" placeholder="请输入邮箱" cache="true"/>
                </div>
            </div>

        </div>
    </form>
    <div  class="layui-inline polar-toolbar">
        <shiro:hasPermission name="polar:user:add">
            <button class="layui-btn  layui-btn-sm layui-btn-primary polar-add">
                <i class="fa fa-plus"></i> <span class="polar-btn-content">新增</span>
            </button>
        </shiro:hasPermission>
        <shiro:hasPermission name="polar:user:view:detail">
            <button class="layui-btn  layui-btn-sm layui-btn-primary  polar-detail">
                <i class="fa fa-eye"></i> <span class="polar-btn-content">查看</span>
            </button>
        </shiro:hasPermission>
        <shiro:hasPermission name="polar:user:edit">
            <button class="layui-btn  layui-btn-sm layui-btn-primary polar-edit">
                <i class="fa fa-pencil"></i> <span class="polar-btn-content">编辑</span>
            </button>
        </shiro:hasPermission>
        <shiro:hasPermission name="polar:user:delete">
            <button class="layui-btn  layui-btn-sm layui-btn-primary polar-delete">
                <i class="fa fa-remove"></i> <span class="polar-btn-content">删除</span>
            </button>
        </shiro:hasPermission>
        <shiro:hasPermission name="polar:user:clear:userMenu">
            <button class="layui-btn    layui-btn-primary layui-btn-sm polar-clear-user">
                <i class="fa fa-reorder"></i> <span class="polar-btn-content">清空菜单缓存</span>
            </button>
        </shiro:hasPermission>
        <shiro:hasPermission name="polar:user:clear:userInfo">
            <button class="layui-btn    layui-btn-primary layui-btn-sm polar-clear-permission">
                <i class="fa fa-lock"></i> <span class="polar-btn-content">清空权限缓存</span>
            </button>
        </shiro:hasPermission>
        <shiro:hasPermission name="polar:user:clear:allMenu">
            <button class="layui-btn    layui-btn-primary layui-btn-sm polar-clear-user-all">
                <i class="fa fa-reorder"></i> <span class="polar-btn-content">清空所有菜单缓存</span>
            </button>
        </shiro:hasPermission>
        <shiro:hasPermission name="polar:user:clear:allInfo">
            <button class="layui-btn    layui-btn-primary layui-btn-sm polar-clear-permission-all">
                <i class="fa fa-lock"></i> <span class="polar-btn-content">清空所有权限缓存</span>
            </button>
        </shiro:hasPermission>
        <div class="pull-right">
            <button class="layui-btn  layui-btn-sm layui-btn-primary polar-refresh">
                <i class="fa fa-refresh"></i> 刷新
            </button>
            <button class="layui-btn  layui-btn-sm layui-btn-primary polar-reset">
                <i class="fa fa-circle-o-notch"></i> 重置
            </button>
            <button class="layui-btn  layui-btn-sm layui-btn-primary polar-search">
                <i class="fa fa-search-plus"></i> 搜索
            </button>
        </div>
    </div>
    <table data-striped="true" id="usercontent_table" lay-filter="usercontent_table"></table>
    <script type="text/javascript">
        $(function () {
            var columns = [[{
                checkbox: true,
                tableWidth: 50
            }
                , {
                    "field": "userName",
                    "title": "用户名",
                    sort: true,
                    formatter: function (row, options) {
                        var str = $("#listBtn2").html().split('[id]').join(row.id);
                        str = str.split('[userName]').join(row.userName);
                        return str;
                    }
                    ,minWidth:150
                }, {
                    "field": "state",
                    "title": "状态",
                    formatter: function (row, options) {
                        if (row.state == 0) {
                            return '<span style="color:#F00">已禁用</span>';
                        } else {
                            return '<span style="color:#019858">正常</span>';
                        }
                    }
                    , sort: true
                    ,minWidth:100
                }
                , {
                    "field": "logCount",
                    "title": "登陆次数",
                    sort: true
                    , miniTableWidth: 100
                    ,minWidth:150
                }
                , {
                    "field": "nickName",
                    "title": "昵称",
                    sort: true
                    , edit: "text"

                    ,minWidth:150
                }
                , {
                    "field": "logInIp",
                    "title": "登陆IP",
                    sort: true

                    ,minWidth:150
                }, {
                    "field": "logInDate",
                    "title": "登陆日期",
                    sort: true

                    ,minWidth:150
                }
                , {
                    "field": "createDate",
                    "title": "创建日期",
                    sort: true

                    ,minWidth:150
                }
                , {
                    "field": "phone",
                    "title": "手机号",
                    sort: true
                    ,minWidth:150
                }
                , {
                    field: 'operate',
                    title: '操作',
                    formatter: function (row, options) {
                        if(row.state==0){
                            return $("#usertableListDiv .polar-list-form .polar-btn-inner-template-enable").html().split('[id]').join(row.id);
                        }else{
                            return $("#usertableListDiv .polar-list-form .polar-btn-inner-template-disable").html().split('[id]').join(row.id);
                        }

                    }
                    , fixed: 'right'
                    , tableWidth: 490
                    , miniTableWidth: 300
                }]];
            var options = { //配置文件
                id: "usercontent_table",//表编号
                outDivId: "usertableListDiv",//最外层的div编号，用来重绘表格高度
                formFilter:"usertableListFormFilter",
                unionId: "id",//数据的唯一编号
                netIdKey: "id",//网络请求时，传入的主键编号
                netMulitKey: "ids",//网络请求时，一组主键编号的key
                name: "用户",//此模块的名称
                formWidth: '1000px',//表单宽度
                formHeight: '600px',//表单高度
                limits: [10, 20, 30, 50, 100]//页码数据

            };
            var urls = {
                listUrl: '/user/json/pageList',//列表的url
                addPage: "/user/web/add",//新增页面的url
                viewPage: "/user/web/detail",//查看页面的url
                deleteSingle: "/user/json/deleteById",//删除单条的url
                deleteMulit: "/user/json/deleteMulitById",//删除多条数据的url
                updatePage: "/user/web/update",//编辑页面的url
                updateField: "/user/json/updateField", //更新单个字段的url
                role: "/user/web/userRole",//分配角色的url
                menu: "/user/web/userMenuModel",
                clearUserMenu: "/user/json/clearUserMenuCache",
                clearUserPermission: "/user/json/clearUserInfo",
                clearUserMenuAll: "/user/json/clearAllUserMenuCache",
                clearUserPermissionAll: "/user/json/clearAllUserInfo",
                exportExcell: "/user/json/exportExcell",
                importExcellModel: "/user/json/importExcellModel",
                importExcell: "/user/json/importExcell", //导入excell的路径
                onlineuser: "/online/web/list",
                disableUser: "/user/json/disableUser",
                enableUser: "/user/json/enableUser",
            };
            var table = polar.table.layui(columns, options, urls);
            table.onQuery = function (that, args) {
                if (!polar.isNull(args.createDate)) {
                    args.createDate = args.createDate + " 00:00:00";
                }
                if (!polar.isNull(args.logInDate)) {
                    args.logInDate = args.logInDate + " 00:00:00";
                }
                return args;
            }
            table.onDataDone = function (that) {
                $("#" + that.options.outDivId).find("td .polar-role-inner").bind("click", function () {
                    var id = $(this).attr('polar-data');
                    var data = {};
                    data[that.options.unionId] = id;
                    polar.layer.loadLayer(that.urls.role, true,
                        {
                            width: '250px',
                            height: '500px',
                            yesContent: "分配角色",
                            yesBtn: true,
                            title: "分配角色",
                            clearForm: true
                        }, data);
                });
                $("#" + that.options.outDivId).find("td .polar-enableUser").bind("click", function () {
                    var id = $(this).attr('polar-data');
                    var data = {};
                    data[that.options.unionId] = id;
                    polar.dialog.confirm("提示", "您确定要启用此用户吗？", function () {
                        polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, that.urls.enableUser, true, {refresh: true}, data);
                    });
                });
                $("#" + that.options.outDivId).find("td .polar-disableUser").bind("click", function () {
                    var id = $(this).attr('polar-data');
                    var data = {};
                    data[that.options.unionId] = id;
                    polar.dialog.confirm("提示", "您确定要禁用此用户吗？", function () {
                        polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, that.urls.disableUser, true, {refresh: true}, data);
                    });
                });
                $("#" + that.options.outDivId).find("td .polar-menu-inner").bind("click", function () {
                    var id = $(this).attr('polar-data');
                    var data = {};
                    data[that.options.unionId] = id;
                    polar.layer.loadLayer(that.urls.menu, true,
                        {
                            width: '250px',
                            height: '500px',
                            yesContent: "分配菜单",
                            yesBtn: true,
                            title: "分配菜单",
                            clearForm: true
                        }, data);
                });

                $("#" + that.options.outDivId).find("td .polar-online-user").bind("click", function () {
                    var id = $(this).attr('polar-data');
                    var data = {};
                    data["userId"] = id;
                    polar.layer.loadLayer(that.urls.onlineuser, true,
                        {
                            width: that.options.formWidth,
                            height: that.options.formHeight,
                            yesBtn: false,
                            title: "在线用户",
                            clearForm: false,
                            end:function(){
                                polar.table.targetSecondTable.destroy();
                                polar.table.targetSecondTable = null;
                            }
                        }, data);
                });

            };
            table.onInitDone = function (that) {
                //清空菜单缓存
                $("#" +that.options.outDivId+" .polar-toolbar .polar-clear-user").click(function () {
                    var arrselections = that.getSelection(that);
                    if (arrselections.length == 0) {
                        polar.dialog.alert('提示', '请选择一条数据');
                    } else {
                        polar.dialog.confirm("提示", "清空菜单缓存将会使其菜单立即生效，您确定要执行此操作吗？", function () {
                            var ids = [];
                            var data = {};
                            for (var i = 0; i < arrselections.length; i++) {
                                ids.push(arrselections[i][that.options.unionId]);
                            }
                            data["userIds"] = ids;
                            polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, that.urls.clearUserMenu, true, {refresh: false}, data);
                        });
                    }
                });
                //清空权限缓存
                $("#"+that.options.outDivId+" .polar-toolbar .polar-clear-permission").click(function () {
                    var arrselections = that.getSelection(that);
                    if (arrselections.length == 0) {
                        polar.dialog.alert('提示', '请选择一条数据');
                    } else {
                        polar.dialog.confirm("提示", "清空权限缓存将会使其权限立即生效，您确定要执行此操作吗？", function () {
                            var ids = [];
                            var data = {};
                            for (var i = 0; i < arrselections.length; i++) {
                                ids.push(arrselections[i][that.options.unionId]);
                            }
                            data["userIds"] = ids;
                            polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, that.urls.clearUserPermission, true, {refresh: false}, data);
                        });
                    }
                });
                //清空菜单缓存
                $("#"+that.options.outDivId+" .polar-toolbar .polar-clear-user-all").click(function () {
                    polar.dialog.confirm("提示", "清空所有菜单缓存将会使所有人菜单立即生效，您确定要执行此操作吗？", function () {
                        polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, that.urls.clearUserMenuAll, true, {refresh: false}, null);
                    });
                });
                //清空权限缓存
                $("#" +that.options.outDivId+" .polar-toolbar .polar-clear-permission-all").click(function () {
                    polar.dialog.confirm("提示", "清空所有权限缓存将会使所有人的权限立即生效，您确定要执行此操作吗？", function () {
                        polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, that.urls.clearUserPermissionAll, true, {refresh: false}, null);
                    });
                });
            }
            table.init(table);
            $(window).resize(function () {
                table.resizeTable();
            });
        });
    </script>
</div>