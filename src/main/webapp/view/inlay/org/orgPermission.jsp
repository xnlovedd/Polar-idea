<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="input-group polar-tree-userRole" >
	<ul class="polar-tree-ul-orgPermission ztree"></ul>
</div>
<script>
	$(function(){
		var obj={
			id:"${id}",
			init:function(){
				var data=[
					<c:forEach items="${allPermissions}" var='dict' varStatus="stat">
			           {id:"${dict.id}",parentId:"${dict.parentId}",text:"${dict.text}" } <c:if test="${!stat.last}">,</c:if>
			        </c:forEach>
				];
				var checkData=[
					<c:forEach items="${orgPermissions}" var='dict' varStatus="stat">
			           {id:"${dict.id}",parentId:"${dict.parentId}",text:"${dict.text}"} <c:if test="${!stat.last}">,</c:if>
			        </c:forEach>
				];
				var setting = {
						check:{
							enable: true,
							autoCheckTrigger: false,
							chkStyle: "checkbox",
							chkboxType: { "Y": "s", "N": "s" },
							checked:"checked"
						},
						data:{
							key:{
								name:"text"
							},
							simpleData:{
								enable:true,
								idKey:"id",
								pIdKey:"parentId"
							}
						}
					};
				var nodes =data;
				var tree=$.fn.zTree.init($(".polar-tree-ul-orgPermission"), setting, nodes);
				this.tree=tree;
				tree.expandAll(true);
				if(checkData.length>0){
					for(var i=0;i<checkData.length;i++){
						 var tmp = tree.getNodeByParam("id",checkData[i].id);
						 if(!polar.isNull(tmp)){
							 tree.checkNode(tmp, true,false, false);
							 tree.updateNode(tmp); 
						 }
					
					}
				}
			}
			,submit:function(index){
				var url="/permission/json/updateOrgPermissions";
				var data={permissionIds:[],id:this.id};
				var nodes=this.tree.getCheckedNodes(true);
				for(var position=0;position<nodes.length;position++){
					var t=nodes[position].id;
					data.permissionIds[position]=t;
				}
				polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, url, true, {closeIndex:index}, data);
			}
		};
		obj.init();
		polar.form.target=obj;
	});
</script>
