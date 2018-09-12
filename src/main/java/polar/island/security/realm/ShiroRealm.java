package polar.island.security.realm;

import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.Permission;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import polar.island.core.config.Constants;
import polar.island.core.exception.FrameWorkException;
import polar.island.core.security.EncryManager;
import polar.island.core.security.entity.UserEntity;
import polar.island.core.security.service.UserService;

import javax.annotation.Resource;
import java.util.Collection;
import java.util.Set;

/**
 * 用户权限使用用户编号作为key
 * 用户信息缓存使用用户的username作为key
 */
public class ShiroRealm extends AuthorizingRealm {
    private EncryManager encryManager;
    private static final String OR_OPERATOR = "\\|";
    private static final String AND_OPERATOR = "&";
    private static final String NOT_OPERATOR = "!";
    @Resource(name = "userService")
    private UserService userService;

    // 获取用户权限
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        UserEntity user = ((ShiroPrincipal) principals.getPrimaryPrincipal()).getUser();
        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
        Set<String> roles = userService.userRoles(user.getId() + "");
        Set<String> permissions = userService.userPermissions(user.getId() + "");
        simpleAuthorizationInfo.setRoles(roles);
        simpleAuthorizationInfo.setStringPermissions(permissions);
        return simpleAuthorizationInfo;
    }

    /**
     * 移除权限缓存数据
     *
     * @param userId 用户编号
     */
    public void clearUserAuthenticationInfoCache(String userId) {
        Cache<Object, AuthorizationInfo> cache = getAuthorizationCache();
        if (cache == null && isAuthorizationCachingEnabled()) {
            cache = getAuthorizationCacheLazy();
        }
        if (cache != null) {
            cache.remove(userId);
        }
    }

    /**
     * 移除权限所有的缓存
     */
    public void clearAllAuthenticationInfoCache() {
        Cache<Object, AuthorizationInfo> cache = getAuthorizationCache();
        if (cache == null && isAuthorizationCachingEnabled()) {
            cache = getAuthorizationCacheLazy();
        }
        if (cache != null) {
            cache.clear();
        }
    }

    private Cache<Object, AuthorizationInfo> getAuthorizationCacheLazy() {
        if (getAuthorizationCache() == null) {
            CacheManager cacheManager = getCacheManager();
            if (cacheManager != null) {
                String cacheName = getAuthorizationCacheName();
                return cacheManager.getCache(cacheName);
            } else {

            }
        }
        return getAuthorizationCache();
    }

    // 用户信息缓存的key
    @Override
    protected Object getAuthenticationCacheKey(PrincipalCollection principals) {
        // 以用户名作为缓存名称
        return ((ShiroPrincipal) principals.getPrimaryPrincipal()).getUser().getId() + "";
    }

    // 授权缓存名称,使用用户编号缓存
    @Override
    protected Object getAuthorizationCacheKey(PrincipalCollection principals) {
        // 以用户编号作为缓存名称
        return ((ShiroPrincipal) principals.getPrimaryPrincipal()).getUser().getId() + "";
    }

    // 身份信息缓存,默认是用户名缓存
    @Override
    protected Object getAuthenticationCacheKey(AuthenticationToken token) {
        String userName = (String) token.getPrincipal();
        System.err.println("token:" + token);
        return userName;
    }

    // 获取用户信息的方法
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws FrameWorkException {
        String userName = (String) token.getPrincipal();
        UserEntity user = userService.selectUserByUserName(userName);
        if (user == null) {
            throw new FrameWorkException(Constants.CODE_UNKNOW_USER, "用户不存在或者已被删除", null, false);
        }
        if (user.getState() == 0) {
            throw new FrameWorkException(Constants.CODE_DELETE_USER, "用户已被禁用", null, false);
        }
        String password = user.getPassword();
        String salt = encryManager.getSalt(userName);
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(new ShiroPrincipal(user), password,
                new SimpleByteSource(salt.getBytes()), getName());

        return authenticationInfo;
    }

    /**
     * 支持or and not 关键词 不支持and or混用
     *
     * @param principals 凭证
     * @param permission 权限
     * @return 是否匹配
     */
    public boolean isPermitted(PrincipalCollection principals, String permission) {
        if (permission.contains(OR_OPERATOR)) {
            String[] permissions = permission.split(OR_OPERATOR);
            for (String orPermission : permissions) {
                if (orPermission.length() > 0) {
                    if (isPermittedWithNotOperator(principals, orPermission)) {
                        return true;
                    }
                }
            }
            return false;
        } else if (permission.contains(AND_OPERATOR)) {
            String[] permissions = permission.split(AND_OPERATOR);
            for (String orPermission : permissions) {
                if (orPermission.length() > 0) {
                    if (!isPermittedWithNotOperator(principals, orPermission)) {
                        return false;
                    }
                }
            }
            return true;
        } else if (permission.contains(NOT_OPERATOR)) {
            return isPermittedWithNotOperator(principals, permission);
        } else {
            return super.isPermitted(principals, permission);
        }
    }

    protected boolean isPermitted(Permission permission, AuthorizationInfo info) {
        Collection<Permission> perms = getPermissions(info);
        if (perms != null && !perms.isEmpty()) {
            for (Permission perm : perms) {
                if (perm.implies(permission)) {
                    return true;
                }
            }
        }
        return false;
    }

    private boolean isPermittedWithNotOperator(PrincipalCollection principals, String permission) {
        if (permission.startsWith(NOT_OPERATOR)) {
            return !super.isPermitted(principals, permission.substring(NOT_OPERATOR.length()));
        } else {
            return super.isPermitted(principals, permission);
        }
    }

    public void setEncryManager(EncryManager encryManager) {
        this.encryManager = encryManager;
    }

}
