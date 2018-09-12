package polar.island.inlay.role.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import polar.island.core.controller.BasicController;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.inlay.permission.service.PermissionService;
import polar.island.inlay.role.entity.RoleEntity;
import polar.island.inlay.role.service.RoleService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 角色的控制器类，返回参数为页面，为配合加载，出错时为Json串，可修改@ErrorMsg标签，使其出错时返回页面。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "roleWebController")
@RequestMapping(value = "/role/web")
public class RoleWebController extends BasicController {
	@Resource(name = "roleService")
	private RoleService roleService;
	@Resource(name = "permissionService")
	private PermissionService permissionService;
	private  static final  String MODULE_NAME="角色";
	/**
	 * 角色管理列表页面
	 * 
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:role:view:list" })
	@ErrorMsg(tag = "角色列表", type = ErrorType.JSON)
	@RequestMapping(value = { "/list", "" }, produces = "text/html;charset=utf-8")
	public String list() {
		return "/view/inlay/role/roleList.jsp";
	}

	/**
	 * 角色管理列表页面
	 * 
	 * @param parentId
	 *            上级编号
	 * @param request
	 *            request对象
	 * @return 列表页面
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:role:add" })
	@ErrorMsg(tag = "角色列表", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "text/html;charset=utf-8")
	public String add(Long parentId, HttpServletRequest request) {
		RoleEntity entity = new RoleEntity();
		entity.setParentId(parentId);
		request.setAttribute("role", entity);
		return "/view/inlay/role/roleForm.jsp";
	}

	/**
	 * 更新角色页面
	 * 
	 * @param request
	 *            request对象
	 * @param id
	 *            数据编号
	 * @return 更新角色页面
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:role:edit" })
	@ErrorMsg(tag = "更新角色", type = ErrorType.JSON)
	@RequestMapping(value = "/update", produces = "text/html;charset=utf-8")
	public String updatePage(HttpServletRequest request, String id) {
		idCheck(id,MODULE_NAME);
		RoleEntity entity = roleService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		request.setAttribute("role", entity);
		return "/view/inlay/role/roleForm.jsp";
	}

	/**
	 * 查看角色页面
	 * 
	 * @param id
	 *            数据编号
	 * @param request
	 *            request对象
	 * @return 详情页面
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:role:view:detail" })
	@ErrorMsg(tag = "查看角色", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "text/html;charset=utf-8")
	public String detailPage(String id, HttpServletRequest request) {
		return updatePage(request,id);
	}

	/**
	 * 查看用户角色页面
	 * 
	 * @param id
	 *            数据编号
	 * @param request
	 *            request对象
	 * @return 角色详情页面
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:role:permission" })
	@ErrorMsg(tag = "查看角色权限", type = ErrorType.JSON)
	@RequestMapping(value = "/rolePermission", produces = "text/html;charset=utf-8")
	public String rolePermission(String id, HttpServletRequest request) {
		idCheck(id,MODULE_NAME);
		RoleEntity entity = roleService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		request.setAttribute("id", id);
		request.setAttribute("allPermissions", permissionService.allPermission());
		request.setAttribute("rolePermissions", permissionService.rolePermissions(id));
		return "/view/inlay/role/rolePermission.jsp";
	}
}
