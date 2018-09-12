<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fns.tld" prefix="fns"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="filter" type="java.lang.String" required="false" description="过滤器名称"%>
<%@ attribute name="id" type="java.lang.String" required="false" description="输入框Id"%>
<%@ attribute name="format" type="java.lang.String" required="true" description="类型"%>
<%@ attribute name="placeholder" type="java.lang.String" required="false" description="提示语"%>
<%@ attribute name="tag" type="java.lang.String" required="false" description="标签"%>
<%@ attribute name="value" type="java.lang.String" description="默认值"%>
<%@ attribute name="cache" type="java.lang.String" description="是否缓存"%>
<%@ attribute name="vertify" type="java.lang.String" description="校验规则"%>
<%@ attribute name="range" type="java.lang.String" description="range"%>
<%@ attribute name="type" type="java.lang.String" description="type"%>

<div class="input-group " >
<input type="text" <c:if test="${not empty pageScope.name}">name="${pageScope.name}"</c:if> placeholder="${pageScope.placeholder}" class="layui-input" 
<c:if test="${not empty pageScope.id}">id="${pageScope.id}"</c:if> 
<c:if test="${not empty pageScope.cache}">cache="${pageScope.cache}"</c:if> 
<c:if test="${not empty pageScope.tag}">tag="${pageScope.tag}"</c:if> 
<c:if test="${not empty pageScope.vertify}">lay-verify="${pageScope.vertify}"</c:if>
<c:if test="${not empty pageScope.value}">value="${pageScope.value}"</c:if> 
<c:if test="${not empty pageScope.filter}">lay-filter="${pageScope.filter}"</c:if> readonly="readonly"/>
<span class="input-group-addon inputTime" ><i class="fa fa-calendar"></i></span>
</div>
<script type="text/javascript">
 var elem="${pageScope.id}"==""?($("input[name='${pageScope.name}']")[0]):("#${pageScope.id}");
 $(elem).removeAttr('lay-key'); //移除所有的事件
 layui.laydate.render({
   elem:"${pageScope.id}"==""?($("input[name='${pageScope.name}']")[0]):("#${pageScope.id}"),
   format:'${pageScope.format}'
	,trigger: 'click' //采用click弹出
<c:if test="${not empty pageScope.range}">,range:'${pageScope.range}'</c:if>
<c:if test="${not empty pageScope.type}">,type:'${pageScope.type}'</c:if>
 });
</script>