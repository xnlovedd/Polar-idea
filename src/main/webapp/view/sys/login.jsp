<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<title>PolarLoves</title>
<meta name="keywords" content="极地框架">
<meta name="description" content="愿天下有情人同父异母">
<%@ include file="/view/includes/tag.jsp"%>
<script type="text/javascript">
	var ctx = '${ctx}', ctxStatic = '${ctxStatic}';
</script>
<script type="text/javascript" src="${ctxStatic}/jquery/jquery.min.js"></script>
<script src="${ctxStatic}/layui/layui.js"></script>
<script type="text/javascript" src="${ctxStatic}/polar/polar.js"></script>
<script type="text/javascript"
	src="${ctxStatic}/common/js/Particleground.js"></script>
<link rel="stylesheet" type="text/css"
	href="${ctxStatic}/common/css/loginCss.css" />
<style>
body {
	height: 100%;
	background: #16a085;
	overflow: hidden;
}

canvas {
	z-index: -1;
	position: absolute;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
    polar.init(function() {
	  $('body').particleground({
				dotColor : '#5cbdaa',
				lineColor : '#5cbdaa'
			});
	 //验证码
	    $(".mCode").click(function(){
			  $(this).attr("src",ctx+"/code?t="+Math.random());
	   });
	 $(".submit_btn").click(function() {
		var userName = $('.polar-username').val();
		var password = $('.polar-password').val();
		var code= $('#J_codetext').val();
		if (polar.isNull(userName)) {
			polar.dialog.alert('提示','请输入用户名');
			return;
		}
		if (polar.isNull(password)) {
			polar.dialog.alert('提示','请输入密码');
			return;
		}
		if (polar.isNull(code)) {
			polar.dialog.alert('提示','请输入验证码');
			return;
		}
		var success = function(contentType,url, loading,options, data) {
			if (loading) {
				polar.dialog.closeLoading();
			}
			if (contentType.indexOf("application/json") == -1) {
				polar.dialog.alert("提示","服务器正忙，请稍后再试");
				return;
			}
			data = JSON.parse(data);
			if (data.code != polar.constants.success) {
				if (!polar.permission.logFilter(data)) {
					polar.dialog.alert("提示",data.msg);
				}
			} else {
				polar.dialog.toast(data.msg);
				//登录成功
				window.location.href = ctx+ polar.constants.mainPage;
			}
		};
		polar.loader.load(success,polar.loader.jsonError,polar.constants.logInUrl,true,null,{userName : userName,password : password,code:code});
	 });
	<c:if test="${not empty exception}">
		polar.dialog.alert("提示","${message}");
	</c:if>
	});
});
</script>
</head>
<body>
	<dl class="admin_login">
		<dt>
			<strong>极地后台管理系统</strong> <em>Polar Management System</em>
		</dt>
		<dd class="user_icon">
			<input type="text" placeholder="账号" class="login_txtbx polar-username" />
		</dd>
		<dd class="pwd_icon">
			<input type="password" placeholder="密码" class="login_txtbx polar-password" />
		</dd>
		<dd class="val_icon">
			<div class="checkcode">
				<input type="text" id="J_codetext" placeholder="验证码" maxlength="4" style="width: 174px"
					class="login_txtbx">
				<!-- 	<canvas class="J_codeimg" id="myCanvas" >对不起，您的浏览器不支持canvas，请下载最新版浏览器!</canvas> -->
				<img class="mCode" src="${ctx}/code" style="margin: auto;margin-top: -3px;">
			</div>

			<!-- 	<input type="button" value="验证码核验" class="ver_btn"
				onClick="validate();"> -->
		</dd>
		<dd style="margin-top: 30px">
			<input type="button" value="立即登陆" class="submit_btn" />
		</dd>
		<dd>
			<p>© 恩哥做的，就是吊</p>
			<p>66666666666</p>
		</dd>
	</dl>
</body>
</body>
</html>