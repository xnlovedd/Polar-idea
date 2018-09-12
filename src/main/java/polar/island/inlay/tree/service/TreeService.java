package polar.island.inlay.tree.service;

import org.apache.ibatis.annotations.Param;
import polar.island.core.entity.DictEntity;
import polar.island.core.service.BasicService;
import polar.island.inlay.tree.entity.TreeEntity;

import java.util.List;
import java.util.Map;

/**
 * 树结构的服务类，其实现类标签为：treeService,删除模式为：仅物理删除。
 *
 * @author PolarLoves
 *
 */
public interface TreeService extends BasicService<TreeEntity, TreeEntity> {
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
	 * 根据组编号查询树信息
	 * 
	 * @param groupId
	 *            组名
	 * @return 树结构信息
	 */
	public List<TreeEntity> getTree(String groupId);
}