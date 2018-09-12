package polar.island.core.security.service;

import polar.island.core.security.entity.UserEntity;
import polar.island.core.service.BasicService;

import java.util.Map;
import java.util.Set;

/**
 * 用户基本信息管理的服务类，其实现类标签为：userService,删除模式为：全部。
 *
 * @author PolarLoves
 */
public interface UserService extends BasicService<UserEntity, UserEntity> {
    /**
     * 根据用户名查找用户。
     *
     * @param userName 用户名。
     * @return 用户
     */
    public UserEntity selectUserByUserName(String userName);

    /**
     * 登录后执行的操作，更新用户登录IP，以及登录次数。
     *
     * @param id   用户编号
     * @param host 登录域名。
     */
    public void logIn(Long id, String host);

    /**
     * 获取用户的角色
     *
     * @param userId 用户编号
     * @return 用户角色
     */
    public Set<String> userRoles(String userId);

    /**
     * 获取用户的权限
     *
     * @param userId 用户编号
     * @return 用户权限
     */
    public Set<String> userPermissions(String userId);

    /**
     * 修改用户密码
     *
     * @param userId 用户编号
     * @param oldPwd 原始密码
     * @param newPwd 新密码
     */
    public void changePassword(String userId, String oldPwd, String newPwd);

    /**
     * 禁用用户
     *
     * @param id 用户编号
     * @return 禁用数量
     */
    public Long disableUser(String id);

    /**
     * 启用用户
     *
     * @param id 用户编号
     * @return 启用数量
     */
    public Long enableUser(String id);

    public Long updateSelf(Map<String, Object> condition);
}