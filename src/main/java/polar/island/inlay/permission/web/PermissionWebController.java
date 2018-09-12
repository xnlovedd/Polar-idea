package polar.island.inlay.permission.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import polar.island.core.controller.BasicController;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.inlay.permission.entity.PermissionEntity;
import polar.island.inlay.permission.service.PermissionService;
import polar.island.inlay.role.entity.RoleEntity;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 权限的控制器类，返回参数为页面，为配合加载，出错时为Json串，可修改@ErrorMsg标签，使其出错时返回页面。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "permissionWebController")
@RequestMapping(value = "/permission/web")
public class PermissionWebController extends BasicController {
	@Resource(name = "permissionService")
	private PermissionService permissionService;
	private  static final  String MODULE_NAME=null;
	/**
	 * 权限列表页面
	 * 
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:permission:view:list" })
	@ErrorMsg(tag = "权限列表", type = ErrorType.JSON)
	@RequestMapping(value = { "/list", "" }, produces = "text/html;charset=utf-8")
	public String list() {
		return "/view/inlay/permission/permissionList.jsp";
	}

	/**
	 * 权限列表页面
	 * 
	 * @param parentId
	 *            父级编号
	 * @param request
	 *            request对象
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:permission:add" })
	@ErrorMsg(tag = "新增权限", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "text/html;charset=utf-8")
	public String add(Long parentId, HttpServletRequest request) {
		RoleEntity entity = new RoleEntity();
		entity.setParentId(parentId);
		request.setAttribute("permission", entity);
		return "/view/inlay/permission/permissionForm.jsp";
	}

	/**
	 * 更新权限页面
	 * 
	 * @param request
	 *            request对象
	 * @param id
	 *            数据编号
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:permission:edit" })
	@ErrorMsg(tag = "更新权限", type = ErrorType.JSON)
	@RequestMapping(value = "/update", produces = "text/html;charset=utf-8")
	public String updatePage(HttpServletRequest request, String id) {
		idCheck(id,MODULE_NAME);
		PermissionEntity entity = permissionService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		request.setAttribute("permission", entity);
		return "/view/inlay/permission/permissionForm.jsp";
	}

	/**
	 * 权限的详情页面
	 * @param id 数据编号
	 * @param request request对象
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:permission:view:detail" })
	@ErrorMsg(tag = "查看权限", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "text/html;charset=utf-8")
	public String detailPage(String id, HttpServletRequest request) {
		return updatePage(request,id);
	}
}
