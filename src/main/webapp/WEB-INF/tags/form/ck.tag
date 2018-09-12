<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fns.tld" prefix="fns"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="filter" type="java.lang.String" required="false" description="过滤器名称"%>
<%@ attribute name="id" type="java.lang.String" required="false" description="id"%>
<%@ attribute name="title" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="value" type="java.lang.String" description="默认选中值"%>
<%@ attribute name="classes" type="java.lang.String" description="样式"%>
<%@ attribute name="style" type="java.lang.String" description="样式"%>
<input type="checkbox"  lay-skin="primary"
<c:if test="${not empty pageScope.name}">name="${pageScope.name}"</c:if>
<c:if test="${not empty pageScope.style}">style="${style}" </c:if>
<c:if test="${not empty pageScope.classes}">class="${pageScope.classes}"</c:if>
<c:if test="${not empty pageScope.id}">id="${pageScope.id}"</c:if>
<c:if test="${value==1}">checked="checked"</c:if> 
<c:if test="${not empty pageScope.title}">title="${pageScope.title}"</c:if>
<c:if test="${not empty pageScope.filter}">lay-filter="${pageScope.filter}"</c:if>
/>