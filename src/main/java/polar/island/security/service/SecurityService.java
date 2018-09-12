package polar.island.security.service;

import org.apache.shiro.cache.CacheManager;
import polar.island.core.util.JedisUtils;
import polar.island.core.util.PropertieUtil;
import polar.island.security.filter.DatabaseResouceFilter;

public class SecurityService {
    private String permissionCacheName;
    private CacheManager cacheManager;
    private String infoCacheName;
    private DatabaseResouceFilter databaseResouceFilter;
    private boolean usePublish = false;

    public void reloadResource() {
        if (usePublish) {
            JedisUtils.publish(PropertieUtil.getSetting("LOAD_CHANNEL"), "1");
        } else {
            reloadResourceTruely();
        }
    }

    private void reloadResourceTruely() {
        databaseResouceFilter.loadDataBasePermissions();
    }

    public void clearUserPermissionCache(String userId) {
        cacheManager.getCache(permissionCacheName).remove(userId);
        cacheManager.getCache(infoCacheName).remove(userId);
    }

    public void clearAllUserPermissionCache() {
        cacheManager.getCache(permissionCacheName).clear();
        cacheManager.getCache(infoCacheName).clear();
    }

    public void clearUserInfoCache(String userName) {
        cacheManager.getCache(infoCacheName).remove(userName);
    }

    public void clearAllUserInfoCache() {
        cacheManager.getCache(infoCacheName).clear();
    }

    public String getPermissionCacheName() {
        return permissionCacheName;
    }

    public void setUsePublish(boolean usePublish) {
        this.usePublish = usePublish;
    }

    public void setPermissionCacheName(String permissionCacheName) {
        this.permissionCacheName = permissionCacheName;
    }

    public CacheManager getCacheManager() {
        return cacheManager;
    }

    public void setCacheManager(CacheManager cacheManager) {
        this.cacheManager = cacheManager;
    }


    public String getInfoCacheName() {
        return infoCacheName;
    }

    public void setInfoCacheName(String infoCacheName) {
        this.infoCacheName = infoCacheName;
    }


    public DatabaseResouceFilter getDatabaseResouceFilter() {
        return databaseResouceFilter;
    }

    public void setDatabaseResouceFilter(DatabaseResouceFilter databaseResouceFilter) {
        this.databaseResouceFilter = databaseResouceFilter;
    }
}