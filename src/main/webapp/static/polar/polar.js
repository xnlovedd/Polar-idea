//定义全局变量
var polar = {
    isNull: function (str) {
        if (str != null && str != 'undefined' && str.length != 0) {
            return false;
        }
        return true;
    },
    isArray:function isArray(o){
        return Object.prototype.toString.call(o)=='[object Array]';
    },
     uuid:function() {
        var s = [];
        var hexDigits = "0123456789abcdef";
        for (var i = 0; i < 36; i++) {
            s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
        }
        s[14] = "4";
        s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);

        s[8] = s[13] = s[18] = s[23] = "-";

        var uuid = s.join("");
        return uuid;
    },
    // 初始化方法，初始化完毕会回调call方法
    init: function (call) {
        // 使用layui
        layui.config({
            base: '/layui/lay/modules/'
        }); // 加载入口
        layui.use(['layer', 'laydate', 'form', 'element', 'layedit', 'upload',
                'laydate', 'table', 'code'], function () {
                layui.layedit.set({
                    uploadImage: {
                        url: ctx + polar.constants.uploadFile //接口url
                        , type: 'post' //默认post
                        , done: function (res) {
                            if (res.code != polar.constants.success) {
                                if (!polar.permission.logFilter(res)) {
                                    polar.dialog.alert("提示", data.res);
                                }
                                return {code: 1, src: res.msg};
                            } else {
                                return {code: 0, data: {src: res.data, title: ''}};
                            }
                        }
                    }
                });
            call();
        });
    }
};
$(function () {
    // 定义常量
    var constants = {
        noPermission: '000009',// 没有权限
        success: '000000',// 成功
        anonymous: '000008',// 用户未登录
        forceDownLine: '000010',// 用户未登录
        viewPic: '/viewPic',// 查看图片的地址
        uploadFile: '/uploadFile',
        navePage: "/firstPage",
        logInPage: '',// 登录页面的路径
        mainPage: '',//主页的url
        logInUrl: '/logIn',//登录的路径
        logOutUrl: '/logOut'//退出登录的路径
    };
    polar.constants = constants;
});
/**
 * options定义：
 * width:宽度
 * height:高度
 * clearForm:是否清除当前的form对象
 * closeIndex:点击保存后，需要关闭的layer的index
 * refresh:点击保存后，是否调用table的刷新方法
 * title:layer的标题
 */
$(function () {
    // 定义加载器
    var loader = {
        // 加载远程数据，参数为：加载成功回调，加载失败回调，加载的Url,是否打开loading图层，加载配置文件，加载的数据
        load: function (loadSuccess, loadError, url, loading, options, data) {
            if (loading) {
                polar.dialog.loading("加载中...");
            }
            $.ajax({
                type: 'post',
                url: ctx + url,
                contentType: "application/x-www-form-urlencoded",
                dataType: "html",
                data: data,
                success: function (data2, status, request) {
                    loadSuccess(request.getResponseHeader('Content-Type'), url, loading,options, data2);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    loadError(XMLHttpRequest, textStatus, errorThrown, url, loading, options, data);
                }
            });
        }
        , jsonSuccess: function (contentType, url, loading, options, data) {
            if (loading) {
                polar.dialog.closeLoading();
            }
            if (contentType.indexOf("application/json") == -1) {
                polar.dialog.alert("提示", "服务器正忙，请稍后再试");
                return;
            }
            data = JSON.parse(data);
            if (data.code != polar.constants.success) {
                if (!polar.permission.logFilter(data)) {
                    polar.dialog.alert("提示", data.msg);
                }
            } else {
                polar.dialog.toast(data.msg);
                if (options != null && options.refresh) {
                    try {
                        polar.table.target.refresh();
                    } catch (e) {
                    }
                }
                //自定义的回调
                if (options != null && options.onRequestOk != null && typeof options.onRequestOk === 'function') {
                    try {
                        options.onRequestOk(data);
                    } catch (e) {

                    }
                }
                if (options != null && options.closeIndex != null && options.closeIndex != 'undefined') {
                    layui.layer.close(options.closeIndex);
                }
            }
        }
        , jsonError: function (XMLHttpRequest, textStatus, errorThrown, url, loading, options, data) {
            if (loading) {
                polar.dialog.closeLoading();
            }
            polar.dialog.alert('提示', "网络异常，请检查您的网络连接方式.");
        }
    };
    polar.loader = loader;
});
$(function () {
    // 定义提示框，依赖layui的layer
    var dialog = {
        toast: function (message) {// 展示吐司
            if (message == undefined || message == "") {
                return;
            }
            layui.layer.msg(message, {time: 3000});
        },
        confirm: function (title, message, call) {// 带有确定的提示框
            var index = layui.layer.confirm(message, {
                title: title,
                btn: ['确定', '取消']
            }, function () {
                layui.layer.close(index);
                call.call(this);
            }, function () {

            });
        },
        prompt:function(title,call){
            var index = layui.layer.prompt({
                formType: 2,
                title: title,
            },function(value, index, elem){
                call(value);
                layer.close(index);
            });
        },
        alert: function (title, message) {// 提示信息
            layui.layer.open({
                title: title,
                content: message
            });
        },
        loading: function (mess) { // 打开加载中图层
            /*if (mess == undefined || mess == "") {
				mess = "正在提交，请稍等...";
			}
			layui.layer.msg(mess, {
				icon : 16,
				shade : 0.01,
				time : 0,
				success : function(layero, index) {
				}
			});*/
            if (!polar.isNull(polar.dialog.index)) {
                layer.close(polar.dialog.index);
            }
            polar.dialog.index = layer.load(1, {
                shade: [0.1, '#fff'] //0.1透明度的白色背景
            });
        },
        closeLoading: function () {// 关闭加载中图层
            if (!polar.isNull(polar.dialog.index)) {
                layer.close(polar.dialog.index);
            }
            /*		layui.layer.closeAll('dialog');*/
        }
    };
    polar.dialog = dialog;
});
$(function () {
    // 定义layer
    var layer = {
        // 加载远程地址的图层
        loadLayer: function (url, loading, options, data) {
            polar.loader.load(polar.layer.success, polar.layer.error, url, loading, options,
                data);
        },
        // 打开一个图层,参数分别为：图层内容数据，高度，宽度，标题，配置参数
        layer: function (data, width, height, options) {
            var yesBtn, yesCall, yesContent, title, success, end;// 是否有确定按钮，确定按钮回调，确定按钮内容,标题,弹出成功的回调
            if (options != null && options != 'undefined') {
                yesBtn = options.yesBtn;
                yesCall = options.yesCall;
                yesContent = options.yesContent;
                title = options.title;
                success = options.success;
                end = options.end;
            }
            if (yesBtn == null || yesBtn == 'undefined') {
                yesBtn = false;
            }
            if (success == null || success == 'undefined') {
                success = function (layero, index) {
                };
            }
            if (yesCall == null || yesCall == 'undefined') {
                yesCall = function (index, layero) {
                    polar.form.target.submit(index);
                };
            }
            if (end == null || end == 'undefined') {
                end = function () {
                    if (options != null && options.clearForm != null && options.clearForm != 'undefined') {
                        if (options.clearForm) {
                            polar.form.target = null;
                        }
                    }
                };
            }
            if (yesContent == null || yesContent == 'undefined') {
                yesContent = "保存";
            }
            if (title == null || title == 'undefined') {
                title = "";
            }
            var maxWidth=document.body.clientWidth;
            var maxHeight=document.body.clientHeight;
            if(width.indexOf("px")!=-1&&parseInt(width.replace("px","")) >maxWidth){
                width=maxWidth+'px';
            }
            if(height.indexOf("px")!=-1&&parseInt(height.replace("px","")) >maxHeight){
                height=maxHeight+'px';
            }
            if (!yesBtn) {
               var index= layui.layer.open({
                    type: 1,
                    area: [width, height],
                    title: title,
                    maxmin: true, // 开启最大化最小化按钮
                    content: data,
                    btn: ['关闭'],
                    cancel: function (index) {
                        layui.layer.close(index);
                    },
                    end: end,
                    success: success
                });
            } else {
                var index= layui.layer.open({
                    type: 1,
                    area: [width, height],
                    title: title,
                    maxmin: true, // 开启最大化最小化按钮
                    content: data,
                    btn: [yesContent, '关闭'],
                    yes: yesCall,
                    cancel: function (index) {
                        layui.layer.close(index);
                    },
                    end: end,
                    success: success
                });
            }
        },
        // 图层加载成功的回调
        success: function (contentType, url, loading, options, data) {
            if (loading) {
                polar.dialog.closeLoading();
            }
            if (contentType.indexOf("application/json") > -1) {
                data = JSON.parse(data);
                if (!polar.permission.logFilter(data)) {
                    polar.dialog.alert("提示", data.msg);
                }
                return;
            }
            polar.layer.layer(data, options.width, options.height, options);
        },
        // 图层加载失败的回调
        error: function (XMLHttpRequest, textStatus, errorThrown, url, loading,
                         options, data) {
            if (loading) {
                polar.dialog.closeLoading();
            }
            polar.dialog.alert('提示', "网络异常，请检查您的网络连接方式.");
        }
    };
    polar.layer = layer;
});
$(function () {
    // 定义权限器
    var permission = {
        // 登录校验器,如果已处理，则返回true
        logFilter: function (data) {
            if (data.code == polar.constants.anonymous) {
                polar.permission.kickOut(polar.isNull(data.msg) ? "当前用户未登录或登录超时，请重新登录。" : data.msg);
                return true;
            } else if (data.code == polar.constants.forceDownLine) {
                polar.permission.kickOut(polar.isNull(data.msg) ? "您的账号在另外一台设备登录，您已被强制下线." : data.msg);
                return true;
            } else if (data.code == polar.constants.noPermission) {
                polar.dialog.alert("提示", "您无权限访问此页面！");
                return true;
            }
            return false;
        },
        kickOut: function (str) {// 踢出当前用户
            layui.layer.open({
                title: "错误",
                content: str,
                closeBtn: 0,// 去掉右上角关闭按钮
                move: false,// 禁止拖拽
                yes: function (index) {
                    layui.layer.close(index);
                    // 跳转到登录页面
                    window.location.href = ctx + polar.constants.logInPage;
                }
            });
        }
    };
    polar.permission = permission;
});
$(function () {
    // 定义tab
    var tab = {
        // 选项卡内的数据
        iframeDates: []
        // 面板div的id
        , frame: $("#content-main")
        // 主页数据
        , mainPageData: null
        //当前的form,打开网页时，需要添加进去，关闭时，需要清除，当切换时，需要保存数据的form对象
        , currentForm: null
        , currentTableId: null
        // tab加载成功的回调
        , success: function (contentType, url, loading, options, data) {
            if (loading) {
                polar.dialog.closeLoading();
            }
            if (contentType.indexOf("application/json") > -1) {
                data = JSON.parse(data);
                if (!polar.permission.logFilter(data)) {
                    polar.dialog.alert("提示", data.msg);
                }
                return;
            }
            polar.tab.saveCurrentPage();
            if ($('.page-tabs-content').children("[data-id]:first").attr(
                    'data-id') == url) {
                polar.tab.mainPageData = data;
                polar.tab.frame.html(data);
                return;
            }
            var entity = {
                name: url,
                value: data
            };
            var has = false;
            for (var position in polar.tab.iframeDates) {
                var tmp = polar.tab.iframeDates[position];
                if (tmp.name == url) {
                    has = true;
                    polar.tab.iframeDates[position] = entity;
                    break;
                }
            }
            if (!has) {
                polar.tab.iframeDates.push(entity);
                var str = '<a href="javascript:;" class="active J_menuTab" data-id="'
                    + url
                    + '">'
                    + options.title
                    + ' <i class="fa fa-times-circle"></i></a>';
                $('.J_menuTab').removeClass('active');
                // 添加选项卡
                $('.J_menuTabs .page-tabs-content').append(str);
                polar.tab.scrollToTab($('.J_menuTab.active'));
                polar.tab.frame.html(entity.value);
            } else {
                polar.tab.frame.html(entity.value);
            }
        }
        , error: function (XMLHttpRequest, textStatus, errorThrown, url, loading,
                           options, data) {
            if (loading) {
                polar.dialog.closeLoading();
            }
            polar.dialog.alert('提示', "网络异常，请检查您的网络连接方式.");
        }
        , saveCurrentPage: function () {
            var activeId = $('.page-tabs-content a').filter(".active").data('id');
            var that = polar.tab;
            if (activeId != null && activeId != 'undefined') {
                if (polar.tab.currentForm != null && polar.tab.currentForm.attr('cache') == 'true') {
                    $("input[cache='true']").each(function (index) {
                        //将值插入标签中，便于保存.....
                        $(this).attr('value', $(this).val());
                    });
                    $("select[cache='true']").each(function (index) {
                        //保存select的值
                        var value = $(this).val();
                        $(this).find('option').each(function (index) {
                            var value2 = $(this).val();
                            if (value2 == value) {
                                $(this).attr('selected', 'selected');
                            } else {
                                $(this).removeAttr('selected');
                            }
                        });
                    });
                    try {
                        polar.table.target.destroy();
                        polar.table.targetSecondTable.destroy();
                    } catch (e) {
                    }
                    if ($('.page-tabs-content').children("[data-id]:first").attr('data-id') == activeId) {
                        that.mainPageData = that.frame.html();
                    } else {
                        for (var position in that.iframeDates) {
                            if (that.iframeDates[position].name == activeId) {
                                that.iframeDates[position].value = that.frame.html();
                                break;
                            }
                        }
                    }
                }
                //销毁table，防止报错。
                try {
                    try {
                        polar.table.target.destroy();
                        polar.table.targetSecondTable.destroy();
                    } catch (e) {
                        console.log(e);
                    }
                    //清除当前默认的表对象
                    polar.table.target = null;
                    polar.tab.currentForm = null;
                    polar.table.targetSecondTable=null;
                } catch (e) {
                    console.log(e);
                }
            }
        }
        , init: function () {
            var that = polar.tab;
            // 通过遍历给菜单项加上data-index属性
            $(".menuItem").each(function (index) {
                if (!$(this).attr('data-index')) {
                    $(this).attr('data-index', index);
                }
            });
            $('.menuItem').on('click', that.menuItem);
            $('.J_menuTabs').on('click', '.J_menuTab i', that.closeTab);
            $('.J_tabCloseOther').on('click', that.closeOtherTabs);
            $('.J_tabShowActive').on('click', that.showActiveTab);
            $('.J_menuTabs').on('click', '.J_menuTab', that.activeTab);
            $('.J_menuTabs').on('dblclick', '.J_menuTab', that.refresh);
            // 左移按扭
            $('.J_tabLeft').on('click', that.scrollTabLeft);
            // 右移按扭
            $('.J_tabRight').on('click', that.scrollTabRight);
            // 关闭全部
            $('.J_tabCloseAll').on('click',function () {
                try {
                    try {
                        polar.table.target.destroy();
                        polar.table.targetSecondTable.destroy();
                    } catch (e) {
                    }
                    //清除当前默认的表对象
                    polar.table.target = null;
                    polar.table.targetSecondTable=null;
                    polar.tab.currentForm = null;
                } catch (e) {

                }
                    $('.page-tabs-content').children("[data-id]").not(":first")
                        .each(function () {
                            $(this).remove();
                        });
                    if (that.iframeDates.length > 0) {
                        that.iframeDates.splice(0, that.iframeDates.length);
                    }
                    that.iframeDates = [];
                    $('.page-tabs-content').children("[data-id]:first").each(
                        function () {
                            that.frame.html(that.mainPageData);
                            $(this).addClass("active");
                        });
                    $('.page-tabs-content').css("margin-left", "0");

                });
            polar.loader.load(that.success, that.error, polar.constants.navePage, true, {title: "首页"}, null);
        }
        // 计算元素集合的总宽度
        , calSumWidth: function (elements) {
            var width = 0;
            $(elements).each(function () {
                width += $(this).outerWidth(true);
            });
            return width;
        }
        , scrollToTab: function (element) {
            var marginLeftVal = polar.tab.calSumWidth($(element).prevAll()), marginRightVal = polar.tab.calSumWidth($(
                element).nextAll());
            // 可视区域非tab宽度
            var tabOuterWidth = polar.tab.calSumWidth($(".content-tabs").children().not(
                ".J_menuTabs"));
            // 可视区域tab宽度
            var visibleWidth = $(".content-tabs").outerWidth(true) - tabOuterWidth;
            // 实际滚动宽度
            var scrollVal = 0;
            if ($(".page-tabs-content").outerWidth() < visibleWidth) {
                scrollVal = 0;
            } else if (marginRightVal <= (visibleWidth - $(element).outerWidth(true) - $(
                    element).next().outerWidth(true))) {
                if ((visibleWidth - $(element).next().outerWidth(true)) > marginRightVal) {
                    scrollVal = marginLeftVal;
                    var tabElement = element;
                    while ((scrollVal - $(tabElement).outerWidth()) > ($(
                        ".page-tabs-content").outerWidth() - visibleWidth)) {
                        scrollVal -= $(tabElement).prev().outerWidth();
                        tabElement = $(tabElement).prev();
                    }
                }
            } else if (marginLeftVal > (visibleWidth - $(element).outerWidth(true) - $(
                    element).prev().outerWidth(true))) {
                scrollVal = marginLeftVal - $(element).prev().outerWidth(true);
            }
            $('.page-tabs-content').animate({
                marginLeft: 0 - scrollVal + 'px'
            }, "fast");
        }
        // 查看左侧隐藏的选项卡
        , scrollTabLeft: function () {
            var marginLeftVal = Math.abs(parseInt($('.page-tabs-content').css(
                'margin-left')));
            // 可视区域非tab宽度
            var tabOuterWidth = polar.tab.calSumWidth($(".content-tabs").children().not(
                ".J_menuTabs"));
            // 可视区域tab宽度
            var visibleWidth = $(".content-tabs").outerWidth(true) - tabOuterWidth;
            // 实际滚动宽度
            var scrollVal = 0;
            if ($(".page-tabs-content").width() < visibleWidth) {
                return false;
            } else {
                var tabElement = $(".J_menuTab:first");
                var offsetVal = 0;
                while ((offsetVal + $(tabElement).outerWidth(true)) <= marginLeftVal) {// 找到离当前tab最近的元素
                    offsetVal += $(tabElement).outerWidth(true);
                    tabElement = $(tabElement).next();
                }
                offsetVal = 0;
                if (polar.tab.calSumWidth($(tabElement).prevAll()) > visibleWidth) {
                    while ((offsetVal + $(tabElement).outerWidth(true)) < (visibleWidth)
                    && tabElement.length > 0) {
                        offsetVal += $(tabElement).outerWidth(true);
                        tabElement = $(tabElement).prev();
                    }
                    scrollVal = polar.tab.calSumWidth($(tabElement).prevAll());
                }
            }
            $('.page-tabs-content').animate({
                marginLeft: 0 - scrollVal + 'px'
            }, "fast");
        }
        // 查看右侧隐藏的选项卡
        , scrollTabRight: function () {
            var marginLeftVal = Math.abs(parseInt($('.page-tabs-content').css(
                'margin-left')));
            // 可视区域非tab宽度
            var tabOuterWidth = polar.tab.calSumWidth($(".content-tabs").children().not(
                ".J_menuTabs"));
            // 可视区域tab宽度
            var visibleWidth = $(".content-tabs").outerWidth(true) - tabOuterWidth;
            // 实际滚动宽度
            var scrollVal = 0;
            if ($(".page-tabs-content").width() < visibleWidth) {
                return false;
            } else {
                var tabElement = $(".J_menuTab:first");
                var offsetVal = 0;
                while ((offsetVal + $(tabElement).outerWidth(true)) <= marginLeftVal) {// 找到离当前tab最近的元素
                    offsetVal += $(tabElement).outerWidth(true);
                    tabElement = $(tabElement).next();
                }
                offsetVal = 0;
                while ((offsetVal + $(tabElement).outerWidth(true)) < (visibleWidth)
                && tabElement.length > 0) {
                    offsetVal += $(tabElement).outerWidth(true);
                    tabElement = $(tabElement).next();
                }
                scrollVal = polar.tab.calSumWidth($(tabElement).prevAll());
                if (scrollVal > 0) {
                    $('.page-tabs-content').animate({
                        marginLeft: 0 - scrollVal + 'px'
                    }, "fast");
                }
            }
        }
        , menuItem: function () {
            var that = polar.tab;
            // 获取标识数据
            var dataUrl = $(this).attr('href'), dataIndex = $(this).data('index'), menuName = $
                .trim($(this).text()), flag = true;
            if (dataUrl == undefined || $.trim(dataUrl).length == 0) {
                // 第一个
                return false;
            }
            if ($('.page-tabs-content').children("[data-id]:first").attr('data-id') == dataUrl) {
                that.saveCurrentPage();
                $('.J_menuTab').removeClass('active');
                $('#content-main').html(that.mainPageData);
                $('.page-tabs-content').children("[data-id]:first").addClass('active');
                polar.tab.scrollToTab($('.page-tabs-content').children("[data-id]:first"));
                return false;
            }
            var entity;
            var has = false;
            for (var mEntity in that.iframeDates) {
                if (that.iframeDates[mEntity].name == dataUrl) {
                    entity = that.iframeDates[mEntity];
                    has = true;
                    break;
                }
            }
            if (has) {
                // 选项卡菜单已存在
                $('.J_menuTab').each(
                    function () {
                        if ($(this).data('id') == dataUrl) {
                            if (!$(this).hasClass('active')) {
                                that.saveCurrentPage();
                                $(this).addClass('active').siblings('.J_menuTab')
                                    .removeClass('active');
                                that.scrollToTab(this);
                                // 显示tab对应的内容区
                                that.frame.html(entity.value);
                            }
                            flag = false;
                            return false;
                        }
                    });
            }

            // 选项卡菜单不存在
            if (flag) {
                polar.loader.load(that.success, that.error, dataUrl, true, {title: menuName}, null);
            }
            return false;
        }
        // 关闭选项卡菜单
        , closeTab: function () {
            try {
                try {
                    polar.table.target.destroy();
                    polar.table.targetSecondTable.destroy();
                } catch (e) {
                }
                //清除当前默认的表对象
                polar.table.target = null;
                polar.tab.currentForm = null;
                polar.table.targetSecondTable=null;
            } catch (e) {

            }
            var that = polar.tab;
            var closeTabId = $(this).parents('.J_menuTab').data('id');
            var currentWidth = $(this).parents('.J_menuTab').width();
            // 当前元素处于活动状态
            if ($(this).parents('.J_menuTab').hasClass('active')) {
                // 当前元素后面有同辈元素，使后面的一个元素处于活动状态
                if ($(this).parents('.J_menuTab').next('.J_menuTab').length > 0) {
                    var activeId = $(this).parents('.J_menuTab').next(
                        '.J_menuTab:eq(0)').data('id');
                    $(this).parents('.J_menuTab').next('.J_menuTab:eq(0)').addClass(
                        'active');
                    // 显示后一个元素
                    for (var position in that.iframeDates) {
                        if (that.iframeDates[position].name == activeId) {
                            index = position;
                            that.frame.html(that.iframeDates[position].value);
                        }
                    }
                    var marginLeftVal = parseInt($('.page-tabs-content').css(
                        'margin-left'));
                    if (marginLeftVal < 0) {
                        $('.page-tabs-content').animate({
                            marginLeft: (marginLeftVal + currentWidth) + 'px'
                        }, "fast");
                    }
                    // 移除当前选项卡
                    $(this).parents('.J_menuTab').remove();
                    // 移除内容
                    that.removeTabData(closeTabId);
                } else if ($(this).parents('.J_menuTab').prev('.J_menuTab').length > 0) {
                    if ($(".page-tabs-content").children('.J_menuTab').length <= 2) {
                        $(this).parents('.J_menuTab').remove();
                        $('.page-tabs-content').children("[data-id]:first").addClass(
                            'active');
                        that.frame.html(that.mainPageData);
                        that.removeTabData(closeTabId);
                        return false;
                    }
                    // 当前元素后面没有同辈元素，使当前元素的上一个元素处于活动状态
                    var activeId = $(this).parents('.J_menuTab')
                        .prev('.J_menuTab:last').data('id');
                    $(this).parents('.J_menuTab').prev('.J_menuTab:last').addClass(
                        'active');
                    for (var position in that.iframeDates) {
                        if (that.iframeDates[position].name == activeId) {
                            index = position;
                            that.frame.html(that.iframeDates[position].value);
                        }
                    }
                    // 移除当前选项卡
                    $(this).parents('.J_menuTab').remove();
                    // 移除tab对应的内容区
                    that.removeTabData(closeTabId);
                }
            }
            // 当前元素不处于活动状态
            else {
                // 移除当前选项卡
                $(this).parents('.J_menuTab').remove();
                // 移除内容
                that.removeTabData(closeTabId);
                that.scrollToTab($('.J_menuTab.active'));
            }
            return false;
        }
        , removeTabData: function (dataUrl) {
            var index = -1;
            for (var position in polar.tab.iframeDates) {
                if (polar.tab.iframeDates[position].name == dataUrl) {
                    index = position;
                    break;
                }
            }
            if (index != -1) {
                polar.tab.iframeDates.splice(index, 1);
            }
        }
        // 关闭其他选项卡
        , closeOtherTabs: function () {
            var that = polar.tab;
            $('.page-tabs-content').children("[data-id]").not(":first").not(".active")
                .each(function () {
                    that.removeTabData($(this).data('id'));
                    $(this).remove();
                });
            $('.page-tabs-content').css("margin-left", "0");
        }
        // 滚动到已激活的选项卡
        , showActiveTab: function () {
            polar.tab.scrollToTab($('.J_menuTab.active'));
        }
        // 点击选项卡菜单
        , activeTab: function () {
            if (!$(this).hasClass('active')) {
                polar.tab.saveCurrentPage();
                var currentId = $(this).data('id');
                if ($('.page-tabs-content').children("[data-id]:first").attr('data-id') == currentId) {
                    $(this).addClass('active').siblings('.J_menuTab').removeClass(
                        'active');
                    polar.tab.frame.html(polar.tab.mainPageData);
                    $('.page-tabs-content').children("[data-id]:first").addClass(
                        'active');
                    return;
                }
                // 显示tab对应的内容区
                for (var mEntity in polar.tab.iframeDates) {
                    if (polar.tab.iframeDates[mEntity].name == currentId) {
                        entity = polar.tab.iframeDates[mEntity];
                        polar.tab.frame.html(polar.tab.iframeDates[mEntity].value);
                        break;
                    }
                }
                $(this).addClass('active').siblings('.J_menuTab').removeClass('active');
                polar.tab.scrollToTab(this);
            }
        }
        // 刷新iframe
        , refresh: function () {
            var id = $(this).data('id');
            polar.loader.load(polar.tab.success, polar.tab.error, id, true, null, null);
        }
        // 打开选项卡菜单
        , openTab: function (url, title) {// isNew
            var that = polar.tab;
            // 为true时，打开一个新的选项卡；为false时，如果选项卡不存在，打开一个新的选项卡，如果已经存在，使已经存在的选项卡变为活跃状态。
            // 获取标识数据
            var dataUrl = url, dataIndex, menuName = title, flag = true;
            if (dataUrl == undefined || top.$.trim(dataUrl).length == 0)
                return false;

            if ($('.page-tabs-content').children("[data-id]:first").attr('data-id') == dataUrl) {
                polar.tab.frame.html(polar.tab.mainPageData);
                $('.page-tabs-content').children("[data-id]:first").addClass('active');
                return false;
            }
            var entity;
            var has = false;
            for (var mEntity in polar.tab.iframeDates) {
                if (polar.tab.iframeDates[mEntity].name == dataUrl) {
                    entity = polar.tab.iframeDates[mEntity];
                    has = true;
                    break;
                }
            }
            if (has) {
                // 选项卡菜单已存在
                $('.J_menuTab').each(
                    function () {
                        if ($(this).data('id') == dataUrl) {
                            if (!$(this).hasClass('active')) {
                                $(this).addClass('active').siblings('.J_menuTab')
                                    .removeClass('active');
                                that.scrollToTab(this);
                                // 显示tab对应的内容区
                                that.frame.html(entity.value);
                            }
                            flag = false;
                            return false;
                        }
                    });
            }
            // 选项卡菜单不存在
            if (flag) {
                polar.loader.load(polar.tab.success, polar.tab.error, dataUrl, true, {title: menuName}, null);
            }
            return false;

        }
    };
    polar.tab = tab;
});
/**
 * 定义：target,正在操作的表单对象，当其在layer中时，如果没有设置yes的回调函数，则会调用target的submit方法.当在option中设置clearForm=true时，如果其依赖的图层被销毁，则其会被置空。
 */
$(function () {
    // 定义表单
    var form = {
        // 表单校验
        Verification: function (form) {
            var config = {
                verify: {
                    /* required : [ /[\S]+/, '必填项不能为空' ], */
                    phone:function (value, item) {
                        if(!polar.isNull(value)){
                            if(/^1\d{10}$/.test(value)){

                            }else{
                                return '必须为手机号';
                            }
                        }
                    },

                    email: [
                        /(^$)|^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/,
                        '必须为邮箱'],
                    url: [/(^#)|(^http(s*):\/\/[^\s]+\.[^\s]+)/, '链接格式不正确'],
                    number: [/(^$)|^\d+$/, '只能为数字'],
                    date: [
                        /^(\d{4})[-\/](\d{1}|0\d{1}|1[0-2])([-\/](\d{1}|0\d{1}|[1-2][0-9]|3[0-1]))*$/,
                        '日期格式不正确'],
                    numeric: [/(^$)|(^-?\d+)|(^-?\d+)(\.\d+)?$/, '只能为数字'],
                    identity: [/(^$)|(^\d{15}$)|(^\d{17}(x|X|\d)$)/,
                        '必须为身份证格式'],
                    required: function (value, item) {
                        if (!/[\S]+/.test(value)) {
                            return "不能为空";
                        }
                    },maxLength:function(value, item){

                        if(!polar.isNull(value)){
                            var maxLength=$(item).attr('polar-maxLength');
                            if(maxLength>0&&maxLength<value.length){
                                return "最多只能输入"+maxLength+"位";
                            }
                        }

                    },minLength:function(value, item){

                        if(!polar.isNull(value)){
                            var minLength=$(item).attr('polar-minLength');
                            if(minLength>0&&minLength>value.length){
                                return "最少输入"+minLength+"位";
                            }
                        }
                    }
                }
            };
            formElem = $(form);
            var button = $(this), verify = config.verify, stop = null, DANGER = 'layui-form-danger', field = {},
                verifyElem = formElem
                    .find('*[lay-verify]') // 获取需要校验的元素
                , fieldElem = formElem.find('input,select,textarea') // 获取所有表单域
            // 开始校验
            layui.each(verifyElem, function (_, item) {
                var othis = $(this), tips = '';
                var arr = othis.attr('lay-verify').split(',');
                var tag = othis.attr('tag');
                if (tag == null || tag == 'undefined') {
                    tag = "";
                }
                for (var i in arr) {
                    var ver = arr[i];
                    var value = othis.val(), isFn = typeof verify[ver] === 'function';
                    othis.removeClass(DANGER);
                    if (verify[ver]
                        && (isFn ? tips = verify[ver](
                            value, item)
                            : !verify[ver][0]
                                .test(value))) {
                        layer.msg(tag + (tips || verify[ver][1]), {
                            icon: 5,
                            shift: 6
                        });
                        // 非移动设备自动定位焦点
                        if (!layui.device().android
                            && !layui.device().ios) {
                            item.focus();
                        }
                        othis.addClass(DANGER);
                        return stop = true;
                    }
                }
            });
            if (stop)
                return false;

            layui.each(fieldElem, function (_, item) {
                if (!item.name)
                    return;
                if (/^checkbox|radio$/.test(item.type) && !item.checked)
                    return;
                field[item.name] = item.value;
            });
            // 返回序列化表单元素， JSON 数据结构数据。
            return true;
        }
    };
    Form = function (options) {
        if (options != null) {
            this.options = options;
        }
    };
    Form.prototype.options = {
        addUrl: "",//定义新增的url
        upDateUrl: "",//定义修改的url
        id: "form",//定义表单编号,要求lay-flter也为此
        unionId: "id"//主键编号
    };
    Form.prototype.validate = function (that) {//校验数据
        if($('#' + that.options.id+" div.polar-img-loading:visible").length>0){
            layui.layer.msg("请等待所有图片上传完毕", {
                icon: 5,
                shift: 6
            });
            return false;
        }
        if($('#' + that.options.id+" div.polar-file-loading:visible").length>0){
            layui.layer.msg("请等待所有文件上传完毕", {
                icon: 5,
                shift: 6
            });
            return false;
        }
        return polar.form.Verification('#' + that.options.id);
    };
    Form.prototype.done = function (that, layuiForm) {//加载完成的回调

    };
    Form.prototype.onSubmitOptions = function (args, that) {
        return args;
    };
    Form.prototype.beforeValidate = function (that) {

    };
    Form.prototype.submit = function (index) {//提交数据
        var that = this;
        that.beforeValidate(that);
        if (that.validate(that)) {
            //提交表单
            var id = $("input[name='" + that.options.unionId + "']").val();
            var url = that.options.addUrl;
            if (id != null && id != 'undefined' && id != '') {
                url = that.options.upDateUrl;
            }
            var data = that.params(that);
            if (that.onSubmit != null && that.onSubmit != 'undefined' && typeof that.onSubmit === 'function') {
                that.onSubmit(that, data);
            }
            var options = {closeIndex: index, refresh: true};
            options = that.onSubmitOptions(options, that);
            polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, url, true, options, data);
        }
    };
    Form.prototype.params = function (that) {//获取提交参数
        var m;
        m = $("#" + that.options.id).serializeArray();
        var data = {};
        for (var p in m) {
            var va = m[p].value;
            if (va != null && va != 'undefined' && va != '') {
                if(!polar.isNull( data[m[p].name] )){
                    data[m[p].name]=[ data[m[p].name] ,m[p].value];
                }else{
                    data[m[p].name] = m[p].value;
                }
            }
        }
        return data;
    };
    Form.prototype.init = function (that) {//初始化
        var form = layui.form;
        that.done(that, form);
        polar.form.target = that;
        form.render(null, that.options.id); //更新全部
    };
    polar.form = form;
    polar.form.Form = function (options) {
        var form = new Form(options);
        return form;
    }
    //临时表
    polar.form.TmpForm = function (options) {
        var form = new Form(options);
        form.init=function(that){
            var form = layui.form;
            that.done(that, form);
            polar.form.tmp = that;
            form.render(null, that.options.id);
        };
        form.submit=function (index) {//提交数据
            var that = this;
            if (that.validate(that)) {
                var data = that.params(that);
                if (that.onSubmit != null && that.onSubmit != 'undefined' && typeof that.onSubmit === 'function') {
                    that.onSubmit(that, data);
                }
                layui.layer.close(index);//关闭图层
                polar.form.tmp =null;
                return data;
            }
            return null;
        };
        return form;
    }
});
/**
 * 定义：target:当前正在操作的表对象，切换标签时，会调用其destroy方法，销毁表,并且会将其置为null,当需要刷新表（如：表单保存后）时，会调用其refresh方法。
 *
 */
$(function () {

    // 定义table
    var table = {
        // 定义：weigth:权重，tableWidth:宽度，maxWidth:最大宽度，minWidth最小宽度
        // 计算列属性，参数为：总宽度，列属性，是否使用px
        calcTableColumns: function (total, columns, px) {
            var lastWidth = 0;// 剩余宽度
            var totalWeigth = 0;
            total=total-columns.length-1;
            if(px){
                total=total-3;
            }
            var maxWidth=document.body.clientWidth;
            for (var i = 0; i < columns.length; i++) {
                  var item = columns[i];
                  var weigth = 0;
                    if (item.weigth != null && item.weigth != 'undefined') {
                        weigth = item.weigth;
                    }
                    totalWeigth = totalWeigth + weigth;
                    var tableWidth;
                    tableWidth= item.tableWidth;
                    if(maxWidth<=700){
                        if(!polar.isNull(item.miniTableWidth)){
                            tableWidth= item.miniTableWidth;
                        }
                    }
                    if(polar.isNull(tableWidth)){
                        if(weigth==0&&polar.isNull(tableWidth)){
                            item.weigth=1;
                            //未设置权重，默认权重为1
                            totalWeigth++;
                        }
                    }
                    if(!polar.isNull(tableWidth)){
                        lastWidth=lastWidth+tableWidth;
                    }
                    item.width=tableWidth;
            }

                var j=0;
                lastWidth = total - lastWidth;
                for (var i = 0; i < columns.length; i++) {
                    var item = columns[i];
                    var weigth = 0;
                    var tableWidth;
                    tableWidth= item.tableWidth;
                    if(maxWidth<=700){
                        if(!polar.isNull(item.miniTableWidth)){
                            tableWidth= item.miniTableWidth;
                        }
                    }
                    if (item.weigth != null && item.weigth != 'undefined'
                        && item.weigth != '') {
                        weigth = item.weigth;
                    }
                    var width=item.width;
                    if(polar.isNull(width)){
                        width=50;
                    }

                    if(lastWidth>0&&weigth>0){
                        width = parseInt(weigth * lastWidth / totalWeigth);
                        if(j==0){
                            //将剩余的余数分配到此处。
                            var yushu=weigth * lastWidth % totalWeigth;
                            width=width+yushu;
                        }
                        j++;
                    }

                    if (item.minWidth != null
                        && item.minWidth != 'undefined'
                        && item.minWidth != '') {
                        if (width < item.minWidth) {
                            width = item.minWidth;
                        }
                    }
                    if (item.maxWidth != null
                        && item.maxWidth != 'undefined'
                        && item.maxWidth != '') {
                        if (width > item.maxWidth) {
                            width = item.maxWidth;
                        }
                    }
                    if (px) {
                        width = width + "px";
                    }
                    item.width=width;
                }
        }
    };
    Table = function (columns, options, urls) {
        if (options != null) {
            this.options = options;
        }
        this.urls = urls;
        this.columns = columns;

    };
    Table.prototype.urls = {//访问的url
        listUrl: "",//列表的url
        addPage: "",//新增页面的url
        viewPage: "",//查看页面的url
        deleteSingle: "",//删除单条的url
        deleteMulit: "",//删除多条数据的url
        updatePage: "",//编辑页面的url
        updateField: "" //更新单个字段的url
    };
    Table.prototype.options = { //配置文件
        id: "content_table",//表编号
        outDivId: "tableListDiv",//最外层的div编号，用来重绘表格高度
        unionId: "id",//数据的唯一编号
        netIdKey: "id",//网络请求时，传入的主键编号
        netMulitKey: "ids",//网络请求时，一组主键编号的key
        name: "",//此模块的名称
        formWidth: '1000px',//表单宽度
        formHeight: '600px',//表单高度
        limits: [10, 20, 30, 50, 100]//页码数据
    };
    Table.prototype.refresh = function (obj) {//默认的刷新表方法
        this.tableIns.reloadPage(obj);
    };
    Table.prototype.destroy = function () {//默认的销毁表方法
        try {
            var that = this;
            that.options.isDestroy = true;
            that.tableIns.destroy();
        } catch (e) {

        }
    };
    Table.prototype.params = function (that, params) {//默认的查询参数
        var m;
        m = $("#" + that.options.outDivId+" .polar-list-form").serializeArray();
        var args = {};
        for (var p in m) {
            var va = m[p].value;
            if (va != null && va != 'undefined' && va != '') {
                args[m[p].name] = m[p].value;
            }
        }
        var rows = params.limit;
        var page = params.page;
        args["rows"] = rows;
        args["page"] = page;
        if (params.sort != null && params.sort != 'undefined') {
            args["sort"] = params.sort;
            args["order"] = params.order;
        }
       
        //同步更新至html代码，便于缓存时数据不丢失。
        $('#'+that.outDivId+" .polar-page").attr('value', page);
        $('#'+that.outDivId+" .polar-rows").attr('value', rows);
        if (that.onQuery != null && that.onQuery != 'undefined' && typeof that.onQuery === 'function') {
            args = that.onQuery(that, args);
        }
        return args;
    };

    Table.prototype.responseHandler = function (that, res) {//请求响应处理器
        if (res.code == polar.constants.success) {
            return {
                data: res.data,
                count: res.count,
                msg: res.msg,
                code: 0
            };
        } else if (polar.permission.logFilter(res)) {
            return {
                data: [],
                count: 0,
                msg: res.msg,
                code: 0
            };
        } else {
            return {
                data: [],
                count: 0,
                msg: res.msg,
                code: 1
            };
        }
    };

    Table.prototype.dataDone = function (that) {//数据加载完成的回调,用来绑定行内等
        //绑定行内详情按钮点击事件
        $("#" + that.options.outDivId).find("td .polar-detail-inner").bind("click", function () {
            var id = $(this).attr('polar-data');
            var data = {};
            data[that.options.netIdKey] = id;
            polar.layer.loadLayer(that.urls.viewPage, true,
                {
                    width: that.options.formWidth,
                    height: that.options.formHeight,
                    yesBtn: false,
                    title: "查看" + that.options.name,
                    clearForm: true
                }, data);
        });
        //绑定行内修改按钮点击事件
        $("#" + that.options.outDivId).find("td .polar-edit-inner").bind("click", function () {
            var id = $(this).attr('polar-data');
            var data = {};
            data[that.options.netIdKey] = id;
            polar.layer.loadLayer(that.urls.updatePage, true,
                {
                    width: that.options.formWidth,
                    height: that.options.formHeight,
                    yesContent: "修改",
                    yesBtn: true,
                    title: "修改" + that.options.name,
                    clearForm: true
                }, data);
        });
        //绑定行内删除按钮点击事件
        $("#" + that.options.outDivId).find("td .polar-delete-inner").bind("click", function () {
            var id = $(this).attr('polar-data');
            var data = {};
            data[that.options.netIdKey] = id;
            polar.dialog.confirm("提示", "删除此数据将会导致数据不可恢复，您确定要删除吗？", function () {
                polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, that.urls.deleteSingle, true, {refresh: true}, data);
            });
        });
    };
    Table.prototype.initDone = function (that) {//表格初始化完成的回调，用来绑定点击事件
        //新增的点击事件
        $("#" +  that.options.outDivId+" .polar-toolbar" + " .polar-add").click(function () {
            that.add(that);
        });
        //详情的点击事件
        $("#" + that.options.outDivId+" .polar-toolbar"+ " .polar-detail").click(function () {
            that.viewTable(that);
        });
        //修改的点击事件
        $("#" + that.options.outDivId+" .polar-toolbar"+ " .polar-edit").click(function () {
            that.updateTable(that);
        });
        //删除的点击事件
        $("#" + that.options.outDivId+" .polar-toolbar"+ " .polar-delete").click(function () {
            that.deleteTable(that);
        });
        //刷新的点击事件
        $("#" + that.options.outDivId+" .polar-toolbar" + " .polar-refresh").click(function () {
            that.refresh();
        });
        //重置的点击事件
        $("#" + that.options.outDivId+" .polar-toolbar" + " .polar-reset").click(function () {
            that.reSetTable(that);
        });
        //搜索的点击事件
        $("#" +that.options.outDivId+" .polar-toolbar" + " .polar-search").click(function () {
            var mPage = true;
            if (!polar.isNull(that.options.page)) {
                mPage = that.options.page;
            }
            if (mPage) {
                mPage ={page:{curr:1}} ;
            }
            that.refresh(mPage);
        });
        //导出excell点击事件
        $("#" + that.options.outDivId+" .polar-toolbar"+ " .polar-excell-export").click(function () {
            window.open(ctx + that.urls.exportExcell);
        });
        //导入模板点击事件
        $("#" + that.options.outDivId+" .polar-toolbar" + " .polar-excell-importModel").click(function () {
            window.open(ctx + that.urls.importExcellModel);
        });
        if ($("#" + that.options.outDivId+" .polar-toolbar"+ " .polar-excell-import") != null && $("#" + that.options.outDivId+" .polar-toolbar" + " .polar-excell-import") != 'undefined') {
            layui.upload.render({
                elem: $("#" + that.options.outDivId+" .polar-toolbar" + " .polar-excell-import")
                , url: ctx + that.urls.importExcell
                , accept: "file"
                , done: function (res, index, upload) {

                    polar.dialog.closeLoading();
                    if (res.code != polar.constants.success) {
                        if (!polar.permission.logFilter(res)) {
                            polar.dialog.alert("提示", res.msg);
                        }
                        return;
                    }
                    polar.dialog.alert("提示", res.msg);
                    that.refresh();
                }
                , before: function (obj) { //obj参数包含的信息，跟 choose回调完全一致，可参见上文。
                    polar.dialog.loading("导入中...");
                }
                , error: function () {
                    polar.dialog.closeLoading();
                    polar.dialog.alert("提示", "导入失败，请检查您的网络连接方式");
                }
                , progress: function (progress) {
                }
            });
        }

        layui.table.on('edit(' + that.options.id + ')', function (obj) {
            that.updateField(that, obj);
        });
        //监听排序事件
        layui.table.on('sort(' + that.options.id + ')', function (obj) {
            layui.table.reload(that.options.id, {
                initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。 layui 2.1.1 新增参数
                , where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                    sort: obj.field //排序字段
                    , order: obj.type //排序方式
                }
            });
        });
    };
    Table.prototype.init = function (that,tmp) {//表格初始化方法
        that.reDrawColumns(that);
        var bodyHeight=document.body.clientHeight;
        var mHeight = bodyHeight-$("#" + that.options.outDivId).get(0).offsetHeight
            +$("#" + that.options.outDivId+" .polar-toolbar").get(0).offsetHeight
            +$("#" + that.options.outDivId+" .polar-list-form").get(0).offsetHeight+25;
        mHeight = 'full-' + mHeight;
        if (!polar.isNull(that.options.height)) {
            mHeight = that.options.height;
        }
        var mPage = true;
        if (!polar.isNull(that.options.page)) {
            mPage = that.options.page;
        }
        if (mPage) {
            mPage = {curr: $('#'+that.outDivId+" .polar-page").val()};
        }
        that.tableIns = layui.table.render({
            elem: '#' + that.options.id
            , height: mHeight //高度
            , cols: that.columns //列属性
            , url: ctx + that.urls.listUrl
            , page: mPage //开启分页
            , loading: true
            , limits: that.options.limits
            , limit: $("#rows").val()
            , id: that.options.id
            , method: 'post'
            , queryParams: function (params) {
                return that.params(that, params);
            }
            , responseHandler: function (res) {
                return that.responseHandler(that, res);
            }
            //数据加载完成的回调
            , done: function (res, curr, count) {
                that.dataDone(that);
                if (that.onDataDone != null && that.onDataDone != 'undefined' && typeof that.onDataDone === 'function') {
                    //回调定义的方法
                    that.onDataDone(that);
                }
            }
//				  //单元格编辑响应器
//				  ,onEdit: function(obj){
//					  that.updateField(that,obj);
//				 }
        });
        that.initDone(that);
        if (that.onInitDone != null && that.onInitDone != 'undefined' && typeof that.onInitDone === 'function') {
            //回调定义的方法
            that.onInitDone(that);
        }
        //当前需要保存的表单置入全局变量
        polar.tab.currentForm = $("#" + that.options.outDivId);
        if(polar.isNull(tmp)){
            //当前的表
            polar.table.target = that;
        }else{
            polar.table.targetSecondTable = that;
        }
        var filter=that.options.formFilter;
        layui.form.render(null, filter); //更新全部
        if(!polar.isNull(tmp)){
            window.setTimeout(function () {
                if(! that.options.isDestroy ){
                    that.refresh();
                }

            }, 200);
        }
    };
    Table.prototype.reSetTable = function (that) {//默认的重置搜索表单的方法

        $("#" +that.options.outDivId+" .polar-list-form")[0].reset();
        $("#" +that.options.outDivId+" .polar-list-form" + " select[cache='true']").each(function (index) {
            $(this).val('');
            //保存select的值
            $(this).find('option').each(function (index) {
                $(this).removeAttr('selected');
            });
        });
        $("#" +that.options.outDivId+" .polar-list-form"+ " input[cache='true']").each(function (index) {
            if ($(this).attr('type') != 'hidden') {
                $(this).val('');
            }
        });
        $(".polar-province input").each(function (index) {
            var m = $(this);
            m.removeAttr('province');
            m.removeAttr('city');
            m.removeAttr('area');
            m.val('');
        });
        if (that.onReset != null && that.onReset != 'undefined' && typeof that.options.onReset === 'function') {
            that.onReset(that);
        }
        var mPage = true;
        if (!polar.isNull(that.options.page)) {
            mPage = that.options.page;
        }
        if (mPage) {
            mPage ={page:{curr:1}} ;
        }
        this.refresh(mPage);
    };
    Table.prototype.reDrawColumns = function (that) {//默认的重置列属性的方法
        var width = $("#" + that.options.outDivId).get(0).offsetWidth;
        polar.table.calcTableColumns(width, that.columns[0], false);
    };
    Table.prototype.resizeTable = function () {
        var that = this;

        if (!polar.isNull(that.options.isDestroy) && that.options.isDestroy) {
            return;
        }

        this.reDrawColumns(that);
        var mHeight = $("#" + that.options.outDivId+" .polar-toolbar").get(0).offsetHeight + $("#" +that.options.outDivId+" .polar-list-form").get(0).offsetHeight + 175;
        mHeight = 'full-' + mHeight;
        if (!polar.isNull(that.options.height)) {
            mHeight = that.options.height;
        }
        if (!polar.isNull(that.reloadId)) {
            clearTimeout(that.reloadId);
        }
        that.reloadId = window.setTimeout(function () {
            layui.table.reload(that.options.id, {cols: that.columns, height: mHeight});
        }, 1000);

        //setTimeout("layui.table.reload(that.options.id, {cols:that.columns,height:mHeight})",1000);
        //layui.table.reload(that.options.id, {cols:that.columns,height:mHeight});
    };
    Table.prototype.getSelection = function (that) {//获取选中行的方法
        var arrselections = layui.table.checkStatus(that.options.id).data;
        return arrselections;
    };
    Table.prototype.add = function (that) {//打开新增表单
        polar.layer.loadLayer(that.urls.addPage, true,
            {
                width: that.options.formWidth,
                height: that.options.formHeight,
                yesBtn: true,
                title: "新增" + that.options.name,
                clearForm: true,
                yesContent: "添加"
            }, null);
    };
    Table.prototype.deleteTable = function (that) {//删除多条数据
        var arrselections = that.getSelection(that);
        if (arrselections.length == 0) {
            polar.dialog.alert('提示', '请选择一条数据');
        } else {
            polar.dialog.confirm("提示", "删除此数据将会导致数据不可恢复，您确定要删除吗？", function () {
                var ids = [];
                var data = {};
                for (var i = 0; i < arrselections.length; i++) {
                    ids.push(arrselections[i][that.options.unionId]);
                }
                data[that.options.netMulitKey] = ids;
                polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, that.urls.deleteMulit, true, {refresh: true}, data);
            });
        }
    };
    Table.prototype.deleteTableById = function (that, id) {//删除一条数据
        var data = {};
        data[that.options.netIdKey] = id;
        polar.dialog.confirm("提示", "删除此数据将会导致数据不可恢复，您确定要删除吗？", function () {
            polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, that.urls.deleteSingle, true, {refresh: true}, data);
        });
    };
    Table.prototype.updateTable = function (that) {//打开修改的页面
        var arrselections = that.getSelection(that);
        if (arrselections.length != 1) {
            polar.dialog.alert('提示', '请选择一条数据');
        } else {
            var data = {};
            data[that.options.unionId] = arrselections[0][that.options.unionId];
            polar.layer.loadLayer(that.urls.updatePage, true,
                {
                    width: that.options.formWidth,
                    height: that.options.formHeight,
                    yesContent: "修改",
                    yesBtn: true,
                    title: "修改" + that.options.name,
                    clearForm: true
                }, data);
        }
    };
    Table.prototype.updateField = function (that, obj) { //更新字段
        var data = obj.data;
        var field = obj.field;
        var value = data[field];
        var oldValue = obj.oldValue;

        if (that.validate(that, field, value)) {
            var args = {};
            args[field] = value;
            args.fieldName = field;
            args[that.options.netIdKey] = data[that.options.unionId];
            var successCall = function (contentType, url, loading, options, data) {
                if (loading) {
                    polar.dialog.closeLoading();
                }
                data = JSON.parse(data);
                if (data.code != polar.constants.success) {
                    if (!polar.permission.logFilter(data)) {
                        polar.dialog.alert("提示", data.msg);
                        //同步更新表格和缓存对应的值
                        var arg = {};
                        arg[field] = oldValue;
                        obj.update(arg);
                    }
                } else {
                    polar.dialog.toast(data.msg);

                }
            };
            var jsonError = function (XMLHttpRequest, textStatus, errorThrown, url, loading, options, data) {
                if (loading) {
                    polar.dialog.closeLoading();
                }
                polar.dialog.alert('提示', "网络异常，请检查您的网络连接方式.");
                var arg = {};
                arg[field] = oldValue;
                obj.update(arg);
            }
            polar.loader.load(successCall, jsonError, that.urls.updateField, true, null, args);
        } else {
            //同步更新表格和缓存对应的值
            var arg = {};
            arg[field] = oldValue;
            obj.update(arg);
        }
//	      layer.prompt({
//	        formType: 2
//	        ,title: '修改属性'
//	        ,value: ""+(polar.isNull(value)?"":value)
//	      }, function(value, index){
//	    	  if(that.validate(that,field,value)){
//	    		  layer.close(index);
//	  	        var args = {};
//	  			args[field] = value;
//	  			args[that.options.netIdKey] = data[that.options.unionId];
//	  			var successCall = function(contentType,url, loading,options, data){
//	  				if (loading) {
//	  					polar.dialog.closeLoading();
//	  				}
//	  				data = JSON.parse(data);
//	  				if (data.code != polar.constants.success) {
//	  					if(! polar.permission.logFilter(data)){
//	  						polar.dialog.alert("提示", data.msg);
//	  					}
//	  				} else {
//	  					polar.dialog.toast(data.msg);
//	  					 //同步更新表格和缓存对应的值
//	  			        var arg={};
//	  			        arg[field]=value;
//	  			        obj.update(arg);
//	  				}
//	  			};
//	  			polar.loader.load(successCall, polar.loader.jsonError, that.urls.updateField, true, null, args);
//	    	  }
//	      });
    };
    Table.prototype.validate = function (that, field, value) { //更新字段时调用的校验方法
        return true;
    };
    Table.prototype.viewTable = function (that) {
        var arrselections = that.getSelection(that);
        if (arrselections.length != 1) {
            polar.dialog.alert('提示', '请选择一条数据');
        } else {
            var data = {};
            data[that.options.netIdKey] = arrselections[0][that.options.unionId];
            polar.layer.loadLayer(that.urls.viewPage, true,
                {
                    width: that.options.formWidth,
                    height: that.options.formHeight,
                    yesBtn: false,
                    title: "查看" + that.options.name,
                    clearForm: true
                }, data);
        }
    };

    polar.table = table;
    polar.table.layui = function (columns, options, urls) {
        var table = new Table(columns, options, urls);
        table.refresh = function (obj) {
            layui.table.reload(this.options.id,polar.isNull(obj)?{}:obj);
        };
        return table;
    }
    polar.table.tree = function (columns, options, urls) {
        var table = new Table(columns, options, urls);
        table.reDrawColumns = function (that) {//默认的重置列属性的方法
            var width = $("#" + that.options.outDivId).get(0).offsetWidth;
            polar.table.calcTableColumns(width, that.columns[0], true);
        };
        table.init = function (that) {
            that.reDrawColumns(that);
            var height = $("#" + that.options.outDivId).get(0).offsetHeight -
                $("#" +  that.options.outDivId+" .polar-toolbar").get(0).offsetHeight
                - $("#" +that.options.outDivId+" .polar-list-form").get(0).offsetHeight;
            $('#' + that.options.id).parent().height(height);
            if (!polar.isNull(that.options.height)) {
                height = that.options.height;
            }
            that.sort = function (mthat, data) {
                var result = [];
                var parentIdField = that.options.parentId;
                var idField = that.options.childId;
                if(polar.isNull(idField)){
                    idField=that.options.unionId;
                }
                for (var i = 0; i < data.data.length; i++) {
                    var tmp = data.data[i];
                    var parentId = tmp[parentIdField];
                    //添加一级目录
                    if (polar.isNull(parentId)) {
                        result.push(tmp);
                        that.addChildren(that, result, data.data, tmp[idField]);
                    }
                }
                data.data = result;
                return data;
            };
            that.addChildren = function (that, result, data, id) {
                var idField = that.options.childId;
                if(polar.isNull(idField)){
                    idField=that.options.unionId;
                }
                for (var i = 0; i < data.length; i++) {
                    if (data[i][that.options.parentId] == id) {
                        result.push(data[i]);
                        that.addChildren(that, result, data, data[i][idField]);
                    }
                }
            }

            that.success = function (contentType, url, loading, options, data) {
                layui.layer.close(options.closeIndex);
                data = JSON.parse(data);
                var idField = that.options.childId;
                if(polar.isNull(idField)){
                    idField=that.options.unionId;
                }
                if (data.code != polar.constants.success) {
                    if (!polar.permission.logFilter(data)) {
                        polar.dialog.alert("提示", data.msg);
                    }
                } else {
                    //开始处理数据...
                    var obj = $("#" + that.options.id + " tbody");
                    var str1 = '';
                    data = that.sort(that, data);
                    for (var i = 0; i < data.data.length; i++) {
                        var item1 = data.data[i];
                        var str = '<tr data-tt-id="' + item1[idField] + '" data-tt-parent-id="' + item1[that.options.parentId] + '" >';
                        for (var j = 0; j < that.columns[0].length; j++) {
                            var item = that.columns[0][j];
                            var name = item.title;
                            var value = item1[item.field];
                            if (!polar.isNull(item.formatter)) {
                                value = item.formatter(item1, that.options);
                            }
                            if (polar.isNull(value)) {
                                value = "";
                            }
                            str = str + '<td class="td-nobr">' + value + '</td>';
                        }
                        str = str + '</tr>';
                        str1 = str1 + str;
                    }
                    obj.html(str1);
                    var options2 = {
                        expandable: true,
                        expanderTemplate: '<li class="fa"></li> ',//展开按钮的HTML片段
                        indenterTemplate: '<span class="indenter"></span>',//折叠按钮的HTML片段
                        stringCollapse: "折叠",//折叠按钮的title,国际化使用。
                        stringExpand: "展开",//展开按钮的title,国际化使用。
                        column: 0
                    };
                    $("#" + that.options.id).treetable(options2, true);
                    that.dataDone(that);
                    if (that.onDataDone != null && that.onDataDone != 'undefined' && typeof that.onDataDone === 'function') {
                        //回调定义的方法
                        that.onDataDone(that);
                    }

                }
            };
            that.error = function (XMLHttpRequest, textStatus, errorThrown, url, loading, options, data) {
                layui.layer.close(options.closeIndex);
                polar.dialog.alert('提示', "网络异常，请检查您的网络连接方式.");
            };
            that.tableIns = {
                resize: function (obj) {

                    $('#' + that.options.id).parent().height(obj.height);
                    var columns = obj.cols;
                    var obj = $('#' + that.options.id);
                    var index = 0;
                    obj.find('th').each(
                        function () {
                            var tr = $(this);
                            var width = columns[0][index].width;
                            tr.attr('width', width);
                            index++;
                        }
                    );

                }, destroy: function () {
                }, reloadPage: function () {
                    that.query(that);
                }
            };
            table.destroy = function () {
                try {
                    var that = this;
                    that.options.isDestroy = true;
                    that.tableIns.destroy();
                } catch (e) {

                }
            };
            table.realoadPage = function () {
                that.query(that);
            };

            table.resizeTable = function () {
                var that = this;
                if (!polar.isNull(that.options.isDestroy) && that.options.isDestroy) {
                    return;
                }
                var mHeight = $("#" + that.options.outDivId).get(0).offsetHeight
                    - $("#" +  that.options.outDivId+" .polar-toolbar").get(0).offsetHeight
                    - $("#" +that.options.outDivId+" .polar-list-form").get(0).offsetHeight - 33;
                that.reDrawColumns(that);
                $('#' + that.options.id).parent().height(mHeight);
                var columns = that.columns;
                var obj = $('#' + that.options.id);
                var index = 0;
                obj.find('th').each(
                    function () {
                        var tr = $(this);
                        var width = columns[0][index].width;
                        tr.attr('width', width);
                        index++;
                    }
                );
            };
            table.params = function (that, params) {
                if (that.onQuery != null && that.onQuery != 'undefined' && typeof that.onQuery === 'function') {
                    params = that.onQuery(that, params);
                }
                return params;
            }
            that.query = function (that) {
                var index = layer.load(1, {
                    shade: [0.1, '#fff'] //0.1透明度的白色背景
                });
                var params = {};
                params = that.params(that, params);
                polar.loader.load(that.success, that.error, that.urls.listUrl, false, {closeIndex: index}, params);
            };
            //开始写出表头....
            var obj = $("#" + that.options.id);
            obj.html('');
            var str = '<thead><tr>';
            for (var i = 0; i < that.columns[0].length; i++) {
                var item = that.columns[0][i];
                var name = item.title;
                str = str + '<th width="' + item.width + '">' + name + '</th>';
            }
            str = str + '</tr></thead><tbody></tbody>';
            obj.html(str);

            that.initDone(that);
            if (that.onInitDone != null && that.onInitDone != 'undefined' && typeof that.onInitDone === 'function') {
                //回调定义的方法
                that.onInitDone(that);
            }
            //当前需要保存的表单置入全局变量
            polar.tab.currentForm = $("#" + that.options.outDivId);
            //当前的表
            polar.table.target = that;
            var filter=that.options.formFilter;
            layui.form.render(null,filter); //更新全部

            that.query(that);
        }
        return table;
    }
    polar.table.boot = function (columns, options, urls) {
        var table = new Table(columns, options, urls);
        table.getSelection = function (that) {//获取选中行的方法
            var arrselections = $("#" + that.options.id).bootstrapTable('getSelections');
            return arrselections;
        };
        table.refresh = function () {
            var that = this;
            $("#" + that.options.id).bootstrapTable('refresh');
        };
        table.reDrawColumns = function (that) {
            var width = $("#" + that.options.outDivId).get(0).offsetWidth ;
            polar.table.calcTableColumns(width, this.columns, true);
        };
        table.resizeTable = function () {
            var that = this;
            var mHeight = $("#" + that.options.outDivId).get(0).offsetHeight
                - $("#" +  that.options.outDivId+" .polar-toolbar").get(0).offsetHeight
                - $("#" +that.options.outDivId+" .polar-list-form").get(0).offsetHeight - 33;
            that.reDrawColumns(that);
            if (!polar.isNull(that.options.height)) {
                mHeight = that.options.height;
            }
            $("#" + that.options.id).bootstrapTable("refreshOptions", {columns: that.columns});
            $("#" + that.options.id).bootstrapTable("resetView", {
                height: mHeight
            });
        };
        table.destroy = function () {
            $("#" + this.options.id).bootstrapTable('destroy');
        };
        table.responseHandler = function (that, res) {
            if (res.code == polar.constants.success) {
                return {
                    "rows": res.data,
                    "total": res.count
                };
            } else if (polar.permission.logFilter(res)) {

            } else {
                polar.dialog.toast(res.msg);
                return {
                    "rows": [],
                    "total": 0
                };
            }
        }
        table.params = function (that, params) {
            var m;
            m = $("#" +that.options.id+" .polar-list-form").serializeArray();
            var args = {};
            for (var p in m) {
                var va = m[p].value;
                if (va != null && va != 'undefined' && va != '') {
                    args[m[p].name] = m[p].value;
                }
            }
            var rows = params.limit;
            var page = (params.offset / rows) + 1;
            args["rows"] = rows;
            args["page"] = page;
            if (params.sort != null && params.sort != 'undefined') {
                args["sort"] = params.sort;
                args["order"] = params.order;
            }
            //同步更新至html代码，便于缓存时数据不丢失。
            $('#'+that.outDivId+" .polar-page").attr('value', page);
            $('#'+that.outDivId+" .polar-rows").attr('value', rows);
            if (that.onQuery != null && that.onQuery != 'undefined' && typeof that.onQuery === 'function') {
                args = that.onQuery(that, args);
            }
            return args;
        }
        table.updateField = function (that, field, row, oldValue, $el) {
            var args = {};
            var eValue = eval('row.' + field);
            args[field] = eValue;
            args.fieldName = field;
            args[that.options.netIdKey] = row[that.options.unionId];
            var mRows = {};
            if (!that.validate(that, field, args[that.options.netIdKey])) {
                return;
            }
            mRows[field] = oldValue;
            var errorCall = function (contentType, url, loading, options, data) {
                if (loading) {
                    polar.dialog.loadFinish();
                }
                polar.dialog.alert('提示', "网络异常，请检查您的网络连接方式.");
                $el.html(oldValue);
                $('#' + that.options.id).bootstrapTable('updateRow', {
                    index: $el.parent().parent().attr('data-index'),
                    row: mRows
                });
            }
            polar.loader.load(polar.loader.jsonSuccess, errorCall, that.urls.updateField, true, null, args);
        }
        table.init = function (that,tmp) {
            this.reDrawColumns(that);
            var page = $('#'+that.outDivId+" .polar-page").val();
            var rows = $('#'+that.outDivId+" .polar-rows").val();
            var mHeight = $("#" + that.options.outDivId).get(0).offsetHeight
                - $("#" +  that.options.outDivId+" .polar-toolbar").get(0).offsetHeight
                - $("#" +that.options.outDivId+" .polar-list-form").get(0).offsetHeight - 33;

            if (!polar.isNull(that.options.height)) {
                mHeight = that.options.height;
            }
            $('#' + that.options.id).bootstrapTable({
                height: mHeight,
                url: ctx + that.urls.listUrl, // 请求后台的URL（*）
                contentType: "application/x-www-form-urlencoded",// 加上此头文件，防止post访问不到数据
                method: 'post', // 请求方式（*）
                dataType: "json",
                striped: true, // 是否显示行间隔色
                cache: false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true, // 是否显示分页（*）
                sortable: true, // 是否启用排序
                sortOrder: "asc", // 排序方式
                queryParams: function (params) {
                    return that.params(that, params);
                },
                // 传递参数（*）
                sidePagination: "server", // 分页方式：client客户端分页，server服务端分页（*）
                pageNumber: page, // 初始化加载第一页，默认第一页
                pageSize: rows, // 每页的记录行数（*）
                pageList: that.options.limits, // 可供选择的每页的行数（*）
                search: false, // 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
                strictSearch: true,
                showColumns: false, // 是否显示所有的列
                showRefresh: false, // 是否显示刷新按钮
                minimumCountColumns: 2, // 最少允许的列数
                clickToSelect: true, // 是否启用点击选中行
                uniqueId: that.options.unionId, // 每一行的唯一标识，一般为主键列
                showToggle: false, // 是否显示详细视图和列表视图的切换按钮
                cardView: false, // 是否显示详细视图
                detailView: false, // 是否显示父子表
                responseHandler: function (res) {
                    return that.responseHandler(that, res);
                },
                paginationPreText: '上一页',
                paginationNextText: '下一页',
                paginationLoop: false,//设置为 true 启用分页条无限循环的功能
                onEditableSave: function (field, row, oldValue, $el) {
                    that.updateField(that, field, row, oldValue, $el);
                }
                , columns: that.columns
                , onPostBody: function () {
                    that.dataDone(that);
                    if (that.onDataDone != null && that.onDataDone != 'undefined' && typeof that.onDataDone === 'function') {
                        //回调定义的方法
                        that.onDataDone(that);
                    }
                }
            });
            that.initDone(that);
            if (that.onInitDone != null && that.onInitDone != 'undefined' && typeof that.onInitDone === 'function') {
                //回调定义的方法
                that.onInitDone(that);
            }
            //当前需要保存的表单置入全局变量
            polar.tab.currentForm = $("#" + that.options.outDivId);
            if(polar.isNull(tmp)){
                //当前的表
                polar.table.target = that;
            }else{
                polar.table.targetSecondTable = that;
            }
            var filter=that.options.formFilter;
            layui.form.render(null, filter); //更新全部

        }
        return table;
    }



    StaticTable = function (options,urls,columns,data) {
        this.options = options;
        this.urls=urls;
        this.columns=columns;
        this.data=data;
    };

    StaticTable.prototype.options={
        toolbar:null,//工具条的dom对象
        table:null,//表格的dom对象
        formWidth:"1000px",//页面宽度
        formHeight:"800px",//页面高度
        listName:"list",//列表name
        formFilter:"childForm",//外面form的filter属性
        unionId:"id",//数据唯一标识
    }
    StaticTable.prototype.columns=[];

    StaticTable.prototype.urls={
        addUrl:"",//添加页面的url
        detailUrl:"",//详情页面的url
        updateUrl:""//修改页面的url
    }
    StaticTable.prototype.deleteRow=function(id){
        if(polar.isArray(id)){
            for(var j=0;j<id.length;j++){
                for (var i = 0;i<this.data.length;i++) {
                    if(this.data[i][this.options.unionId]==id[j]){
                        this.data.splice(i, 1);
                    }
                }
            }
        }else{
            for (var i = 0;i<this.data.length;i++) {
                if(this.data[i][this.options.unionId]==id){
                    this.data.splice(i, 1);
                }
            }
        }
        this.renderData();
    };
    StaticTable.prototype.addRow=function(row){
        if(polar.isNull(row[this.options.unionId])){
            //编号为空
            row[this.options.unionId]=polar.uuid();
        }
        this.data.push(row);
        this.renderData();
    };
    StaticTable.prototype.updateRow=function(row){
        for(var i=0;i<this.data.length;i++){
            if(this.data[i][this.options.unionId]==row[this.options.unionId]){
                this.data[i]=row;
                break;
            }
        }
        this.init();
    };
    StaticTable.prototype.getRowById=function(id){
        for(var i=0;i<this.data.length;i++){
            if(this.data[i][this.options.unionId]==id){
                var datas=this.data[i];
                var pdata={};
                for(var key in datas){
                    var value=datas[key];
                    if(polar.isArray(value)){
                        for(var index=0;index<value.length;index++){
                            pdata[key+"["+index+"]"]=value[index];
                        }
                    }else{
                        pdata[key]=value;
                    }
                }
                return pdata;
            }
        }
        return null;
    };
    StaticTable.prototype.getSelectRow=function(){
        var selectes=[];
        var that=this;
        this.options.table.find('input.select-item').each(
            function(index, item) {
                if (item.checked) {
                    var datas=that.data[$(this).attr("data-index")];
                    var pdata={};
                    for(var key in datas){
                        var value=datas[key];
                        if(polar.isArray(value)){
                          for(var index=0;index<value.length;index++){
                              pdata[key+"["+index+"]"]=value[index];
                          }
                        }else{
                            pdata[key]=value;
                        }
                    }
                    selectes.push(pdata) ;
                }
            });
        return selectes;
    };
    StaticTable.prototype.init=function () {
        var dom=this.options.table,columns=this.columns;
        polar.table.calcTableColumns(dom.parent().get(0).offsetWidth,columns,true);
        var total=0;
        for(var i=0;i<columns.length;i++){
            var width=columns[i].width;
            if(width.indexOf("px")!=-1){
                width=parseInt(width.replace("px",""));
            }
            total=total+width;
        }
        dom.attr("style","width:"+total+"px");
        dom.html('');
        var allTrs='<tbody>';
        var strWidth='<colgroup><col width="50"/>';
        var strTitle='<thead><tr><th><input type="checkbox" class="select-title" lay-filter="'+this.options.id+'_polar-check-all" lay-skin="primary"/></th>';
        for(var i=1;i<columns.length;i++){
            var title=columns[i].title;
            strTitle=strTitle+'<th>'+title+'</th>';
            strWidth=strWidth+'<col width="'+columns[i].width+'"/>';
        }
        strWidth=strWidth+'</colgroup>';
        strTitle=strTitle+'</tr></thead>';
        dom.html(strWidth+strTitle);
        this.onInitDone();
        this.renderData();
    }
    //渲染数据
    StaticTable.prototype.renderData=function (){
        var dom=this.options.table,data=this.data,columns=this.columns,unionId=this.options.unionId;
        var listName=this.options.listName;
        dom.find('tbody').remove();
        var allTrs='<tbody>';
        for(var i=0;i<data.length;i++){
            var item=data[i];
            var hiddenText='';
            for(var key in data[i]){
                var value=item[key];
                var name=key;
                if(!polar.isNull(value)){
                    if(!polar.isNull(listName)){
                        name=listName+'['+i+'].'+name;
                    }
                    hiddenText=hiddenText+'<input type="hidden" name="'+name+'"  value="'+value+'" />';
                }
            }
            var str='<tr ><td>'+hiddenText+'<input type="checkbox" class="select-item"  data-index="'+i+'" lay-skin="primary"/></td>';
            for(var j=1;j<columns.length;j++){
                var column=columns[j];
                var field=column.field;
                var value=item[field];
                if(!polar.isNull(column.formatter)){
                    value=column.formatter(item,null);
                }
                if(polar.isNull(value)){
                    value="";
                }
                str=str+'<td>'+value+'</td>';
            }
            str=str+'</tr>';
            allTrs=allTrs+str;
        }
        allTrs=allTrs+'</tbody>'
        dom.append(allTrs);
        var that =this;
        that.onRenderDataDone();
    }
    StaticTable.prototype.onInitDone=function (){
        var that=this;
        that.options.toolbar.find(".polar-child-add-row").bind('click',function(){
            polar.layer.loadLayer(that.urls.addUrl, true,
                {
                    width: that.options.formWidth,
                    height: that.options.formHeight,
                    yesContent: "新增",
                    yesBtn: true,
                    title: "新增" + that.options.name,
                    clearForm: false,
                    yesCall:function(index, layero){
                        var row=polar.form.tmp.submit(index);
                        if(row!=null){
                            that.addRow(row);
                        }
                    }
                }, null);
        });
        that.options.toolbar.find(".polar-child-delete-row").bind('click',function(){
            var rows=that.getSelectRow();
            if(rows.length==0){
                polar.dialog.alert("提示", "请选择至少一条数据");
            }else{
                var ids=[];
                for(var index=0;index<rows.length;index++){
                    ids.push(rows[index][that.options.unionId]);
                }
                that.deleteRow(ids);
            }

        });
        layui.form.on('checkbox('+that.options.id+'_polar-check-all)', function(data){
            that.options.table.find(".select-item").attr("checked",data.elem.checked);
            layui.form.render("checkbox",that.options.formFilter);
        });
    }
    StaticTable.prototype.onRenderDataDone=function (){
        var that=this;
        //绑定行内事件
        that.options.table.find(".polar-detail-child-delete-inner").bind('click',function(){
            var id=$(this).attr("polar-data");
            that.deleteRow(id);
        });
        that.options.table.find(".polar-detail-child-edit-inner").bind('click',function(){
            var id=$(this).attr("polar-data");
            var row=that.getRowById(id);
            polar.layer.loadLayer(that.urls.updateUrl, true,
                {
                    width: that.options.formWidth,
                    height: that.options.formHeight,
                    yesContent: "修改",
                    yesBtn: true,
                    title: "修改" + that.options.name,
                    clearForm: false,
                    yesCall:function(index, layero){
                        var row=polar.form.tmp.submit(index);
                        if(row!=null){
                            that.updateRow(row);
                        }
                    }
                }, row);
        });
        that.options.table.find(".polar-detail-child-detail-inner").bind('click',function(){
            var id=$(this).attr("polar-data");
            var row=that.getRowById(id);
            polar.layer.loadLayer(that.urls.detailUrl, true,
                {
                    width: that.options.formWidth,
                    height: that.options.formHeight,
                    yesBtn: false,
                    title: "查看" + that.options.name,
                    clearForm: false
                }, row);
        });
        layui.form.render(null,this.options.formFilter);
    }
    polar.table.staticTable = function (options,urls,columns,data) {
        var table = new StaticTable(options,urls,columns,data);
        return table;
    }

});
$(function () {
    // 定义省市区
    var province = {
        changeOption: function (ele, data, parentPosition, selectedPosition,
                                hid) {
            if (data == null) {
                return;
            }
            for (var position = 0; position < data.length; position++) {
                var obj = data[position];
                var str;
                if (selectedPosition != -1 && selectedPosition == position) {
                    if (parentPosition == null) {
                        // 一级目录，修改其province
                        hid.attr('province', obj.text);
                    } else if (parentPosition.indexOf(',') == -1) {
                        // 二级目录，修改其city
                        hid.attr('city', obj.text);
                    } else {
                        // 三级目录，修改其area
                        hid.attr('area', obj.text);
                    }
                    hid.val(obj.value);
                    str = '<option value="'
                        + obj.value
                        + ','
                        + (parentPosition == null ? ''
                            : (parentPosition + ',')) + position
                        + '" selected="selected">' + obj.text + '</option>';
                } else {
                    str = '<option value="'
                        + obj.value
                        + ','
                        + (parentPosition == null ? ''
                            : (parentPosition + ',')) + position + '">'
                        + obj.text + '</option>';
                }
                ele.append(str);
            }
        },
        clearProvince: function (name) {
            var hid = $('input[name="' + name + '"]');
            hid.removeAttr('province');
            hid.removeAttr('city');
            hid.removeAttr('area');
            hid.val('');
            this.proviceSelect(name);
        },
        clearInput: function (ele, attr) {
            ele.removeAttr(attr);
        },
        clearSelect: function (ele) {
            ele.html('');
            ele.append('<option value="">请选择</option>');
        },
        initProvince: function (form, pr, ct, area, hid, name, mCls) {
            var that = this;
            form.on('select(' + mCls + '_province)', function (data) {
                if (data.value.length == 0) {
                    that.clearSelect(ct);
                    that.clearSelect(area);
                    that.clearInput(hid, 'city');
                    that.clearInput(hid, 'area');
                    that.clearInput(hid, 'province');
                    hid.val('');
                    form.render();
                    return;
                }
                var position = data.value.split(",")[1];
                var obj = cityData3[position];
                that.clearSelect(ct);
                that.clearSelect(area);
                that.clearInput(hid, 'city');
                that.clearInput(hid, 'area');
                that.changeOption(ct, obj.children, position, -1, hid);
                var text = obj.text;
                hid.val(data.value.split(",")[0]);
                hid.attr('province', text);
                form.render();
            });
            form.on('select(' + mCls + '_city)', function (data) {
                if (data.value.length == 0) {
                    that.clearSelect(area);
                    that.clearInput(hid, 'area');
                    that.clearInput(hid, 'city');
                    var mValue = hid.val();
                    mValue = mValue.substring(0, 2) + "0000";
                    hid.val(mValue);
                    form.render();
                    return;
                }
                var position1 = data.value.split(",")[1];
                var position2 = data.value.split(",")[2];
                var obj = cityData3[position1].children[position2];
                that.clearSelect(area);
                that.clearInput(hid, 'area');
                that.changeOption(area, obj.children, position1 + ','
                    + position2, -1, hid);
                var text = obj.text;
                hid.val(data.value.split(",")[0]);
                hid.attr('city', text);
                form.render();
            });
            form.on('select(' + mCls + '_area)',
                function (data) {
                    if (data.value.length == 0) {
                        var mValue = hid.val();
                        mValue = mValue.substring(0, 4) + "00";
                        hid.val(mValue);
                        that.clearInput(hid, 'area');
                        form.render();
                        return;
                    }
                    var position1 = data.value.split(",")[1];
                    var position2 = data.value.split(",")[2];
                    var position3 = data.value.split(",")[3];
                    var obj = cityData3[position1].children[position2].children[position3];
                    var text = obj.text;
                    hid.val(data.value.split(",")[0]);
                    hid.attr('area', text);
                    form.render();
                });

        },
        proviceSelect: function (name, mCls) {
            var form = layui.form; // 只有执行了这一步，部分表单元素才会修饰成功
            var pr = $('.' + mCls + ' select[lay-filter="' + mCls + '_province"]');
            var ct = $('.' + mCls + ' select[lay-filter="' + mCls + '_city"]');
            var area = $('.' + mCls + ' select[lay-filter="' + mCls + '_area"]');
            var hid = $('.' + mCls + ' input[name="' + name + '"]');
            var val = hid.val();
            this.clearSelect(pr);
            this.clearSelect(ct);
            this.clearSelect(area);
            this.initProvince(form, pr, ct, area, hid, name, mCls);
            if (val != null && val != 'undefined' && val != '') {
                var obj1 = cityData3;
                var obj2 = null;
                var obj3 = null;
                var position1 = -1;
                var position2 = -1;
                var position3 = -1;
                var id2 = null;
                var id3 = null;
                var val1 = val.substring(0, 2);
                var val2 = val.substring(2, 4);
                var val3 = val.substring(4, 6);
                for (var position = 0; position < cityData3.length; position++) {
                    var tmp = cityData3[position];
                    var tmpValue = tmp.value.substring(0, 2);
                    if (val1 == tmpValue) {
                        position1 = position;
                        obj2 = tmp.children;
                    }
                }
                if (val2 != "00" && obj2 != null && position1 != -1) {
                    for (var position = 0; position < obj2.length; position++) {
                        var tmp = obj2[position];
                        var tmpValue = tmp.value.substring(2, 4);
                        if (val2 == tmpValue) {
                            position2 = position;
                            obj3 = tmp.children;
                        }
                    }
                }
                if (val3 != "00" && obj3 != null && position2 != -1) {
                    for (var position = 0; position < obj3.length; position++) {
                        var tmp = obj3[position];
                        var tmpValue = tmp.value.substring(4, 6);
                        if (val3 == tmpValue) {
                            position3 = position;
                        }
                    }
                }
                if (position1 != -1) {
                    id2 = position1 + '';
                    if (position2 != -1) {
                        id3 = position1 + "," + position2;
                    }
                }
                this.changeOption(pr, obj1, null, position1, hid);
                this.changeOption(ct, obj2, id2, position2, hid);
                this.changeOption(area, obj3, id3, position3, hid);
            } else {
                this.changeOption(pr, cityData3, null, -1, hid);
            }
            form.render();
        }
    };
    polar.province = province;
});
/**
 * 定义树结构的方法
 */
$(function () {
    // 定义tree
    var tree = {
        //将数据组装成树结构
        init: function (data) {
            var resultData = [];
            var firstNode;
            var secondNode;
            for (var position = 0; position < data.length; position++) {
                var temp = data[position];
                if (temp.value.indexOf("0000") != -1) {
                    // 为一级目录
                    firstNode = temp;
                    resultData.push(firstNode);
                    continue;
                }
                if (temp.value.indexOf("00") != -1) {
                    secondNode = temp;
                    //为二级目录
                    if (polar.isNull(firstNode.children)) {
                        firstNode.children = [];
                    }
                    firstNode.children.push(secondNode);
                    continue;
                }
                if (polar.isNull(secondNode.children)) {
                    secondNode.children = [];
                }
                secondNode.children.push(temp);
            }
            return resultData;
        }
    }
    polar.tree = tree;
});
// 定义数据回显策略
$(function () {
    var ehco = {
        cacheDatas: {},
        cache: function (groupId, values) {
            polar.ehco.cacheDatas[groupId] = JSON.parse(values);
            ;
        },
        ehcoData: function (groupId, value) {
            var returnValue = "";
            if (!polar.isNull(polar.ehco.cacheDatas[groupId])) {
                var data = polar.ehco.cacheDatas[groupId];
                for (var i = 0; i < data.length; i++) {
                    if(value=data.value){
                        returnValue=data.text;
                        break;
                    }
                }
            }
            return returnValue;
        }
    }
    polar.ehco = ehco;
});