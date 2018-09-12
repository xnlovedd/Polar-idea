package polar.island.core.cache;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.cache.CacheManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import polar.island.core.util.JedisUtils;
import redis.clients.jedis.Jedis;

import java.util.*;

/**
 * jedis缓存器，用于缓存用户凭证，session等数据。
 *
 * @author PolarLoves
 */
public class JedisShiroCacheManager implements CacheManager {


    public <K, V> Cache<K, V> getCache(String arg0) throws CacheException {
        return new JedisCache<K, V>(arg0);
    }

    public class JedisCache<K, V> implements Cache<K, V> {
        private Logger logger = LoggerFactory.getLogger(getClass());
        private String name;

        public JedisCache(String name) {
            this.name = "caches_jedis_shiro_" + name;
        }

        public void clear() throws CacheException {
            Jedis jedis = null;
            try {
                jedis = JedisUtils.getResource();
                jedis.del(JedisUtils.getBytesKey(name));
            } catch (Exception e) {
                logger.error("clear {}", name, e);
            } finally {
                JedisUtils.returnResource(jedis);
            }
        }

        @SuppressWarnings("unchecked")
        public V get(K key) throws CacheException {
            V value = null;
            Jedis jedis = null;
            try {
                jedis = JedisUtils.getResource();
                value = (V) JedisUtils.toObject(jedis.hget(JedisUtils.getBytesKey(name), JedisUtils.getBytesKey(key)));
            } catch (Exception e) {
                logger.error("get {} {} ", name, key, e);
            } finally {
                JedisUtils.returnResource(jedis);
            }
            return value;
        }

        @SuppressWarnings("unchecked")

        public Set<K> keys() {
            Set<K> keys = new HashSet<K>();
            Jedis jedis = null;
            try {
                jedis = JedisUtils.getResource();
                Set<byte[]> set = jedis.hkeys(JedisUtils.getBytesKey(name));
                for (byte[] key : set) {
                    keys.add((K) key);
                }
                logger.debug("keys {} {} ", name, keys);
                return keys;
            } catch (Exception e) {
                logger.error("keys {}", name, e);
            } finally {
                JedisUtils.returnResource(jedis);
            }
            return keys;
        }

        public V put(K key, V value) throws CacheException {
            if (key == null) {
                return null;
            }
            Jedis jedis = null;
            try {
                jedis = JedisUtils.getResource();
                jedis.hset(JedisUtils.getBytesKey(name), JedisUtils.getBytesKey(key), JedisUtils.toBytes(value));
                logger.debug("put {} {} = {}", name, key, value);
            } catch (Exception e) {
                logger.error("put {} {}", name, key, e);
            } finally {
                JedisUtils.returnResource(jedis);
            }
            return value;
        }

        @SuppressWarnings("unchecked")
        public V remove(K key) throws CacheException {
            V value = null;
            Jedis jedis = null;
            try {
                jedis = JedisUtils.getResource();
                value = (V) JedisUtils.toObject(jedis.hget(JedisUtils.getBytesKey(name), JedisUtils.getBytesKey(key)));
                jedis.hdel(JedisUtils.getBytesKey(name), JedisUtils.getBytesKey(key));
                logger.debug("remove {} {}", name, key);
            } catch (Exception e) {
                logger.warn("remove {} {}", name, key, e);
            } finally {
                JedisUtils.returnResource(jedis);
            }
            return value;
        }

        public int size() {
            int size = 0;
            Jedis jedis = null;
            try {
                jedis = JedisUtils.getResource();
                size = jedis.hlen(JedisUtils.getBytesKey(name)).intValue();
                logger.debug("size {} {} ", name, size);
                return size;
            } catch (Exception e) {
                logger.error("clear {}", name, e);
            } finally {
                JedisUtils.returnResource(jedis);
            }
            return size;
        }

        @SuppressWarnings("unchecked")

        public Collection<V> values() {
            List<V> vals = new ArrayList<V>();
            Jedis jedis = null;
            try {
                jedis = JedisUtils.getResource();
                Collection<byte[]> col = jedis.hvals(JedisUtils.getBytesKey(name));
                for (byte[] val : col) {
                    vals.add((V) JedisUtils.toObject(val));
                }
                logger.debug("values {} {} ", name, vals);
                return vals;
            } catch (Exception e) {
                logger.error("values {}", name, e);
            } finally {
                JedisUtils.returnResource(jedis);
            }
            return vals;
        }

    }
}
