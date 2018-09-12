package polar.island.inlay.user.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.session.ExpiredSessionException;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.DefaultSessionKey;
import org.apache.shiro.session.mgt.SessionManager;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import polar.island.core.config.Constants;
import polar.island.core.controller.BasicController;
import polar.island.core.entity.ResponseJson;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.core.exception.ValidationException;
import polar.island.core.security.EncryManager;
import polar.island.core.security.entity.UserEntity;
import polar.island.core.security.service.UserService;
import polar.island.core.util.CommonUtil;
import polar.island.inlay.menu.service.MenuService;
import polar.island.inlay.menuModel.service.MenuModelService;
import polar.island.inlay.role.service.RoleService;
import polar.island.security.service.SecurityService;
import polar.island.web.util.UserUtil;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.io.Serializable;
import java.util.Date;
import java.util.Deque;
import java.util.Map;

/**
 * 用户的接口，返回数据全部为json串。
 *
 * @author PolarLoves
 */
@Controller(value = "userJsonController")
@RequestMapping(value = "/user/json")
public class UserJsonController extends BasicController {
    @Resource(name = "userService")
    private UserService userService;
    @Resource(name = "encryManager")
    private EncryManager encryManager;
    @Resource(name = "roleService")
    private RoleService roleService;
    @Resource(name = "menuModelService")
    private MenuModelService menuModelService;
    @Resource(name = "menuService")
    private MenuService menuService;
    @Resource(name = "securityService")
    private SecurityService securityService;
    @Resource(name = "shiroCacheManager")
    private CacheManager cacheManager;
    @Resource(name = "sessionManager")
    private SessionManager sessionManager;
    private static final String MODULE_NAME = "用户";

    /**
     * 依据条件查询分页数据，如果不传页码、每页条目，则默认分别为：1,10
     *
     * @param entity 查询条件
     * @return 列表Json串。
     * @see polar.island.core.security.entity.UserEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:view:list"})
    @ErrorMsg(tag = "查询用户", type = ErrorType.JSON)
    @RequestMapping(value = "/pageList", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson pageList(UserEntity entity) {
        Map<String, Object> condition = beanToMap(entity);
        return new ResponseJson(Constants.CODE_SUCCESS, userService.selectPageList(condition), null,
                userService.selectCount(condition));
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:view:detail"})
    @ErrorMsg(tag = "查看用户", type = ErrorType.JSON)
    @RequestMapping(value = "/detail", produces = "application/json;charset=utf-8")
    public ResponseJson detail(String id) {
        idCheck(id, MODULE_NAME);
        UserEntity entity = userService.selectOneById(id);
        existCheck(entity, MODULE_NAME);
        return new ResponseJson(Constants.CODE_SUCCESS, entity);
    }

    /**
     * 校验访问权限
     *
     * @return
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:empty"})
    @ErrorMsg(tag = "校验用户权限", type = ErrorType.JSON)
    @RequestMapping(value = "/checkPermission", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson checkPermission() {
        return new ResponseJson(Constants.CODE_SUCCESS);
    }

    /**
     * 依据数据编号更新此条数据的所有值其‘有效性’字段不会更新
     *
     * @param entity 需要更新的实体
     * @return 更新条目
     * @see polar.island.core.security.entity.UserEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:edit"})
    @ErrorMsg(tag = "更新用户全部字段", type = ErrorType.JSON)
    @RequestMapping(value = "/updateAllById", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson updateAllById(@Valid UserEntity entity, BindingResult bindingResult) {
        validate(UserEntity.class, "updateAllById", bindingResult);
        Map<String, Object> condition = beanToMap(entity);
        Long result = userService.updateAll(condition);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
    }

    @RequiresUser
    @ErrorMsg(tag = "更新用户全部字段", type = ErrorType.JSON)
    @RequestMapping(value = "/updateSelf", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson updateSelf(@Valid UserEntity entity, BindingResult bindingResult) {
        entity.setId(CommonUtil.str2Long(UserUtil.getUserId()));
        entity.setUserName(UserUtil.getUserName());
        validate(UserEntity.class, "updateSelf", bindingResult);
        Map<String, Object> condition = beanToMap(entity);
        Long result = userService.updateSelf(condition);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "修改成功");
    }

    @RequiresUser
    @ErrorMsg(tag = "修改密码", type = ErrorType.JSON)
    @RequestMapping(value = "/updatePwd", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson updatePwd(String oldPwd, String newPwd) {
        if (oldPwd == null) {
            throw new ValidationException("原始密码不能为空", null);
        }
        if (newPwd == null) {
            throw new ValidationException("新密码不能为空", null);
        }
        UserEntity user = userService.selectOneById(UserUtil.getUserId());
        userService.changePassword(user.getId() + "", oldPwd, newPwd);
        securityService.clearUserInfoCache(user.getId() + "");
        return new ResponseJson(Constants.CODE_SUCCESS, null, "密码修改成功");
    }

    /**
     * 依据数据编号更新此条数据的所有值其‘有效性’字段不会更新
     *
     * @param entity 需要更新的实体
     * @return 更新条目
     * @see polar.island.core.security.entity.UserEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:edit"})
    @ErrorMsg(tag = "更新用户单个字段", type = ErrorType.JSON)
    @RequestMapping(value = "/updateField", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson updateField(@Valid UserEntity entity, BindingResult bindingResult) {
        validate(UserEntity.class, "updateField", bindingResult);
        Map<String, Object> condition = beanToSingleField(entity);
        condition.put("id", entity.getId());
        Long result = userService.updateField(condition);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
    }

    /**
     * 根据数据编号逻辑删除数据。
     *
     * @param ids 数据编号
     * @return 删除结果。
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:delete"})
    @ErrorMsg(tag = "删除多个用户", type = ErrorType.JSON)
    @RequestMapping(value = "/deleteMulitById", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson deleteMulitById(@RequestParam(value = "ids[]", required = false) String[] ids) {
        idCheck(ids, MODULE_NAME);
        for (String id : ids) {
            removeUserCaches(id, "此用户已被删除，您已被强制下线");
        }
        Long result = userService.deleteMulitByIdPhysical(ids);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
    }

    /**
     * 根据数据编号逻辑删除数据。
     *
     * @param id 数据编号
     * @return 删除结果。
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:delete"})
    @ErrorMsg(tag = "删除一个用户", type = ErrorType.JSON)
    @RequestMapping(value = "/deleteById", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson deleteById(String id) {
        idCheck(id, MODULE_NAME);
        removeUserCaches(id, "此用户已被删除，您已被强制下线");
        Long result = userService.deleteByIdPhysical(id);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:disableUser"})
    @ErrorMsg(tag = "禁用用户", type = ErrorType.JSON)
    @RequestMapping(value = "/disableUser", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson disableUser(String id) {
        idCheck(id, MODULE_NAME);
        removeUserCaches(id, "此用户已被禁用，您已被强制下线");
        Long result = userService.disableUser(id);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "禁用成功。");
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:enableUser"})
    @ErrorMsg(tag = "启用用户", type = ErrorType.JSON)
    @RequestMapping(value = "/enableUser", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson enableUser(String id) {
        idCheck(id, MODULE_NAME);
        Long result = userService.enableUser(id);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "启用成功。");
    }

    /**
     * 新增一条数据。
     *
     * @param entity 数据
     * @return 新增结果。
     * @see polar.island.core.security.entity.UserEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:add"})
    @ErrorMsg(tag = "新增用户", type = ErrorType.JSON)
    @RequestMapping(value = "/add", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson add(@Valid UserEntity entity, BindingResult bindingResult) {
        entity.setCreateDate(new Date());
        entity.setLogCount(0L);
        // 设置默认密码为admin
        entity.setPassword(
                encryManager.encry(entity.getUserName(), "admin", encryManager.getSalt(entity.getUserName())));
        entity.setState(1);
        validate(UserEntity.class, "add", bindingResult);
        Map<String, Object> condition = beanToMap(entity);
        Object result = userService.insert(condition);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "新增成功。");
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:role:empty"})
    @ErrorMsg(tag = "修改用户角色", type = ErrorType.JSON)
    @RequestMapping(value = "/updateUserRole", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson updateUserRole(String id, @RequestParam(value = "roleIds[]", required = false) String[] roleIds) {
        idCheck(id, MODULE_NAME);
        roleService.updateUserRoles(id, roleIds);
        return new ResponseJson(Constants.CODE_SUCCESS, null, "用户角色修改成功");
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:menu"})
    @ErrorMsg(tag = "修改用户菜单", type = ErrorType.JSON)
    @RequestMapping(value = "/updateUserMenuModels", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson updateUserMenuModels(String id, String menuModelId) {
        idCheck(id, MODULE_NAME);
        menuModelService.updateUserMenuModels(id, menuModelId);
        return new ResponseJson(Constants.CODE_SUCCESS, null, "用户菜单修改成功");
    }

    /**
     * 清空用户菜单缓存
     *
     * @param userIds 用户编号
     * @return 成功或者失败的json串
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:clear:userMenu"})
    @ErrorMsg(tag = "清除用户菜单缓存", type = ErrorType.JSON)
    @RequestMapping(value = "/clearUserMenuCache", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson clearUserMenuCache(@RequestParam(value = "userIds[]", required = false) String[] userIds) {
        idCheck(userIds, MODULE_NAME);
        for (String userId : userIds) {
            menuService.clearUserMenusCache(userId);
        }
        return new ResponseJson(Constants.CODE_SUCCESS, null, "缓存清除成功。");
    }

    /**
     * 清空用户菜单所有缓存
     *
     * @return 成功或者失败的json串
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:clear:allMenu"})
    @ErrorMsg(tag = "清除用户菜单缓存", type = ErrorType.JSON)
    @RequestMapping(value = "/clearAllUserMenuCache", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson clearAllUserMenuCache() {
        menuService.clearAllMenusCache();
        return new ResponseJson(Constants.CODE_SUCCESS, null, "缓存清除成功。");
    }

    /**
     * 清除用户权限缓存
     *
     * @param userIds 用户编号
     * @return 成功或者失败的json串
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:clear:userInfo"})
    @ErrorMsg(tag = "清除用户权限缓存", type = ErrorType.JSON)
    @RequestMapping(value = "/clearUserInfo", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson clearUserInfo(@RequestParam(value = "userIds[]", required = false) String[] userIds) {
        idCheck(userIds, MODULE_NAME);
        for (String userId : userIds) {
            securityService.clearUserPermissionCache(userId);
        }
        return new ResponseJson(Constants.CODE_SUCCESS, null, "缓存清除成功。");
    }

    /**
     * 清除用户所有权限缓存
     *
     * @return 成功或者失败的json串
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:user:clear:allInfo"})
    @ErrorMsg(tag = "清除用户权限缓存", type = ErrorType.JSON)
    @RequestMapping(value = "/clearAllUserInfo", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson clearAllUserInfo() {
        securityService.clearAllUserPermissionCache();
        return new ResponseJson(Constants.CODE_SUCCESS, null, "缓存清除成功。");
    }


    private void removeUserCaches(String id, String message) {
        Cache<String, Deque<Serializable>> activeUserCache = cacheManager.getCache("activeUsers");
        Deque<Serializable> caches = activeUserCache.get(id);
        while (caches.size() > 0) {
            Serializable kickoutSessionId = caches.removeFirst();
            try {
                Session session = sessionManager.getSession(new DefaultSessionKey(kickoutSessionId));
                if (session != null) {
                    session.setAttribute(Constants.FORCE_DOWNLINE_FLAG, true);
                    session.setAttribute(Constants.FORCE_DOWNLINE_MSG, message);
                }
            } catch (ExpiredSessionException e) {
            }
        }
        UserEntity userEntity = userService.selectOneById(id);
        if (userEntity != null) {
            //移除用户信息缓存
            securityService.clearUserInfoCache(userEntity.getUserName());
        }
        activeUserCache.put(id, caches);
    }
}
