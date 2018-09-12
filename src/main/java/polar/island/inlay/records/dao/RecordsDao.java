package polar.island.inlay.records.dao;

import org.apache.ibatis.annotations.Param;
import polar.island.core.dao.BasicDao;
import polar.island.database.DAO;
import polar.island.inlay.records.entity.RecordsEntity;

import java.util.Map;
/**
 * 访问记录的持久化层。
 * 
 * @author PolarLoves
 *
 */
@DAO(value="recordsDao")
public interface RecordsDao extends BasicDao<RecordsEntity,RecordsEntity> {
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
}
