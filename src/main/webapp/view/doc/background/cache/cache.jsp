<%@page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@ include file="/view/includes/tag.jsp"%>
<div class="layui-side-scroll polar-help">
    <fieldset class="layui-elem-field">
        <legend>缓存</legend>
        <div class="layui-field-box">
        缓存分为两类：Spring缓存，shiro缓存。每类又分为两种:ehcache缓存（无法实现共享）,redis缓存（可共享）
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>spring缓存</legend>
        <div class="layui-field-box">
          开启spring缓存：
            <pre class="layui-code" lay-skin="notepad" lay-encode="true">
使用redis缓存,由spring提供
<cache:annotation-driven cache-manager="redisCacheManager" proxy-target-class="true" />
使用redis缓存,此框架提供
<cache:annotation-driven cache-manager="redisSpringCacheManager"/>
使用ehcache缓存
<cache:annotation-driven cache-manager="ehCacheManager" proxy-target-class="true" />
            </pre>
           使用spring缓存：<br/>
            使用spring缓存时，将注解写在接口处，
            <pre class="layui-code" lay-skin="notepad" lay-encode="true">
	@CacheEvict(value="dictCache",allEntries=true)//清空所有缓存，value为缓存名称
	@Override
	public Long deleteByIdPhysical(String id) {
  return super.deleteByIdPhysical(id);
	}

	@Cacheable(value="dictCache",key="#id")//缓存
	@Override
	public List&lt;polar.island.core.entity.DictEntity> findDictById(String id) {
  return dictDao.findDictById(id);
	}
            </pre>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>shiro缓存</legend>
        <div class="layui-field-box">
            开启shiro缓存：
            <pre class="layui-code" lay-skin="notepad" lay-encode="true">
缓存管理器 使用Ehcache实现
<bean id="shiroCacheManager" class="polar.island.security.cache.ShiroCacheManager">
   <property name="cacheManagerConfigFile" value="classpath:cache/shiroCache.xml" />
</bean>
使用redis缓存
<bean id="shiroCacheManager" class="polar.island.core.cache.JedisShiroCacheManager"></bean>
            </pre>
            当系统为单机时，使用ehcache或者redis都可以，当系统需要做负载均衡/分布式时，使用redis缓存
        </div>
    </fieldset>
</div>

<script type="text/javascript">
    $(function(){
        layui.code({
            about:false
        });
        $(".polar-run").bind("click",function () {
            var ele=$(this).parent();
            var str=ele.html().substr(0,ele.html().indexOf("<button"));
            str=str.split('<br/>').join("")
            str=str.split('<br>').join("")
            var val = new Function(str);
            val();
        });
    });
</script>