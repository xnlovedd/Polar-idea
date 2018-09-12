package polar.island.inlay.permission.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import polar.island.core.config.Constants;
import polar.island.core.entity.TreeEntity;
import polar.island.core.exception.FrameWorkException;
import polar.island.core.service.BasicServiceImpl;
import polar.island.inlay.permission.dao.PermissionDao;
import polar.island.inlay.permission.entity.PermissionEntity;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Transactional(readOnly = true)
@Service(value = "permissionService")
public class PermissionServiceImpl extends BasicServiceImpl<PermissionEntity, PermissionEntity, PermissionDao>
		implements PermissionService {
	@Resource(name = "permissionDao")
	private PermissionDao permissionDao;

	@Override
	public PermissionDao getDao() {
		return permissionDao;
	}

	@Transactional(readOnly = false)
	@Override
	public Object insert(Map<String, Object> condition) {
		try {
			permissionDao.insert(condition);
		} catch (org.springframework.dao.DuplicateKeyException e) {
			throw new FrameWorkException(Constants.CODE_SERVER_COMMON, "标识为\"" + condition.get("name") + "\"的权限已存在",
					null, false);
		}
		return condition.get("id");
	}

	@Override
	public List<TreeEntity> allPermission() {
		return permissionDao.allPermission();
	}

	@Transactional(readOnly = false)
	@Override
	public Long deleteByIdPhysical(String id) {
		List<TreeEntity> all = permissionDao.allPermission();
		Long count = deletePermission(id, all, 0l);
		return count;
	}

	private Long deletePermission(String id, List<TreeEntity> all, Long count) {
		// 删除此id的数据
		count = count + permissionDao.deleteByIdPhysical(id);
		// 删除角色-权限数据。
		permissionDao.deleteRolePermissionByPermissionId(id);
		if (all != null && all.size() > 0) {
			for (TreeEntity entity : all) {
				if (id.equals(entity.getParentId() + "")) {
					count =deletePermission(entity.getId(), all, count);
				}
			}
		}
		return count;
	}

	@Override
	public List<PermissionEntity> rolePermissions(String roleId) {
		return permissionDao.rolePermissions(roleId);
	}

	@Transactional(readOnly = false)
	@Override
	public void updateRolePermissions(String roleId, String[] permissionIds) {
		permissionDao.deleteRolePermissionByRoleId(roleId);
		if (permissionIds != null && permissionIds.length > 0) {
			for (String id : permissionIds) {
				Map<String, Object> condition = new HashMap<String,Object>();
				condition.put("permissionId", id);
				condition.put("roleId", roleId);
				permissionDao.insertRolePermission(condition);
			}
		}
	}

	@Transactional(readOnly = false)
	@Override
	public void updateResourcePermissions(String resourceId, String[] permissionIds) {
		permissionDao.deleteResourcePermissionByResourceId(resourceId);
		if (permissionIds != null && permissionIds.length > 0) {
			for (String id : permissionIds) {
				Map<String, Object> condition = new HashMap<String,Object>();
				condition.put("permissionId", id);
				condition.put("resourceId", resourceId);
				permissionDao.insertResourcePermission(condition);
			}
		}
	}

	@Override
	public List<PermissionEntity> orgPermissions(String orgId) {
		return permissionDao.orgPermissions(orgId);
	}
	@Transactional(readOnly = false)
	@Override
	public void updateOrgPermissions(String orgId, String[] permissionIds) {
		permissionDao.deleteOrgPermissionByOrgId(orgId);
		if (permissionIds != null && permissionIds.length > 0) {
			for (String id : permissionIds) {
				Map<String, Object> condition = new HashMap<String,Object>();
				condition.put("permissionId", id);
				condition.put("orgId", orgId);
				permissionDao.insertOrgPermission(condition);
			}
		}
	}


	@Override
	public List<PermissionEntity> resourcePermissions(String resourceId) {
		return permissionDao.resourcePermissions(resourceId);
	}
}