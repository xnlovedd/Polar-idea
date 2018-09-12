<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8" %>
<%@ include file="/view/includes/tag.jsp" %>
<div class="polar-content"
     cache='true' id="onlineUserTableListDiv" >
    <input type="hidden" value='1' class="polar-page"/>
    <input type="hidden" value='10' class="polar-rows"/>
    <form class="layui-form polar-list-form" role="form" lay-filter='onlineUserTableListDiv'>
        <div style="display: none" class="polar-btn-inner-template">
            <shiro:hasPermission name="polar:online:downline">
                <button class="layui-btn layui-btn-primary layui-btn-xs polar-forceDownLine" polar-data="[id]">
                    <i class="fa fa-remove"></i> <span class="polar-btn-content">强制下线</span>
                </button>
            </shiro:hasPermission>
        </div>
    </form>
    <div class="layui-inline polar-toolbar">
        <div class="pull-right">
            <button class="layui-btn  layui-btn-sm layui-btn-primary  polar-refresh">
                <i class="fa fa-refresh"></i> <span class="polar-btn-content">刷新</span>
            </button>
        </div>
    </div>
    <table class="polar-table" id="onlineUserContent_table" lay-filter="onlineUserContent_table" >
    </table>
    <script type="text/javascript">
        $(function () {
            var columns = [[
                {
                    "field": "sessionId",
                    "title": "会话编号",
                    sort: false
                    , weigth: 1
                    , minWidth: 200

                }, {
                    "field": "loginIp",
                    "title": "登录IP",
                    sort: false
                    , miniTableWidth: 150
                    , tableWidth: 150
                }, {
                    "field": "lastAccessTime",
                    "title": "最后一次活跃时间",
                    sort: false,
                    miniTableWidth: 180
                    , tableWidth: 180
                }
                , {
                    "field": "expireTime",
                    "title": "到期时间",
                    sort: false,
                    miniTableWidth: 180
                    , tableWidth: 180
                    , formatter: function (row, options) {
                        if (polar.isNull(row.expireTime)) {
                            return "无期限";
                        }
                        return row.expireTime;
                    }
                }, {
                    "field": "expire",
                    "title": "状态",
                    sort: false,
                    miniTableWidth: 100
                    , tableWidth: 100
                    , formatter: function (row, options) {
                        if (row.expire) {
                            return "已过期";
                        }
                        return '正常';
                    }
                }
                <shiro:hasPermission name="polar:online:downline">
                , {
                    field: 'operate',
                    title: '操作',
                    formatter: function (row, options) {
                        return $("#onlineUserTableListDiv .polar-list-form .polar-btn-inner-template").html().split('[id]').join(row.sessionId);
                    },
                    tableWidth: 150,
                    fixed: "right"
                }
                </shiro:hasPermission>
            ]];
            var options = { //配置文件
                formFilter:"onlineUserTableListDiv",
                id: "onlineUserContent_table",//表编号
                outDivId: "onlineUserTableListDiv",//最外层的div编号，用来重绘表格高度
                unionId: "sessionId",//数据的唯一编号
                userId: "${userId}",
                limits: [10, 20, 30, 50, 100]//页码数据

            };
            var urls = {
                listUrl: '/online/json/pageList?userId=${userId}',//列表的url
                forceDownLine: "/online/json/forceDownLine" //强制下线的url
            };
            var table = polar.table.layui(columns, options, urls);
            table.onDataDone = function (that) {
                $("#" + that.options.outDivId).find("td .polar-forceDownLine").bind("click", function () {
                    var id = $(this).attr('polar-data');
                    var data = {};
                    data[that.options.unionId] = id;
                    data["userId"] = that.options.userId;
                    polar.dialog.prompt("请输入下线原因", function (value) {
                        data["message"] = value;

                        polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, that.urls.forceDownLine, true, {
                            onRequestOk: function () {
                                polar.table.targetSecondTable.refresh();
                            }
                        }, data);
                    });
                });
            };
            table.init(table, true);

        });
    </script>
</div>