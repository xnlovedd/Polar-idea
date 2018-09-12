package polar.island.inlay.menu.dao;

import org.apache.ibatis.annotations.Param;
import polar.island.core.dao.BasicDao;
import polar.island.database.DAO;
import polar.island.inlay.menu.entity.MenuEntity;

import java.util.List;
import java.util.Map;

/**
 * 菜单的持久化层。
 * 
 * @author PolarLoves
 *
 */
@DAO(value = "menuDao")
public interface MenuDao extends BasicDao<MenuEntity, MenuEntity> {
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
	 * @return 所有的菜单
	 */
	public List<polar.island.core.entity.TreeEntity> allMenus();

	/**
	 * 获取菜单模板的所有菜单
	 * 
	 * @param menuModelId 菜单模板编号
	 * @return 查询到的菜单
	 */
	public List<MenuEntity> modelMenus(@Param(value = "menuModelId") String menuModelId);

	/**
	 * 依据菜单编号删除关联关系
	 * 
	 * @param menuId 菜单编号
	 * @return 删除的条目数量
	 */
	public Long deleteModelMenuByMenuId(@Param(value = "menuId") String menuId);

	/**
	 * 依据模板编号删除关联关系
	 * 
	 * @param modelId 模板编号
	 * @return 删除的条目数量
	 */
	public Long deleteModelMenuByModelId(@Param(value = "modelId") String modelId);

	/**
	 * 增加菜单-模板关联关系
	 * 
	 * @param condition 关联参数
	 */
	public void insertModelMenu(Map<String, Object> condition);
	/**
	 * 最大的排序号
	 * @return 最大的排序号
	 */
	public Long maxOrderNum();
	/**
	 * 获取用户的菜单
	 * @param userId 用户编号
	 * @return 用户菜单
	 */
	public List<MenuEntity> userMenus(@Param(value = "userId")String userId);
	/**
	 * 获取默认菜单
	 * @return 默认菜单
	 */
	public List<MenuEntity> defaultMenus();
	
}
