package polar.island.web.util;

import polar.island.core.entity.DictEntity;
import polar.island.core.util.GsonUtil;
import polar.island.inlay.dict.service.DictService;
import polar.island.inlay.menu.service.MenuService;
import polar.island.inlay.permission.service.PermissionService;
import polar.island.inlay.role.service.RoleService;
import polar.island.inlay.tree.entity.TreeEntity;
import polar.island.inlay.tree.service.TreeService;

import java.util.List;

public class DictUtil {
	private static DictService dictService;
	private static TreeService treeService;
	private static RoleService roleService;
	private static PermissionService permissionService;
	private static MenuService menuService;

	public static void setServices(TreeService treeService, DictService dictService, RoleService roleService,
			PermissionService permissionService, MenuService menuService) {
		DictUtil.treeService = treeService;
		DictUtil.permissionService = permissionService;
		DictUtil.dictService = dictService;
		DictUtil.roleService = roleService;
		DictUtil.menuService = menuService;
	}

	/**
	 * 获取字典数据，字典为一级目录
	 * 
	 * @param groupId
	 *            字典的组编号
	 * @return 字典数据
	 */
	public static List<DictEntity> getDict(String groupId) {
		if (groupId == null || groupId.trim().equals("")) {
			return null;
		}
		return dictService.findDictById(groupId);
	}

	/**
	 * 获取字典Json数据，字典为一级目录
	 * 
	 * @param groupId
	 *            字典的组编号
	 * @return 字典数据的json串
	 */
	public static String getDictJson(String groupId) {
		if (groupId == null || groupId.trim().equals("")) {
			return null;
		}
		return GsonUtil.toJson(dictService.findDictById(groupId));
	}

	/**
	 * 获取字典所有组信息
	 * 
	 * @return 字典的所有组信息
	 */
	public static List<DictEntity> allGroup() {
		return dictService.allGroups();
	}

	/**
	 * 获取树结构字典所有组信息
	 * 
	 * @return 字典树结构所有组信息
	 */
	public static List<DictEntity> allTreeGroup() {
		return treeService.allGroups();
	}

	/**
	 * 获取树结构列表
	 * 
	 * @param groupId
	 *            组编号
	 * @return 树结构
	 */
	public static List<TreeEntity> getTree(String groupId) {
		if (groupId == null || groupId.trim().equals("")) {
			return null;
		}
		return treeService.getTree(groupId);
	}

	/**
	 * 获取树结构列表的Json数据
	 * 
	 * @param groupId
	 *            组编号
	 * @return 树结构信息json串
	 */
	public static String getTreeJson(String groupId) {
		if (groupId == null || groupId.trim().equals("")) {
			return null;
		}
		return GsonUtil.toJson(treeService.getTree(groupId));
	}

	/**
	 * 获取所有的角色
	 * 
	 * @return 用户的所有角色
	 */
	public static List<polar.island.core.entity.TreeEntity> allRoles() {
		return roleService.allRoles();
	}

	/**
	 * 获取所有角色的json数据
	 * 
	 * @return 所有角色的json数据
	 */
	public static String allRolesJson() {
		return GsonUtil.toJson(roleService.allRoles());
	}

	/**
	 * 获取所有的权限
	 * 
	 * @return 所有的权限
	 */
	public static List<polar.island.core.entity.TreeEntity> allPermissions() {
		return permissionService.allPermission();
	}

	/**
	 * 获取所有权限的json数据
	 * 
	 * @return 所有权限的json数据
	 */
	public static String allPermissionsJson() {
		return GsonUtil.toJson(permissionService.allPermission());
	}

	/**
	 * 获取所有的菜单
	 * 
	 * @return 所有的菜单
	 */
	public static List<polar.island.core.entity.TreeEntity> allMenus() {
		return menuService.allMenus();
	}

	/**
	 * 获取所有的菜单的Json数据
	 * 
	 * @return 所有菜单的json数据
	 */
	public static String allMenusJson() {
		return GsonUtil.toJson(menuService.allMenus());
	}
}
