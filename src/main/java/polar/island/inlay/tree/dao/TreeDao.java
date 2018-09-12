package polar.island.inlay.tree.dao;

import org.apache.ibatis.annotations.Param;
import polar.island.core.dao.BasicDao;
import polar.island.core.entity.DictEntity;
import polar.island.database.DAO;
import polar.island.inlay.tree.entity.TreeEntity;

import java.util.List;
import java.util.Map;

/**
 * 树结构的持久化层。
 * 
 * @author PolarLoves
 *
 */
@DAO(value = "treeDao")
public interface TreeDao extends BasicDao<TreeEntity, TreeEntity> {
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
	 * 获取所有的组信息
	 * 
	 * @return 所有组信息
	 */
	public List<DictEntity> allGroups();

	/**
	 * 根据组编号查询数信息
	 * 
	 * @param groupId
	 *            组编号
	 * @return 查询到的数据
	 */
	public List<TreeEntity> getTree(String groupId);
}
