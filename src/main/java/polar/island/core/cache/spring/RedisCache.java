package polar.island.core.cache.spring;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.support.SimpleValueWrapper;
import polar.island.core.util.JedisUtils;
import redis.clients.jedis.Jedis;

import java.util.concurrent.Callable;

public class RedisCache implements org.springframework.cache.Cache {
	private String name;
	private String keyPre = "caches_jedis_spring_";
	private Logger logger = LoggerFactory.getLogger(getClass());

	public RedisCache(String name) {
		this.name = name;
	}

	/** 获取 cache 名称 */
	@Override
	public String getName() {
		return name;
	}

	/** 获取真正的缓存提供方案 */
	@Override
	public Object getNativeCache() {
		return null;
	}

	/** 从缓存中获取 key 对应的值（包含在一个 ValueWrapper 中） **/
	@Override
	public ValueWrapper get(Object key) {
		Jedis jedis = null;
		ValueWrapper result = null;
		try {
			jedis = JedisUtils.getResource();
			if (jedis.hexists(JedisUtils.serialize(keyPre + name), JedisUtils.serialize(key))) {
				result = new SimpleValueWrapper(JedisUtils
						.unserialize(jedis.hget(JedisUtils.serialize(keyPre + name), JedisUtils.serialize(key))));
			}
		} catch (Exception e) {
			logger.error("clear {}", name, e);
		} finally {
			JedisUtils.returnResource(jedis);
		}
		return result;
	}

	/** 从缓存中获取 key 对应的指定类型的值（4.0版本新增） */
	@SuppressWarnings("unchecked")
	@Override
	public <T> T get(Object key, Class<T> type) {
		Jedis jedis = null;
		T result = null;
		try {
			jedis = JedisUtils.getResource();
			if (jedis.hexists(JedisUtils.serialize(keyPre + name), JedisUtils.serialize(key))) {
				result = (T) JedisUtils
						.unserialize(jedis.hget(JedisUtils.serialize(keyPre + name), JedisUtils.serialize(key)));
			}
		} catch (Exception e) {
			logger.error("get {}", name, e);
		} finally {
			JedisUtils.returnResource(jedis);
		}
		return result;
	}

	/**
	 * 从缓存中获取 key 对应的值，如果缓存没有命中，则添加缓存， 此时可异步地从 valueLoader 中获取对应的值（4.3版本新增）
	 */
	@SuppressWarnings("unchecked")
	@Override
	public <T> T get(Object key, Callable<T> valueLoader) {
		Jedis jedis = null;
		T value = null;
		try {
			jedis = JedisUtils.getResource();
			if (!jedis.hexists(JedisUtils.serialize(keyPre + name), JedisUtils.serialize(key))) {
				value = valueLoader.call();
				jedis.hset(JedisUtils.serialize(keyPre + name), JedisUtils.serialize(key), JedisUtils.serialize(value));
			} else {
				value = (T) JedisUtils
						.unserialize(jedis.hget(JedisUtils.serialize(keyPre + name), JedisUtils.serialize(key)));
			}
		} catch (Exception e) {
			logger.error("put {}", name, e);
		} finally {
			JedisUtils.returnResource(jedis);
		}
		return value;
	}

	/** 缓存 key-value，如果缓存中已经有对应的 key，则替换其 value */
	@Override
	public void put(Object key, Object value) {
		Jedis jedis = null;
		try {
			jedis = JedisUtils.getResource();
			jedis.hset(JedisUtils.serialize(keyPre + name), JedisUtils.serialize(key), JedisUtils.serialize(value));
		} catch (Exception e) {
			logger.error("put {}", name, e);
		} finally {
			JedisUtils.returnResource(jedis);
		}

	}

	/** 缓存 key-value，如果缓存中已经有对应的 key，则返回已有的 value，不做替换 */
	@Override
	public ValueWrapper putIfAbsent(Object key, Object value) {
		Jedis jedis = null;
		ValueWrapper result = null;
		try {
			jedis = JedisUtils.getResource();
			if (!jedis.hexists(JedisUtils.serialize(keyPre + name), JedisUtils.serialize(key))) {
				jedis.hset(JedisUtils.serialize(keyPre + name), JedisUtils.serialize(key), JedisUtils.serialize(value));
			}
			result = new SimpleValueWrapper(value);
		} catch (Exception e) {
			logger.error("clear {}", name, e);
		} finally {
			JedisUtils.returnResource(jedis);
		}
		return result;
	}

	/** 从缓存中移除对应的 key */
	@Override
	public void evict(Object key) {
		Jedis jedis = null;
		try {
			jedis = JedisUtils.getResource();
			jedis.hdel(JedisUtils.serialize(keyPre + name), JedisUtils.serialize(key));
		} catch (Exception e) {
			logger.error("evict {}", name, e);
		} finally {
			JedisUtils.returnResource(jedis);
		}

	}

	/** 清空缓存 */
	@Override
	public void clear() {
		Jedis jedis = null;
		try {
			jedis = JedisUtils.getResource();
			jedis.del(JedisUtils.serialize(keyPre + name));
		} catch (Exception e) {
			logger.error("clear {}", name, e);
		} finally {
			JedisUtils.returnResource(jedis);
		}

	}

}
