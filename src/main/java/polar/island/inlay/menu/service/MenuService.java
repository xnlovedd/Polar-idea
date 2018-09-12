package polar.island.inlay.menu.service;

import org.apache.ibatis.annotations.Param;
import polar.island.core.service.BasicService;
import polar.island.inlay.menu.entity.MenuEntity;

import java.util.List;
import java.util.Map;

/**
 * 菜单的服务类，其实现类标签为：menuService,删除模式为：仅物理删除。
 *
 * @author PolarLoves
 *
 */
public interface MenuService extends BasicService<MenuEntity, MenuEntity> {
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
	 * 获取所有的菜单
	 * 
	 * @return 所有菜单信息
	 */
	public List<polar.island.core.entity.TreeEntity> allMenus();

	/**
	 * 获取菜单模板的所有菜单
	 * 
	 * @param menuModelId 菜单模板编号
	 * @return 菜单信息
	 */
	public List<MenuEntity> modelMenus(String menuModelId);

	/**
	 * 更新模板的菜单
	 * 
	 * @param modelId 菜单模板编号
	 * @param menuId 菜单编号
	 */
	public void updateModelMenus(String modelId, String[] menuId);

	/**
	 * 最大的排序号
	 * 
	 * @return 最大的排序号
	 */
	public Long maxOrderNum();

	/**
	 * 获取用户菜单
	 * 
	 * @param userId 用户编号
	 * @return 用户菜单
	 */
	public List<MenuEntity> userMenus(String userId);

	/**
	 * 清空用户菜单缓存
	 * 
	 * @param userId 用户编号
	 */
	public void clearUserMenusCache(String userId);
	
	public void clearAllMenusCache();
}