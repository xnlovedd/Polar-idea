package polar.island.inlay.user.dao;

import org.apache.ibatis.annotations.Param;
import polar.island.core.dao.BasicDao;
import polar.island.core.security.entity.UserEntity;
import polar.island.database.DAO;

import java.util.List;
import java.util.Map;

/**
 * 用户的持久化层。
 *
 * @author PolarLoves
 */
@DAO(value = "userDao")
public interface UserDao extends BasicDao<UserEntity, UserEntity> {
    /**
     * 用户登录后，修改数据
     *
     * @param condition 用户信息
     */
    public void logIn(Map<String, Object> condition);

    /**
     * 获取用户的所有角色
     *
     * @param condition 用户信息
     * @return 用户角色
     */
    public List<String> userRoles(Map<String, Object> condition);

    /**
     * 获取用户的所有权限
     *
     * @param condition 用户信息
     * @return 用户的权限
     */
    public List<String> userPermissions(Map<String, Object> condition);

    /**
     * 禁用用户
     *
     * @param id 用户编号
     * @return 禁用用户数量
     */
    public Long disableUser(@Param(value = "id") String id);

    /**
     * 启用用户
     *
     * @param id 用户编号
     * @return 启用用户数量
     */
    public Long enableUser(@Param(value = "id") String id);

    /**
     * 更新用户基本信息
     *
     * @param condition 用户信息
     * @return 更新数量
     */
    public Long updateSelf(Map<String, Object> condition);

    /**
     * 获取用户的所有部门权限
     *
     * @param condition 用户信息
     * @return 用户的所有部门权限
     */
    public List<String> orgPermissions(Map<String, Object> condition);

}
