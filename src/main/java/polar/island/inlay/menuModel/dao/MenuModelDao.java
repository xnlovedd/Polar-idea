package polar.island.inlay.menuModel.dao;

import org.apache.ibatis.annotations.Param;
import polar.island.core.dao.BasicDao;
import polar.island.database.DAO;
import polar.island.inlay.menuModel.entity.MenuModelEntity;

import java.util.List;
import java.util.Map;

/**
 * 菜单模板的持久化层。
 * 
 * @author PolarLoves
 *
 */
@DAO(value = "menuModelDao")
public interface MenuModelDao extends BasicDao<MenuModelEntity, MenuModelEntity> {
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

	public void cleanDefault();

	/**
	 * 获取用户的所有菜单
	 * 
	 * @param userId
	 *            用户编号
	 * @return 用户菜单
	 */
	public List<MenuModelEntity> userMenuModels(@Param(value = "userId") String userId);

	/**
	 * 依据用户编号删除用户-菜单模板
	 * 
	 * @param userId
	 *            用户编号
	 * @return 删除的条目
	 */
	public Long deleteUserMenuByUserId(@Param(value = "userId") String userId);

	/**
	 * 依据菜单模板编号删除用户-菜单模板
	 * 
	 * @param menuModelId
	 *            菜单模板编号
	 * @return 删除的条目
	 */
	public Long deleteUserMenuByMenuModelId(@Param(value = "menuModelId") String menuModelId);

	/**
	 * 增加用户菜单
	 * 
	 * @param condition
	 *            用户菜单数据
	 */
	public void insertUserMenu(Map<String, Object> condition);
}
