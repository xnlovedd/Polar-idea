<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fns.tld" prefix="fns"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="名称,在页面中的唯一编号"%>
<%@ attribute name="width" type="java.lang.String"  description="图片宽度"%>
<%@ attribute name="height" type="java.lang.String"  description="图片高度"%>
<%@ attribute name="value" type="java.lang.String" description="默认选中值"%>
<div class="polar-img-${pageScope.name}-template" style="display: none">
    <div class="polar-img-item-${pageScope.name}-[uuid] item" style="height:<c:choose><c:when test="${not empty pageScope.height}">${pageScope.height}</c:when><c:otherwise>80px</c:otherwise></c:choose>;width: <c:choose><c:when test="${not empty pageScope.width}">${pageScope.width}</c:when><c:otherwise>80px</c:otherwise></c:choose>;position: relative;float: left;margin-left: 2px;margin-right: 2px;">
        <input type="hidden" value="">
        <!-- 加载中的框框 -->
        <div  class="polar-img-loading" style="position: absolute; left: 0px;right: 0px;top: 0px;bottom: 0px;background-color: white;border: 1px solid #f3f3f4;" >
            <div style="position: absolute;left: 0px;right: 0px;top: 0px;bottom: 9px;text-align: center; display: inline-block;vertical-align: middle;">
                <div style="display: table;height: 100%;width: 100%">
                    <i  style="font-size: 30px; color: #1E9FFF;display:table-cell;vertical-align: middle;">0%</i>
                </div>
            </div>
            <div class="layui-progress" lay-filter="${pageScope.name}Progress-[uuid]"  style="position: absolute;left: 1px;bottom:3px;right: 1px;">
                <div class="layui-progress-bar" ></div>
            </div>
        </div>
        <!-- 加载成功的框框 -->
        <div class="polar-img" style="position: absolute; left: 0px;right: 0px;top: 0px;bottom: 0px;display: none">
            <img class="polar-img-img" height="<c:choose><c:when test="${not empty pageScope.height}">${pageScope.height}</c:when><c:otherwise>80px</c:otherwise></c:choose>" width="<c:choose><c:when test="${not empty pageScope.width}">${pageScope.width}</c:when><c:otherwise>80px</c:otherwise></c:choose>" />
            <div class="polar-img-close" style="position: absolute;right:2px;top: 2px;"><i class="fa fa-close"></i></div>
        </div>
    </div>
</div>
<div class="polar-img-${pageScope.name}">
    <c:if test="${not empty pageScope.value}">
            <div class="polar-img-item-${pageScope.name}-0 item" style="height: <c:choose><c:when test="${not empty pageScope.height}">${pageScope.height}</c:when><c:otherwise>80px</c:otherwise></c:choose>;width: <c:choose><c:when test="${not empty pageScope.width}">${pageScope.width}</c:when><c:otherwise>80px</c:otherwise></c:choose>;position: relative;float: left;margin-left: 2px;margin-right: 2px;">
                <input type="hidden" name="${pageScope.name}" value="${pageScope.value}">
                <!-- 加载中的框框 -->
                <div  class="polar-img-loading" style="display: none; position: absolute; left: 0px;right: 0px;top: 0px;bottom: 0px;background-color: white;border: 1px solid #f3f3f4;" >
                    <div style="position: absolute;left: 0px;right: 0px;top: 0px;bottom: 9px;text-align: center; display: inline-block;vertical-align: middle;">
                        <div style="display: table;height: 100%;width: 100%">
                            <i  style="font-size: 30px; color: #1E9FFF;display:table-cell;vertical-align: middle;">0%</i>
                        </div>
                    </div>
                    <div class="layui-progress" lay-filter="${pageScope.name}Progress-[uuid]"  style="position: absolute;left: 1px;bottom:3px;right: 1px;">
                        <div class="layui-progress-bar" ></div>
                    </div>
                </div>
                <!-- 加载成功的框框 -->
                <div class="polar-img" style="position: absolute; left: 0px;right: 0px;top: 0px;bottom: 0px;">
                    <img class="polar-img-img" src="${pageScope.value}" height="<c:choose><c:when test="${not empty pageScope.height}">${pageScope.height}</c:when><c:otherwise>80px</c:otherwise></c:choose>" width="<c:choose><c:when test="${not empty pageScope.width}">${pageScope.width}</c:when><c:otherwise>80px</c:otherwise></c:choose>" />
                    <div class="polar-img-close" style="position: absolute;right:2px;top: 2px;"><i class="fa fa-close"></i></div>
                </div>
            </div>
    </c:if>
    <div class="polar-img-add-${pageScope.name}" style="left: 0px;right: 0px;top: 0px;bottom: 0px; border: 1px dashed  #e6e6e6;background-color: white; height:<c:choose><c:when test="${not empty pageScope.height}">${pageScope.height}</c:when><c:otherwise>80px</c:otherwise></c:choose>;width: <c:choose><c:when test="${not empty pageScope.width}">${pageScope.width}</c:when><c:otherwise>80px</c:otherwise></c:choose>;border: 1px solid #f3f3f4;float: left;">
        <div style="width: 100%;height: 100%;color: #e6e6e6;text-align: center;display: table;">
            <span style="display:table-cell;vertical-align: middle;"  class="fa fa-plus fa-5x"></span>
        </div>
    </div>
</div>
<script type="text/javascript">
    layui.upload.render({
        elem: $('.polar-img-add-${pageScope.name}')
        ,url:ctx+polar.constants.uploadFile
        ,accept:"images"
        ,done: function(res, index, upload,uuid){
            if(res.code!=polar.constants.success){
                $('.polar-img-item-${pageScope.name}-'+uuid).remove();
                $('.polar-img-${pageScope.name}').find('input').each(function(index,ele){
                    $(this).attr("name","${pageScope.name}");
                });
                if(1!=-1){
                    var count=$('.polar-img-${pageScope.name}').find('.item').length-1;
                    if(count>=1){
                        $('.polar-img-add-${pageScope.name}').hide();
                    }else{
                        $('.polar-img-add-${pageScope.name}').show();
                    }
                }

                if (!polar.permission.logFilter(res)) {
                    polar.dialog.alert("提示", res.msg);
                }
                return;
            }
            $('.polar-img-item-${pageScope.name}-'+uuid+' div.polar-img').show();
            $('.polar-img-item-${pageScope.name}-'+uuid+' div.polar-img-loading').hide();
            $('.polar-img-item-${pageScope.name}-'+uuid+' input').attr("value",res.data);
            $('.polar-img-item-${pageScope.name}-'+uuid+' .polar-img-img').attr('src',res.data);
            $('.polar-img-${pageScope.name}').find('input').each(function(index,ele){
                $(this).attr("name","${pageScope.name}");
            });
        }
        ,error: function(index,obj,uuid){
            polar.dialog.toast("文件上传失败");
            $('.polar-img-item-${pageScope.name}-'+uuid).remove();
            $('.polar-img-${pageScope.name}').find('input').each(function(index,ele){
                $(this).attr("name","${pageScope.name}");
            });
            if(1!=-1){
                var count=$('.polar-img-${pageScope.name}').find('.item').length-1;
                if(count>=1){
                    $('.polar-img-add-${pageScope.name}').hide();
                }else{
                    $('.polar-img-add-${pageScope.name}').show();
                }
            }
        }
        ,before:function(ojb,uuid){//上传前的回调
            if(1!=-1){
                var count=$('.polar-img-${pageScope.name}').find('.item').length+1;
                if(count>=1){
                    $('.polar-img-add-${pageScope.name}').hide();
                }else{
                    $('.polar-img-add-${pageScope.name}').show();
                }
                if(count>1){
                    polar.dialog.alert("提示","最多只能上传1张图片");
                    return false;
                }
            }
            //增加一个图片、加载框
            $('.polar-img-add-${pageScope.name}').before($(".polar-img-${pageScope.name}-template").html().split('[uuid]').join(uuid));
            $('.polar-img-item-${pageScope.name}-'+uuid+' div.polar-img').hide();

            $('.polar-img-item-${pageScope.name}-'+uuid+' div.polar-img-loading').show();
            $('.polar-img-${pageScope.name}').find('.polar-img-img').unbind('click');
            $('.polar-img-${pageScope.name}').find('.polar-img-img').bind('click',function(){
                var src=$(this).attr('src');
                var json={
                    "title": "查看图片", //相册标题
                    "id": 123, //相册id
                    "start": 0, //初始显示的图片序号，默认0
                    "data": [   //相册包含的图片，数组格式
                        {
                            "alt": "预览图片",
                            "pid": 666, //图片id
                            "src": src, //原图地址
                            "thumb": "" //缩略图地址
                        }
                    ]
                };
                layer.photos({
                    photos: json
                    ,anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数）
                });
            });
            $('.polar-img-${pageScope.name}').find('.polar-img-close').unbind('click');
            $('.polar-img-${pageScope.name}').find('.polar-img-close').bind('click',function(){
                var that=$(this);
                polar.dialog.confirm("提示", "确认要删除此图片吗？", function() {
                    that.parents('.item').remove();
                    $('.polar-img-${pageScope.name}').find('input').each(function(index,ele){
                        $(this).attr("name","${pageScope.name}");
                    });
                    if(1!=-1){
                        var count=$('.polar-img-${pageScope.name}').find('.item').length-1;
                        if(count>=1){
                            $('.polar-img-add-${pageScope.name}').hide();
                        }else{
                            $('.polar-img-add-${pageScope.name}').show();
                        }
                    }
                });
            });
            return true;
        }
        ,progress:function(progress,uuid){
            $('.polar-img-item-${pageScope.name}-'+uuid+' div.polar-img-loading i').html(progress+"%");
            layui.element.progress('${pageScope.name}Progress-'+uuid, progress+"%");
        }
    });
    $('.polar-img-${pageScope.name}').find('.polar-img-close').unbind('click');
    $('.polar-img-${pageScope.name}').find('.polar-img-close').bind('click',function(){
        var that=$(this);
        polar.dialog.confirm("提示", "确认要删除此图片吗？", function() {
            that.parents('.item').remove();
            $('.polar-img-${pageScope.name}').find('input').each(function(index,ele){
                $(this).attr("name","${pageScope.name}");
            });
            if(1!=-1){
                var count=$('.polar-img-${pageScope.name}').find('.item').length-1;
                if(count>=1){
                    $('.polar-img-add-${pageScope.name}').hide();
                }else{
                    $('.polar-img-add-${pageScope.name}').show();
                }
            }
        });
    });
    $('.polar-img-${pageScope.name}').find('.polar-img-img').bind('click',function(){
        var src=$(this).attr('src');
        var json={
            "title": "查看图片", //相册标题
            "id": 123, //相册id
            "start": 0, //初始显示的图片序号，默认0
            "data": [   //相册包含的图片，数组格式
                {
                    "alt": "预览图片",
                    "pid": 666, //图片id
                    "src": src, //原图地址
                    "thumb": "" //缩略图地址
                }
            ]
        };
        layer.photos({
            photos: json
            ,anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数）
        });

    });
    $(function(){
        if(1!=-1){
            var count=$('.polar-img-${pageScope.name}').find('.item').length;
            if(count>=1){
                $('.polar-img-add-${pageScope.name}').hide();
            }else{
                $('.polar-img-add-${pageScope.name}').show();
            }
        }
        $('.polar-img-${pageScope.name}').find('input').each(function(index,ele){
            $(this).attr("name","${pageScope.name}");
        });
    });

</script>