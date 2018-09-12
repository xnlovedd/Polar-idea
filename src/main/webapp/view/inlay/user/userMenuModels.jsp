<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="input-group polar-tree-userMenuModels" >
	<ul class="polar-tree-ul-userMenuModels ztree"></ul>
</div>
<script>
	$(function(){
		var obj={
			id:"${id}",
			init:function(){
				var data=[
					<c:forEach items="${allMenuModels}" var='dict' varStatus="stat">
			           {id:"${dict.id}",parentId:null,text:"${dict.name}" } <c:if test="${!stat.last}">,</c:if>
			        </c:forEach>
				];
				var checkData=[
					<c:forEach items="${userMenuModels}" var='dict' varStatus="stat">
			           {id:"${dict.id}",parentId:null,text:"${dict.name}"} <c:if test="${!stat.last}">,</c:if>
			        </c:forEach>
				];
				var setting = {
						check:{
							enable: true,
							autoCheckTrigger: false,
							chkStyle: "radio",
							chkboxType: { "Y": "", "N": "" },
							radioType: "all"
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
				var tree=$.fn.zTree.init($(".polar-tree-ul-userMenuModels"), setting, nodes);
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
				var url="/user/json/updateUserMenuModels";
				var data={menuModelId:null,id:this.id};
				var nodes=this.tree.getCheckedNodes(true);
				if(nodes!=null&&nodes.length>0){
					data.menuModelId=nodes[0].id;
				}
				polar.loader.load(polar.loader.jsonSuccess, polar.loader.jsonError, url, true, {closeIndex:index}, data);
			}
		};
		obj.init();
		polar.form.target=obj;
	});
</script>
