package polar.island.inlay.logs.dao;

import org.apache.ibatis.annotations.Param;
import polar.island.core.dao.BasicDao;
import polar.island.database.DAO;
import polar.island.inlay.logs.entity.LogsEntity;

import java.util.Map;
/**
 * 日志记录表的持久化层。
 * 
 * @author PolarLoves
 *
 */
@DAO(value="logsDao")
public interface LogsDao extends BasicDao<LogsEntity,LogsEntity> {
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
