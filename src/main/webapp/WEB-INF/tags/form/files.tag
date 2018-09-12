<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fns.tld" prefix="fns"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="名称,在页面中的唯一编号"%>
<%@ attribute name="value" type="java.util.List" description="默认选中值"%>
<%@ attribute name="max" type="java.lang.String" description="最大上传数量"  required="true" %>
<%@ attribute name="type" type="java.lang.String" required="true" description="文件类型"%>
<div class="polar-file-${pageScope.name}-template" style="display: none">
	<div class="polar-file-item-${pageScope.name}-[uuid] item" style="width: 100%;height:40px;position: relative;float: left;margin-left: 2px;margin-right: 2px;border: 1px solid #f3f3f4;">
		<input type="hidden" >
		<a class="polar-file-file" target="_blank" href="#"  style="margin-top: 3px;margin-left: 3px;">下载文件</a>
		<div class="polar-file-close" style="position: absolute;right:2px;top: 2px;"> <i class="fa fa-close"></i>删除</div>
		<!-- 加载中的框框 -->
		<div  class="polar-file-loading" style="position: absolute; left: 0px;right: 0px;top: 0px;bottom: 0px;background-color: white;" >
			<div class="layui-progress" lay-filter="${pageScope.name}Progress-[uuid]"  style="position: absolute;left: 1px;bottom:3px;right: 1px;">
				<div class="layui-progress-bar" ></div>
			</div>
		</div>
	</div>
</div>
<div class="polar-file-${pageScope.name}" style="width: 100%">

	<c:if test="${not empty pageScope.value}">
		<c:forEach  items="${pageScope.value}" var='item' varStatus="status">
			<div class="polar-file-item-${pageScope.name}-${status.index} item" style="width: 100%;height:40px;position: relative;float: left;margin-left: 2px;margin-right: 2px;border: 1px solid #f3f3f4;">
				<input type="hidden" name="${pageScope.name}" value="${item}">
				<a class="polar-file-file" target="_blank" href="${item}" style="margin-top: 3px;margin-left: 3px;">${fns:getFileName(item)}</a>
				<div class="polar-file-close" style="position: absolute;right:2px;top: 2px;"> <i class="fa fa-close"></i>删除</div>
				<!-- 加载中的框框 -->
				<div  class="polar-file-loading" style="position: absolute; left: 0px;right: 0px;top: 0px;bottom: 0px;background-color: white;display: none;" >
					<div class="layui-progress" lay-filter="${pageScope.name}Progress-[uuid]"  style="position: absolute;left: 1px;bottom:3px;right: 1px;">
						<div class="layui-progress-bar" ></div>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:if>

	<button type="button" class="layui-btn  layui-btn-sm layui-btn-primary pull-right polar-file-add-${pageScope.name}"  >
		<i class="layui-icon">&#xe67c;</i>添加文件
	</button>
</div>
<script type="text/javascript">
    layui.upload.render({
        elem: $('.polar-file-add-${pageScope.name}')
        ,url:ctx+polar.constants.uploadFile
        ,accept:"${type}"
        ,done: function(res, index, upload,uuid){
            if(res.code!=polar.constants.success){
                $('.polar-file-item-${pageScope.name}-'+uuid).remove();
                $('.polar-file-${pageScope.name}').find('input').each(function(index,ele){
                    $(this).attr("name","${pageScope.name}["+index+"]");
                });
                if(${max}!=-1){
					var count=$('.polar-file-${pageScope.name}').find('.item').length-1;
					if(count>=${max}){
						$('.polar-file-add-${pageScope.name}').hide();
					}else{
						$('.polar-file-add-${pageScope.name}').show();
					}
                }
                if (!polar.permission.logFilter(res)) {
                    polar.dialog.alert("提示", res.msg);
                }
                return;
            }
            $('.polar-file-item-${pageScope.name}-'+uuid+' div.polar-file-loading').hide();
            $('.polar-file-item-${pageScope.name}-'+uuid+' a.polar-file-file').attr("href",res.data);
            $('.polar-file-item-${pageScope.name}-'+uuid+' input').attr("value",res.data);
            var fileName=decodeURIComponent(res.data);
            fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length);
            $('.polar-file-item-${pageScope.name}-'+uuid+' .polar-file-file').html(fileName);
            $('.polar-file-${pageScope.name}').find('input').each(function(index,ele){
                $(this).attr("name","${pageScope.name}["+index+"]");
            });
        }
        ,error: function(index,obj,uuid){
            polar.dialog.toast("文件上传失败");
            $('.polar-file-item-${pageScope.name}-'+uuid).remove();
            $('.polar-file-${pageScope.name}').find('input').each(function(index,ele){
                $(this).attr("name","${pageScope.name}["+index+"]");
            });
            if(${max}!=-1){
                var count=$('.polar-file-${pageScope.name}').find('.item').length-1;
                if(count>=${max}){
                    $('.polar-file-add-${pageScope.name}').hide();
                }else{
                    $('.polar-file-add-${pageScope.name}').show();
                }
			}
        }
        ,before:function(ojb,uuid){//上传前的回调
            if(${max}!=-1){
				var count=$('.polar-file-${pageScope.name}').find('.item').length+1;
				if(count>=${max}){
					$('.polar-file-add-${pageScope.name}').hide();
				}else{
					$('.polar-file-add-${pageScope.name}').show();
				}
				if(count>${max}){
					polar.dialog.alert("提示","最多只能上传${max}个文件");
					return false;
				}
            }
            //增加一个文件、加载框
            $('.polar-file-add-${pageScope.name}').before($(".polar-file-${pageScope.name}-template").html().split('[uuid]').join(uuid));
            $('.polar-file-item-${pageScope.name}-'+uuid+' div.polar-file-loading').show();
            $('.polar-file-${pageScope.name}').find('input').each(function(index,ele){
                $(this).attr("name","${pageScope.name}["+index+"]");
            });
            $('.polar-file-${pageScope.name}').find('.polar-file-close').unbind('click');
            $('.polar-file-${pageScope.name}').find('.polar-file-close').bind('click',function(){
                var that=$(this);
                polar.dialog.confirm("提示", "确认要删除此文件吗？", function() {
                    that.parents('.item').remove();
                    $('.polar-file-${pageScope.name}').find('input').each(function(index,ele){
                        $(this).attr("name","${pageScope.name}["+index+"]");
                    });
                    var count=$('.polar-file-${pageScope.name}').find('.item').length-1;
                    if(count>=${max}){
                        $('.polar-file-add-${pageScope.name}').hide();
                    }else{
                        $('.polar-file-add-${pageScope.name}').show();
                    }
                });
            });
            return true;
        }
        ,progress:function(progress,uuid){
            layui.element.progress('${pageScope.name}Progress-'+uuid, progress+"%");
        }
    });
    $('.polar-file-${pageScope.name}').find('.polar-file-close').unbind('click');
    $('.polar-file-${pageScope.name}').find('.polar-file-close').bind('click',function(){
        var that=$(this);
        polar.dialog.confirm("提示", "确认要删除此文件吗？", function() {
            that.parents('.item').remove();
            $('.polar-file-${pageScope.name}').find('input').each(function(index,ele){
                $(this).attr("name","${pageScope.name}["+index+"]");
            });
			if(${max}!=-1){
				var count=$('.polar-file-${pageScope.name}').find('.item').length-1;
				if(count>=${max}){
					$('.polar-file-add-${pageScope.name}').hide();
				}else{
					$('.polar-file-add-${pageScope.name}').show();
				}
            }
        });
    });

    $(function(){
        if(${max}!=-1){
			var count=$('.polar-file-${pageScope.name}').find('.item').length-1;
			if(count>=${max}){
				$('.polar-file-add-${pageScope.name}').hide();
			}else{
				$('.polar-file-add-${pageScope.name}').show();
			}
        }
        $('.polar-file-${pageScope.name}').find('input').each(function(index,ele){
            $(this).attr("name","${pageScope.name}["+index+"]");
        });
    });

</script>