<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fns.tld" prefix="fns"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="唯一的编号"%>
<%@ attribute name="width" type="java.lang.String" required="false" description="宽度"%>
<%@ attribute name="height" type="java.lang.String" required="false" description="高度"%>
<%@ attribute name="title" type="java.lang.String" required="false" description="标题"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="默认选择值"%>
<%@ attribute name="values" type="java.lang.String" required="true" description="树数据"%>
<div class="input-group polar-tree-${pageScope.id}" >
	<input type="hidden" <c:if test="${not empty pageScope.name}">name="${pageScope.name}"</c:if> class="polar-tree-value" value="${pageScope.value}"/>
	<input type="text"  class="layui-input polar-tree-display"  readonly="readonly"/>
	<span class="input-group-addon inputTree" ><i class="fa fa-calendar"></i></span>
</div>

<script>
$(function(){
	var tree;
	var title="请选择";
	var width="200px";
	var height='400px';
	if('${pageScope.width}'!=''){
		width='${pageScope.width}';
	}
	if('${pageScope.height}'!=''){
		height='${pageScope.height}';
	}
	if('${pageScope.title}'!=''){
		title='${pageScope.title}';
	}
	var data='${pageScope.values}';
	data=JSON.parse(data);
	data=polar.tree.init(data);
	$('.polar-tree-${pageScope.id} .inputTree').on('click',function(){
		var str='<ul class="polar-tree-ul-${pageScope.id} ztree"></ul>';
		var options={yesBtn:true,title:title,yesContent:"确定",success:function(layero, index){
			var setting = {
					check:{
						enable: true,
						autoCheckTrigger: false,
						chkStyle: "checkbox",
						chkboxType: { "Y": "s", "N": "s" }
					},
					data:{
						key:{
							name:"text",
							children:"children"
						},
						simpleData:{
							enable:false
						}
					}
				};
			var nodes =data;
			tree=$.fn.zTree.init($(".polar-tree-ul-${pageScope.id}"), setting, nodes);
			tree.expandAll(true);
			var values=	$('.polar-tree-${pageScope.id} .polar-tree-value').val();
			if(!polar.isNull(values)){
				var tmps=values.split(",");
				for(var position=0;position<tmps.length;position++){
					var tmp=tmps[position];
					var node=tree.getNodesByParam("value",tmp);
					tree.checkNode(node[0], true, false);
				}
			}
		},yesCall:function(index,layero){
			var nodes=tree.getCheckedNodes(true);
			console.log(nodes);
			var str="";
			var vals="";
			for(var position=0;position<nodes.length;position++){
				var t=nodes[position];
				if(str.length==0){
					str=str+t.text;
				}else{
					str=str+","+t.text;
				}
				if(vals.length==0){
					vals=vals+t.value;
				}else{
					vals=vals+","+t.value;
				}
			}
			$('.polar-tree-${pageScope.id} .polar-tree-value').val(vals);
			$('.polar-tree-${pageScope.id} .polar-tree-display').val(str);
			layui.layer.close(index);
		},end:function(){
			tree.destroy();
		}
		};
	
		polar.layer.layer(str,width,height,options);		
	});
});
</script>