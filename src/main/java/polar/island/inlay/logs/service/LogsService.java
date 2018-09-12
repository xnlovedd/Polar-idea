package polar.island.inlay.logs.service;

import org.apache.ibatis.annotations.Param;
import polar.island.core.service.BasicService;
import polar.island.inlay.logs.entity.LogsEntity;

import java.util.Map;
/**
 * 日志记录表,用来记录通用产出的错误信息。的服务类，其实现类标签为：logsService,删除模式为：仅物理删除。
 *
 * @author  PolarLoves
 *
 */
public interface LogsService extends BasicService<LogsEntity,LogsEntity> {
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