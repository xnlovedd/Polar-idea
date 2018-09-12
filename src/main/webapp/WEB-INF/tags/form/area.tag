<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fns.tld" prefix="fns"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="名称"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="唯一编号"%>
<%@ attribute name="value" type="java.lang.String" description="默认选中值"%>
<%@ attribute name="cache" type="java.lang.String" description="默认选中值"%>
<div class="${pageScope.id} polar-province" style="width: 100%;height: 100%">
<input type="hidden" name="${pageScope.name}"
	<c:if test="${not empty pageScope.value}">value="${pageScope.value}"</c:if>
	<c:if test="${not empty pageScope.cache}">cache="${pageScope.cache}"</c:if> />
<table >
	<tr >
		<td style="padding: 0px; border: 0px;">
			<select lay-filter="${pageScope.id}_province">
				<option value="">请选择</option>
			</select>
		</td>
		<td style="padding: 0px; border: 0px;">
			<select lay-filter="${pageScope.id}_city">
				<option value="">请选择</option>
			</select>
		</td>
		<td style="padding: 0px; border: 0px;">
			<select lay-filter="${pageScope.id}_area">
				<option value="">请选择</option>
			</select>
		</td>
	</tr>
</table>
<script type="text/javascript">
	polar.province.proviceSelect("${name}","${pageScope.id}");
</script>
</div>