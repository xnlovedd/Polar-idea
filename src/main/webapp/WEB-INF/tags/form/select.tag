<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fns.tld" prefix="fns"%>
<%@ attribute name="itemValues" type="java.util.List" required="true" description="组信息"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="filter" type="java.lang.String" required="false" description="过滤器名称"%>
<%@ attribute name="id" type="java.lang.String" required="false" description="selectId"%>
<%@ attribute name="value" type="java.lang.String" description="默认选中值"%>
<%@ attribute name="cache" type="java.lang.String" description="缓存"%>
<%@ attribute name="emptyValue" type="java.lang.String" description="是否使用默认值"%>
<%@ attribute name="readonly" type="java.lang.String" description="是否可读"%>
<%@ attribute name="classes" type="java.lang.String" description="样式"%>
<%@ attribute name="style" type="java.lang.String" description="样式"%>
<select 
<c:if test="${not empty pageScope.name}">name="${pageScope.name}"</c:if> 
<c:if test="${not empty pageScope.id}">id="${pageScope.id}"</c:if> 
<c:if test="${not empty pageScope.filter}">lay-filter="${pageScope.filter}"</c:if> 
<c:if test="${not empty pageScope.cache}">cache="${pageScope.cache}"</c:if>
<c:if test="${not empty pageScope.classes}">class="${pageScope.classes}"</c:if>
<c:if test="${not empty pageScope.readonly}">readonly="readonly" </c:if>
<c:if test="${not empty pageScope.style}">style="${style}" </c:if>
>
 	<c:if test="${not empty pageScope.emptyValue}">
 	 	<option value="">${pageScope.emptyValue}</option>
 	</c:if>
    <c:if test="${not empty pageScope.itemValues}">
        <c:forEach items="${pageScope.itemValues}" var='dict'>
           	<option value="${dict.value}"  <c:if test="${dict.value==pageScope.value}">selected='selected'</c:if> >${dict.text}</option>
        </c:forEach>
    </c:if>
</select>