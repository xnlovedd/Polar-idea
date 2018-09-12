package polar.island.inlay.resource.service;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import polar.island.core.config.Constants;
import polar.island.core.entity.NameValueEntity;
import polar.island.core.exception.FrameWorkException;
import polar.island.core.security.entity.ResourceEntity;
import polar.island.core.security.service.ResourceService;
import polar.island.core.service.BasicServiceImpl;
import polar.island.inlay.permission.dao.PermissionDao;
import polar.island.inlay.resource.dao.ResourceDao;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Transactional(readOnly = true)
@Service(value = "resourceService")
public class ResourceServiceImpl extends BasicServiceImpl<ResourceEntity, ResourceEntity, ResourceDao>
		implements ResourceService {
	@Resource(name = "resourceDao")
	private ResourceDao resourceDao;
	@Resource(name = "permissionDao")
	private PermissionDao permissionDao;
	@Override
	public ResourceDao getDao() {
		return resourceDao;
	}

	@Transactional(readOnly = false)
	@Override
	public Object insert(Map<String, Object> condition) {
		try {
			resourceDao.insert(condition);
		} catch (org.springframework.dao.DuplicateKeyException e) {
			throw new FrameWorkException(Constants.CODE_SERVER_COMMON, "访问路径为\"" + condition.get("path") + "\"的资源已存在",
					null, false);
		}
		return condition.get("id");
	}
	@Override
	public Long deleteByIdPhysical(String id) {
		permissionDao.deleteResourcePermissionByResourceId(id);
		return super.deleteByIdPhysical(id);
	}
	@Override
	public Map<String, List<String>> resourcePermissions() {
		Map<String, List<String>> result = new HashMap<String,List<String>>();
		List<NameValueEntity> resources = resourceDao.allResourcesAndPermissions();
		if (!CollectionUtils.isEmpty(resources)) {
			for (NameValueEntity entity : resources) {
				String path = entity.getName();
				List<String> permission;
				if (result.containsKey(path)) {
					permission = result.get(path);
				} else {
					permission = new ArrayList<String>();
					result.put(path, permission);
				}
				permission.add(entity.getValue());
			}
		}
		return result;
	}
}