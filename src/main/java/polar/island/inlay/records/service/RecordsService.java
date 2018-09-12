package polar.island.inlay.records.service;

import polar.island.core.service.BasicService;
import polar.island.inlay.records.entity.RecordsEntity;

import java.util.Map;
/**
 * 访问记录的服务类，其实现类标签为：recordsService,删除模式为：仅物理删除。
 *
 * @author  PolarLoves
 *
 */
public interface RecordsService extends BasicService<RecordsEntity,RecordsEntity> {
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
}