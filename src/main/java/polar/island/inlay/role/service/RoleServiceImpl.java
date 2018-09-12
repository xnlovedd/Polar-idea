package polar.island.inlay.role.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import polar.island.core.config.Constants;
import polar.island.core.entity.TreeEntity;
import polar.island.core.exception.FrameWorkException;
import polar.island.core.service.BasicServiceImpl;
import polar.island.inlay.permission.dao.PermissionDao;
import polar.island.inlay.role.dao.RoleDao;
import polar.island.inlay.role.entity.RoleEntity;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Transactional(readOnly = true)
@Service(value = "roleService")
public class RoleServiceImpl extends BasicServiceImpl<RoleEntity, RoleEntity, RoleDao> implements RoleService {
	@Resource(name = "roleDao")
	private RoleDao roleDao;
	@Resource(name = "permissionDao")
	private PermissionDao permissionDao;

	@Override
	public RoleDao getDao() {
		return roleDao;
	}

	@Transactional(readOnly = false)
	@Override
	public Object insert(Map<String, Object> condition) {
		try {
			roleDao.insert(condition);
		} catch (org.springframework.dao.DuplicateKeyException e) {
			throw new FrameWorkException(Constants.CODE_SERVER_COMMON, "标识为\"" + condition.get("name") + "\"的角色已存在",
					null, false);
		}
		return condition.get("id");
	}

	@Override
	public List<TreeEntity> allRoles() {
		return roleDao.allRoles();
	}

	@Transactional(readOnly = false)
	@Override
	public void updateUserRoles(String userId, String[] roleId) {
		roleDao.deleteUserRoleByUserId(userId);
		if (roleId != null && roleId.length > 0) {
			for (String id : roleId) {
				Map<String, Object> condition = new HashMap<String,Object>();
				condition.put("userId", userId);
				condition.put("roleId", id);
				roleDao.insertUserRole(condition);
			}
		}
	}

	@Transactional(readOnly = false)
	@Override
	public Long deleteByIdPhysical(String id) {
		List<TreeEntity> all = roleDao.allRoles();
		Long count = deleteRoles(id, all, 0l);
		return count;
	}

	private Long deleteRoles(String id, List<TreeEntity> all, Long count) {
		// 删除此id的数据
		count = count + roleDao.deleteByIdPhysical(id + "");
		// 删除角色-权限数据。
		permissionDao.deleteRolePermissionByRoleId(id);
		// 删除用户-角色数据
		roleDao.deleteUserRoleByRoleId(id);
		if (all != null && all.size() > 0) {
			for (TreeEntity entity : all) {
				if (id.equals(entity.getParentId() + "")) {
					count = deleteRoles(entity.getId(), all, count);
				}
			}
		}
		return count;
	}

	@Override
	public List<RoleEntity> userRoles(String userId) {
		return roleDao.userRoles(userId);
	}
}