<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/view/includes/tag.jsp"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<title>PolarLoves</title>
<%@ include file="/view/includes/FrameWorks.jsp"%>
<meta name="keywords" content="极地框架">
<meta name="description" content="愿天下有情人同父异母">
<script type="text/javascript">
	//公共配置
	$(document).ready(function() {
		//initCommon();
		polar.init(function() {
			polar.tab.init();
			$(".logOut").click(function() {
				var success=function(contentType,url, loading,options, data){
					window.location.href=ctx+polar.constants.logInPage; 
				};
				polar.loader.load(success, polar.loader.jsonError, polar.constants.logOutUrl, true, null, null);
			});
            var maxWidth=document.body.clientWidth;
            if(maxWidth<992){
                $(".layui-side").removeClass("polar-left-show");
                $(".layui-body").removeClass("polar-show");
                $(".layui-footer").removeClass("polar-show");
                $(".polar-shadow-menu").removeClass("polar-show");
			}else{
                $(".layui-side").addClass("polar-left-show");
                $(".layui-body").addClass("polar-show");
                $(".layui-footer").addClass("polar-show");
                $(".polar-shadow-menu").addClass("polar-show");//显示遮盖物
			}
			$(".polar-leftMenu").click(function(){
			    var ele=$(".layui-side");
			    if(ele.hasClass("polar-left-show")){
                    $(".layui-side").removeClass("polar-left-show");
                    $(".layui-body").removeClass("polar-show");
                    $(".layui-footer").removeClass("polar-show");
                    $(".polar-shadow-menu").removeClass("polar-show");//隐藏遮盖物
				}else{
                    $(".layui-side").addClass("polar-left-show");
                    $(".layui-body").addClass("polar-show");
                    $(".layui-footer").addClass("polar-show");
                    var maxWidth=document.body.clientWidth;
                    if(maxWidth<992){
                        $(".polar-shadow-menu").addClass("polar-show");//显示遮盖物
					}
				}
			});
            $(".polar-shadow-menu").click(function(){
                $(".layui-side").removeClass("polar-left-show");
                $(".layui-body").removeClass("polar-show");
                $(".layui-footer").removeClass("polar-show");
                $(".polar-shadow-menu").removeClass("polar-show");//隐藏遮盖物
			});
            $(".polar-search-item").click(function(){
                var ele=$(".layui-side");
                if(ele.hasClass("polar-left-show")){
                    return;
				}
                var ele=$(".layui-form-item.polar-scroll");
                if(polar.isNull(ele)){
                    return;
				}
                if(ele.hasClass("polar-search-show")){
                    ele.removeClass("polar-search-show");
                    $(".polar-shadow-search-top").removeClass("polar-show");
                    $(".polar-shadow-search-bottom").removeClass("polar-show");
                }else{
                    ele.addClass("polar-search-show");
                    $(".polar-shadow-search-top").addClass("polar-show");
                    $(".polar-shadow-search-bottom").addClass("polar-show");
                }
            });
            $(".polar-shadow-search-top").click(function(){
                var ele=$(".layui-form-item.polar-scroll");
                ele.removeClass("polar-search-show");
                $(".polar-shadow-search-top").removeClass("polar-show");
                $(".polar-shadow-search-bottom").removeClass("polar-show");
			});
            $(".polar-shadow-search-bottom").click(function(){
                var ele=$(".layui-form-item.polar-scroll");
                ele.removeClass("polar-search-show");
                $(".polar-shadow-search-top").removeClass("polar-show");
                $(".polar-shadow-search-bottom").removeClass("polar-show");
            });
			$(".polar-commoninfo").click(function() {
				//保存按钮点击的时候，执行的操作
				var yesCall=function(index, layero){
					polar.form.targetCurrent.submit(index);
				};
				//layer消失时，执行的操作，清空对象
				var endCall=function(){
					polar.form.targetCurrent=null;
				};
				polar.layer.loadLayer("/user/web/selfDetail", true, 
						{width:'1000px',height:'500px',yesContent:"修改",yesBtn:true,title:"修改信息",clearForm:false,yesCall:yesCall,end:endCall}, null);
			});
			$(".polar-update-password").click(function() {
				var yesCall=function(index, layero){
					polar.form.targetCurrent.submit(index);
				};
				var endCall=function(){
					polar.form.targetCurrent=null;
				};
				polar.layer.loadLayer("/user/web/updatePwd", true, 
						{width:'500px',height:'300px',yesContent:"修改",yesBtn:true,title:"修改密码",clearForm:false,yesCall:yesCall,end:endCall}, null);
			});
		});
	});
</script>

</head>

<body class="fixed-sidebar full-height-layout gray-bg " >
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo" style="color: white;">
				 <div class="layui-anim layui-anim-fadein layui-anim-loop polar-logo">
					 <i class="layui-icon" style="font-size: 20px; color: white;">&#xe756;</i>老哥，稳！
				 </div>
			</div>
			<ul class="layui-nav layui-layout-left polar-leftMenu">
				<li class="layui-nav-item layadmin-flexible" lay-unselect="">
					<a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
						<i class="layui-icon layui-icon-spread-left" ></i>
					</a>
				</li><span class="layui-nav-bar" style="left: 38px; top: 48px; width: 0px; opacity: 0;"></span></ul>

			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left layui-side-menu ">

			</ul>
			<ul class="layui-nav layui-layout-right">
			<%--	<li class="layui-nav-item polar-search-item"><a href="">大数据</a></li>--%>
				<li class="layui-nav-item polar-search-item" lay-unselect><a href="javascript:;"><i class="fa fa-search-plus"></i></a></li>

				<li class="layui-nav-item" lay-unselect><a href="javascript:;" class='polar-nickname'> <img
						src="${user.headUrl}" class="layui-nav-img"/><span>${user.nickName}</span></a>

					<dl class="layui-nav-child">
						<dd class="polar-commoninfo">
							<a>基本资料</a>
						</dd>
						<dd class="polar-update-password">
							<a>修改密码</a>
						</dd>
					</dl>

				</li>

				<li class="layui-nav-item" lay-unselect><a class="logOut">退出</a></li>
			</ul>
		</div>
		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree">
					<c:forEach items="${menus}" var='menu' varStatus="stat">
						<dl class="layui-nav-item <c:if test="${menu.defaultOpen==1}">layui-nav-itemed</c:if>" lay-unselect>
							<a <c:if test="${not empty menu.path}">href="${menu.path}" class="menuItem"</c:if> ><i  <c:if test="${not empty menu.icon}">class="fa fa-${menu.icon}"</c:if> ></i>&nbsp;${menu.name}</a>
							<c:if test="${not empty menu.children}">
                                <c:set var="menu" value="${menu}" scope="request"/>
                                <c:set var="level" value="1" scope="request"/>
                                <c:set var="perLevel" value="10" scope="request"/>
                                <jsp:include page="main_menu.jsp"/>
							</c:if>
						</dl>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="polar-shadow-menu" ></div>
		<div class="polar-shadow-search-top" ></div>
		<div class="polar-shadow-search-bottom" ></div>
		<div class="layui-body">

			<div class="row content-tabs" >
				<button class="roll-nav roll-left J_tabLeft">
					<i class="fa fa-backward"></i>
				</button>
				<nav class="page-tabs J_menuTabs">
					<div class="page-tabs-content">
						<a href="javascript:;" id="homePage" class="active J_menuTab"
							data-id="/firstPage">首页</a>
					</div>
				</nav>
				<button class="roll-nav roll-right J_tabRight">
					<i class="fa fa-forward"></i>
				</button>
				<div class="btn-group roll-nav roll-right">
					<button class="dropdown J_tabClose" data-toggle="dropdown">
						操作<span class="caret"></span>
					</button>
					<ul role="menu" class="dropdown-menu dropdown-menu-right">
						<li class="J_tabShowActive"><a>定位当前选项卡</a></li>
						<li class="divider"></li>
						<li class="J_tabCloseAll"><a>关闭全部选项卡</a></li>
						<li class="J_tabCloseOther"><a>关闭其他选项卡</a></li>
					</ul>
				</div>
			</div>
			<div class="J_mainContent" id="content-main"
				style="overflow: hidden;"></div>
		</div>
		<div class="layui-footer">
			<div class="pull-left">
				<a href="http://www.baidu.com">恩哥做的</a> 就是吊
			</div>
		</div>
	</div>
</body>
</html>