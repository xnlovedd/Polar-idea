package polar.island.inlay.resource.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import polar.island.core.controller.BasicController;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.core.security.entity.ResourceEntity;
import polar.island.core.security.service.ResourceService;
import polar.island.inlay.permission.service.PermissionService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 资源的控制器类，返回参数为页面，为配合加载，出错时为Json串，可修改@ErrorMsg标签，使其出错时返回页面。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "resourceWebController")
@RequestMapping(value = "/resource/web")
public class ResourceWebController extends BasicController {
	@Resource(name = "resourceService")
	private ResourceService resourceService;
	@Resource(name = "permissionService")
	private PermissionService permissionService;
	private  static final  String MODULE_NAME="资源";
	/**
	 * 资源表信息列表页面
	 * 
	 * @return 列表页面，如出错，则返回Json串。	
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:resource:view:list"})
	@ErrorMsg(tag = "资源列表", type = ErrorType.JSON)
	@RequestMapping(value = { "/list", "" }, produces = "text/html;charset=utf-8")
	public String list() {
		return "/view/inlay/resource/resourceList.jsp";
	}
	/**
	 * 资源新增页面
	 * @param request request对象
	 * @return 增加页面
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:resource:add"})
	@ErrorMsg(tag = "新增资源", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "text/html;charset=utf-8")
	public String add(HttpServletRequest request) {
		ResourceEntity entity = new ResourceEntity();
		request.setAttribute("resource", entity);
		return "/view/inlay/resource/resourceForm.jsp";
	}
	/**
	 * 更新资源表信息页面
	 * @param request request对象
	 * @param id 数据编号
	 * @return 更新页面
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:resource:edit"})
	@ErrorMsg(tag = "更新资源", type = ErrorType.JSON)
	@RequestMapping(value = "/update", produces = "text/html;charset=utf-8")
	public String updatePage(HttpServletRequest request, String id) {
		idCheck(id,MODULE_NAME);
		ResourceEntity entity = resourceService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		request.setAttribute("resource", entity);
		return "/view/inlay/resource/resourceForm.jsp";
	}
	/**
	 * 资源表信息的详情页面
	 * @param id 数据编号
	 * @param request request对象
	 * @return 资源详情页面
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:resource:view:detail"})
	@ErrorMsg(tag = "查看资源", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "text/html;charset=utf-8")
	public String detailPage(String id, HttpServletRequest request) {
		return updatePage(request,id);
	}
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:resource:permission"})
	@ErrorMsg(tag = "查看资源权限", type = ErrorType.JSON)
	@RequestMapping(value = "/resourcePermission", produces = "text/html;charset=utf-8")
	public String resourcePermission(String id, HttpServletRequest request) {
		idCheck(id,MODULE_NAME);
		ResourceEntity entity = resourceService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		request.setAttribute("id", id);
		request.setAttribute("allPermissions", permissionService.allPermission());
		request.setAttribute("resourcePermissions", permissionService.resourcePermissions(id));
		return "/view/inlay/resource/resourcePermission.jsp";
	}
}
