package polar.island.inlay.resource.dao;

import org.apache.ibatis.annotations.Param;
import polar.island.core.dao.BasicDao;
import polar.island.core.entity.NameValueEntity;
import polar.island.core.security.entity.ResourceEntity;
import polar.island.database.DAO;

import java.util.List;
import java.util.Map;

/**
 * 资源的持久化层。
 * 
 * @author PolarLoves
 *
 */
@DAO(value = "resourceDao")
public interface ResourceDao extends BasicDao<ResourceEntity, ResourceEntity> {
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
	 * 获取所有的资源以及权限信息
	 * 
	 * @return 资源以及权限信息
	 */
	public List<NameValueEntity> allResourcesAndPermissions();

}
