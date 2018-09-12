<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="level" value="${level + 1}" scope="request" /><!-- 循环一次子列表，level+1 -->
<c:if test="${not empty menu.children}">
    <dl class="layui-nav-child" lay-unselect>
        <c:forEach items="${menu.children}" var='children' varStatus="stat">
            <dd lay-unselect>
                <a class="menuItem" href="${children.path}" style="padding-left: ${20+level*perLevel}px">
                    <i <c:if test="${not empty menu.icon}">class="fa fa-${children.icon}"</c:if>></i>&nbsp;${children.name}
                </a>
                <c:set var="menu" value="${children}" scope="request"/>
                <jsp:include page="main_menu.jsp"/>
            </dd>
        </c:forEach>
    </dl>
</c:if>
<c:set var="level" value="${level - 1}" scope="request" /><!-- 退出时，level-1 -->