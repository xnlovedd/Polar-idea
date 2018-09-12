package polar.island.web.listener;

import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.WebApplicationContext;
import polar.island.core.util.JedisUtils;
import polar.island.core.util.PropertieUtil;
import polar.island.security.service.SecurityService;
import redis.clients.jedis.JedisPubSub;

import javax.servlet.ServletContext;

public class PolarWebListener extends ContextLoaderListener {
    @Override
    public WebApplicationContext initWebApplicationContext(ServletContext servletContext) {
        WebApplicationContext context = super.initWebApplicationContext(servletContext);
        final SecurityService securityService = context.getBean(SecurityService.class);
        if (securityService != null) {
            securityService.setUsePublish(false);
            //订阅redis
            JedisUtils.subscribe(PropertieUtil.getSetting("LOAD_CHANNEL"), new JedisPubSub() {
                @Override
                public void onMessage(String channel, String message) {
                    super.onMessage(channel, message);
                    securityService.reloadResource();
                }
            });
        }
        return context;
    }
}