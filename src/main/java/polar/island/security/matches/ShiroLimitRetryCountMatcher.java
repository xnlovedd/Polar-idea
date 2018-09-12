package polar.island.security.matches;

import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import polar.island.core.config.Constants;
import polar.island.core.exception.FrameWorkException;

import java.io.Serializable;
import java.util.Date;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 凭证匹配器，如果密码输入次数大于设置的值，则抛出异常。
 * 
 * @author PolarLoves
 *
 */
public class ShiroLimitRetryCountMatcher extends HashedCredentialsMatcher {
	// AtomicInteger 线程安全的int类，passwordRetryCache为重新输入次数
	private Cache<String, FaultMessage> retryCache;
	private int retryCout;
	private long lockTime = 60 * 1000 * 30l;

	private static class FaultMessage implements Serializable {
		private static final long serialVersionUID = 1726833032596862634L;
		private AtomicInteger num;
		private long lastTime;
	}

	public ShiroLimitRetryCountMatcher(CacheManager cacheManager, String cacheName, int retryCout, long lockTime) {
		retryCache = cacheManager.getCache(cacheName);
		this.retryCout = retryCout;
		this.lockTime = lockTime;
	}

	public boolean doCredentialsMatch(AuthenticationToken token, AuthenticationInfo info) {
		String username = (String) token.getPrincipal();
		// retry count + 1
		FaultMessage faultMessage = retryCache.get(username);
		if (faultMessage == null) {
			faultMessage = new FaultMessage();
			faultMessage.num = new AtomicInteger(0);
			faultMessage.lastTime = new Date().getTime();
			retryCache.put(username, faultMessage);
		} else {
			if (faultMessage.lastTime + lockTime < new Date().getTime()) {
				// 已经过期啦~
				faultMessage = new FaultMessage();
				faultMessage.num = new AtomicInteger(0);
				faultMessage.lastTime = new Date().getTime();
				retryCache.put(username, faultMessage);
			}
		}
		int num = faultMessage.num.incrementAndGet();
		if (num > retryCout) {
			// 重试次数>retryCout
			long time = (faultMessage.lastTime + lockTime - new Date().getTime()) / 1000 / 60;
			throw new FrameWorkException(Constants.CODE_LOCKED_USER, "账号已经被锁定,将于" + time + "分钟内解锁", null, false);
		}
		boolean matches = super.doCredentialsMatch(token, info);
		if (matches) {
			// 账号密码匹配
			retryCache.remove(username);
		} else {
			faultMessage.lastTime = new Date().getTime();
			retryCache.put(username, faultMessage);
			throw new FrameWorkException(Constants.CODE_UNCORRENT_CREDENTIALS,
					"账号密码不匹配，您还有" + (retryCout - num + 1) + "次机会重新输入!", null, false);
		}
		return matches;
	}
}
