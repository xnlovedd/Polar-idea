<%@ page isELIgnored="false"%> <!--支持EL表达式，不设的话，EL表达式不会解析-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> <!--输出,条件,迭代标签库-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> <!--数据格式化标签库-->
<%@ taglib uri="/WEB-INF/tlds/fns.tld" prefix="fns"%> <!--自定义库-->
<%@ taglib prefix="form" tagdir="/WEB-INF/tags/form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<c:set var="ctx" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}"/>
<c:set var="ctxStatic" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/static"/>

