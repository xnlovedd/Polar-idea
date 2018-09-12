package polar.island.security.filter;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.session.ExpiredSessionException;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.DefaultSessionKey;
import org.apache.shiro.session.mgt.SessionManager;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.servlet.AdviceFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import polar.island.core.config.Constants;
import polar.island.security.realm.ShiroPrincipal;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.io.Serializable;
import java.util.Deque;
import java.util.LinkedList;

/**
 * 并发人数控制，拦截其登录请求
 *
 * @author N
 */
public class ConcurrentControlFilter extends AdviceFilter {
    private Logger logger = LoggerFactory.getLogger(getClass());
    // 活动的用户的缓存
    private Cache<String, Deque<Serializable>> activeUserCache;
    private int maxSession = 1;
    private SessionManager sessionManager;
    private String forceDownLineName = Constants.FORCE_DOWNLINE_MSG;
    private String forceDownLineFlag = Constants.FORCE_DOWNLINE_FLAG;

    public ConcurrentControlFilter(CacheManager cacheManager, String activeUserCacheName, SessionManager sessionManager,
                                   int maxSession) {
        activeUserCache = cacheManager.getCache(activeUserCacheName);
        this.sessionManager = sessionManager;
        this.maxSession = maxSession;
    }

    @Override
    protected void postHandle(ServletRequest request, ServletResponse response) throws Exception {
        Subject subject = SecurityUtils.getSubject();
        if (!subject.isAuthenticated() && !subject.isRemembered()) {
            // 如果没有登录，直接进行之后的流程
            return;
        }

        Session session = subject.getSession();
        ShiroPrincipal principal = (ShiroPrincipal) subject.getPrincipal();
        String userId = principal.getUser().getId() + "";
        Serializable sessionId = session.getId();
        Deque<Serializable> caches = activeUserCache.get(userId);
        if (caches == null) {
            caches = new LinkedList<Serializable>();
        }
        // 如果队列里没有此sessionId,放入队列
        if (!caches.contains(sessionId) && session.getAttribute(forceDownLineFlag) == null) {
            caches.push(sessionId);
        }
        while (caches.size() > maxSession) {
            Serializable kickoutSessionId = null;
            kickoutSessionId = caches.removeLast();
            try {
                Session kickoutSession = null;
                try {
                    kickoutSession = sessionManager.getSession(new DefaultSessionKey(kickoutSessionId));
                } catch (ExpiredSessionException e) {
                }
                if (kickoutSession != null) {
                    // 设置会话的kickout属性表示踢出了
                    kickoutSession.setAttribute(forceDownLineFlag, true);
                    kickoutSession.setAttribute(forceDownLineName, "您的账号在另外一台设备登录，您已被强制下线.");
                }
            } catch (Exception e) {
                logger.error("踢出用户失败：{}", e);
            }
        }
        activeUserCache.put(userId, caches);
    }

}
