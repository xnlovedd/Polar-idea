package polar.island.inlay.role.dao;

import org.apache.ibatis.annotations.Param;
import polar.island.core.dao.BasicDao;
import polar.island.database.DAO;
import polar.island.inlay.role.entity.RoleEntity;

import java.util.List;
import java.util.Map;

/**
 * 角色的持久化层。
 * 
 * @author PolarLoves
 *
 */
@DAO(value = "roleDao")
public interface RoleDao extends BasicDao<RoleEntity, RoleEntity> {
	/**
	 * 由于仅有物理删除，此删除方法被移除
	 */
	@Deprecated
	public Long deleteByIdLogic(@Param(value = "id") String id);

	/**
	 * 由于仅有物理删除，此删除方法被移除
	 */
	@Deprecated
	public Long deleteByConditionLogic(Map<String, Object> condition);

	/**
	 * 获取所有的角色
	 * 
	 * @return 所有的角色
	 */
	public List<polar.island.core.entity.TreeEntity> allRoles();

	/**
	 * 删除用户的角色
	 * 
	 * @param userId
	 *            用户角色
	 * @return 删除的条目
	 */
	public Long deleteUserRoleByUserId(@Param(value = "userId") String userId);

	/**
	 * 删除用户的角色
	 * 
	 * @param roleId
	 *            角色编号
	 * @return 删除的条目
	 */
	public Long deleteUserRoleByRoleId(@Param(value = "roleId") String roleId);

	/**
	 * 获取用户所有的角色
	 * 
	 * @param userId
	 *            用户编号
	 * @return 用户角色
	 */
	public List<RoleEntity> userRoles(@Param(value = "userId") String userId);

	/**
	 * 添加用户的角色
	 * 
	 * @param condition
	 *            用户角色信息
	 */
	public void insertUserRole(Map<String, Object> condition);

	/**
	 * 获取最大的排序号
	 * 
	 * @return 最大的排序号
	 */
	public Long maxOrderNum();
}
