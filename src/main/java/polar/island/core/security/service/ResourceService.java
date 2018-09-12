package polar.island.core.security.service;

import org.apache.ibatis.annotations.Param;
import polar.island.core.security.entity.ResourceEntity;
import polar.island.core.service.BasicService;

import java.util.List;
import java.util.Map;

/**
 * 资源表信息的服务类，其实现类标签为：resourceService,删除模式为：仅物理删除。
 *
 * @author PolarLoves
 *
 */
public interface ResourceService extends BasicService<ResourceEntity, ResourceEntity> {
	/**
	 * 由于仅有物理删除，此删除方法被移除
	 * 
	 */
	@Deprecated
	public Long deleteByIdLogic(@Param(value = "id") String id);

	/**
	 * 由于仅有物理删除，此删除方法被移除
	 * 
	 */
	@Deprecated
	public Long deleteByConditionLogic(Map<String, Object> condition);

	/**
	 * 获取资源的所有权限
	 * 
	 * @return 资源的所有权限列表
	 */
	public Map<String, List<String>> resourcePermissions();
}