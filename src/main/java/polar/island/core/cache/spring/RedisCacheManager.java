package polar.island.core.cache.spring;

import org.springframework.cache.Cache;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

public class RedisCacheManager implements org.springframework.cache.CacheManager {

	private Set<String> names;
	private ConcurrentMap<String, RedisCache> caches;

	public RedisCacheManager() {
		names=new HashSet<String>();
		caches = new ConcurrentHashMap<String, RedisCache>();
	}

	private void loadCaches(String name) {
		names.add(name);
		caches.put(name, new RedisCache(name));
	}

	@Override
	public Cache getCache(String name) {
		if(!names.contains(name)){
			loadCaches(name);
		}
		return caches.get(name);
	}

	@Override
	public Collection<String> getCacheNames() {
		return names;
	}

}
