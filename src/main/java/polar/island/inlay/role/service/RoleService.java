package polar.island.inlay.role.service;

import polar.island.core.service.BasicService;
import polar.island.inlay.role.entity.RoleEntity;

import java.util.List;
import java.util.Map;

/**
 * 角色管理的服务类，其实现类标签为：roleService,删除模式为：仅物理删除。
 *
 * @author PolarLoves
 *
 */
public interface RoleService extends BasicService<RoleEntity, RoleEntity> {
	/**
	 * 由于仅有物理删除，此删除方法被移除
	 */
	@Deprecated
	public Long deleteByIdLogic(String id);

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
	 * 更新用户的角色
	 * 
	 * @param userId
	 *            用户编号
	 * @param roleId
	 *            角色编号
	 */
	public void updateUserRoles(String userId, String[] roleId);

	/**
	 * 获取用户所有的角色
	 * 
	 * @param userId
	 *            用户编号
	 * @return 用户的角色
	 */
	public List<RoleEntity> userRoles(String userId);
}