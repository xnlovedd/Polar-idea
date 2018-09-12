package polar.island.inlay.dict.dao;

import org.apache.ibatis.annotations.Param;
import polar.island.core.dao.BasicDao;
import polar.island.database.DAO;
import polar.island.inlay.dict.entity.DictEntity;

import java.util.List;
import java.util.Map;

/**
 * 字典的持久化层。
 * 
 * @author PolarLoves
 *
 */
@DAO(value = "dictDao")
public interface DictDao extends BasicDao<DictEntity, DictEntity> {
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
	 * @return 所有查询到的组信息。
	 */
	public List<polar.island.core.entity.DictEntity> allGroups();

	/**
	 * 依据组编号查询组信息
	 * 
	 * @param id
	 *            组编号
	 * @return 字典信息
	 */
	public List<polar.island.core.entity.DictEntity> findDictById(String id);
}
