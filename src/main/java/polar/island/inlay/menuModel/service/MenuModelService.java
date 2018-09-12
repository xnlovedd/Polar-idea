package polar.island.inlay.menuModel.service;

import polar.island.core.service.BasicService;
import polar.island.inlay.menuModel.entity.MenuModelEntity;

import java.util.List;
import java.util.Map;

/**
 * 菜单模板的服务类，其实现类标签为：menuModelService,删除模式为：仅物理删除。
 *
 * @author PolarLoves
 *
 */
public interface MenuModelService extends BasicService<MenuModelEntity, MenuModelEntity> {
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
	 * 设置为默认模板
	 * 
	 * @param id
	 *            默认模板编号
	 */
	public void setDefault(String id);

	/**
	 * 获取用户的所有菜单
	 * 
	 * @param userId
	 *            用户编号
	 * @return 用户菜单模板
	 */
	public List<MenuModelEntity> userMenuModels(String userId);

	/**
	 * 修改用户菜单
	 * 
	 * @param userId
	 *            用户菜单
	 * @param menuModelId
	 *            用户菜单模板编号
	 */
	public void updateUserMenuModels(String userId, String menuModelId);
}