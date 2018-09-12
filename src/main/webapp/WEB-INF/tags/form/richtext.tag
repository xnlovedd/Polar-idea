<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fns.tld" prefix="fns"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="唯一编号"%>
<%@ attribute name="value" type="java.lang.String" description="默认选中值"%>
<%@ attribute name="vertify" type="java.lang.String" description="校验规则"%>
<%@ attribute name="maxLength" type="java.lang.String" description="最大长度"%>
<%@ attribute name="minLength" type="java.lang.String" description="最小长度"%>
<%@ attribute name="filter" type="java.lang.String"  required="false" description="过滤器名称"%>
<%@ attribute name="tag" type="java.lang.String" required="false" description="标签"%>
<textarea name="${pageScope.name}" class="layui-textarea"
id="${pageScope.name}"
<c:choose><c:when test="${not empty pageScope.maxLength&&pageScope.maxLength>0}">polar-maxLength="${pageScope.maxLength}" maxLength="${pageScope.maxLength}"</c:when><c:when test="${not empty pageScope.maxLength&&pageScope.maxLength<=0}"></c:when><c:otherwise>polar-maxLength="2000" maxLength="2000"</c:otherwise></c:choose>
<c:if test="${not empty pageScope.vertify}">lay-verify="${pageScope.vertify}"</c:if>
<c:if test="${not empty pageScope.filter}">lay-filter="${pageScope.filter}</c:if>
<c:if test="${not empty pageScope.tag}">tag="${pageScope.tag}"</c:if>
<c:if test="${not empty pageScope.filter}">lay-filter="${pageScope.filter}</c:if>
><c:if test="${not empty pageScope.value}">${pageScope.value}</c:if></textarea>