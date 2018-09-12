package polar.island.inlay.dict.service;

import org.apache.ibatis.annotations.Param;
import polar.island.core.service.BasicService;
import polar.island.inlay.dict.entity.DictEntity;

import java.util.List;
import java.util.Map;

/**
 * 字典数据的服务类，其实现类标签为：dictService,删除模式为：仅物理删除。
 *
 * @author PolarLoves
 *
 */
public interface DictService extends BasicService<DictEntity, DictEntity> {
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
	 * 获取所有的组信息。
	 * 
	 * @return 所有组信息
	 */
	public List<polar.island.core.entity.DictEntity> allGroups();
	@Override
	public Object insert(Map<String, Object> condition) ;
	@Override
	public Long updateAll(Map<String, Object> condition) ;
	@Override
	public Long deleteByIdPhysical(String id);
	@Override
	public Long updateField(Map<String, Object> condition);
	@Override
	public Long deleteMulitByIdPhysical(String[] ids);
	/**
	 * 依据组编号查询组信息
	 * 
	 * @param id
	 *            组编号
	 * @return 组信息
	 */
	public List<polar.island.core.entity.DictEntity> findDictById(String id);
}