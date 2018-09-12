package polar.island.security.session;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import polar.island.security.realm.ShiroPrincipal;

import java.io.Serializable;
import java.util.Deque;

/**
 * 使用session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY)来获取用户凭证。
 * 详见org.apache.shiro.mgt.DefaultSubjectDAO
 * 
 * @author N
 *
 */
public class SessionListener implements org.apache.shiro.session.SessionListener {
	// 活动的用户的缓存
	private Cache<String, Deque<Serializable>> activeUserCache;
	// 活动的会话缓存
	private Cache<Object, Object> activeSessionCache;

	public SessionListener(CacheManager cacheManager, String activeUserCacheName, String sessionCacheName) {
		this.activeUserCache = cacheManager.getCache(activeUserCacheName);
		this.activeSessionCache = cacheManager.getCache(sessionCacheName);
	}

	@Override
	public void onStart(Session session) {// 会话创建触发 已进入shiro的过滤连就触发这个方法

	}

	@Override
	public void onStop(Session session) {// 退出
		PrincipalCollection principalCollection= (PrincipalCollection) session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
		if(principalCollection!=null){
			ShiroPrincipal principal = (ShiroPrincipal) principalCollection.getPrimaryPrincipal();
			if (principal != null) {
				Deque<Serializable> sessions = activeUserCache.get(principal.getUser().getUserName());
				if (sessions != null && !sessions.isEmpty()) {
					sessions.remove(session.getId());
					activeUserCache.put(principal.getUser().getId()+"", sessions);
				}
			}
		}
	}

	@Override
	public void onExpiration(Session session) {// 会话过期时触发
		PrincipalCollection principalCollection= (PrincipalCollection) session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
		if(principalCollection!=null){
			ShiroPrincipal principal = (ShiroPrincipal) principalCollection.getPrimaryPrincipal();
			if (principal != null) {
				Deque<Serializable> sessions = activeUserCache.get(principal.getUser().getUserName());
				if (sessions != null && !sessions.isEmpty()) {
					sessions.remove(session.getId());
					activeUserCache.put(principal.getUser().getId()+"", sessions);
				}
			}
		}



	}

}
