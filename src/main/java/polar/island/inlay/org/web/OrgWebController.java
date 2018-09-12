package polar.island.inlay.org.web;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import polar.island.core.controller.BasicController;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.core.util.GsonUtil;
import polar.island.inlay.org.entity.OrgEntity;
import polar.island.inlay.org.service.OrgService;
import polar.island.inlay.permission.service.PermissionService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
/**
 * 机构的控制器类，返回参数为页面，为配合加载，出错时为Json串，可修改@ErrorMsg标签，使其出错时返回页面。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "orgWebController")
@RequestMapping(value = "/org/web")
public class OrgWebController extends BasicController {
	@Resource(name = "orgService")
	private OrgService orgService;
	private  static final  String MODULE_NAME="机构";
	@Resource(name = "permissionService")
	private PermissionService permissionService;
	/**
	 * 机构列表页面
	 *
	 * @param request
	 *            request对象
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@ErrorMsg(tag = "机构列表", type = ErrorType.JSON)
	@RequestMapping(value = { "/list", "" }, produces = "text/html;charset=utf-8")
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:org:view:list"})
	public String list(HttpServletRequest request) {
		return "/view/inlay/org/orgList.jsp";
	}
	/**
	 * 机构新增页面
	 * 
	 * @param request
	 *            request对象
	 * @return 新增页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:org:add"})
	@ErrorMsg(tag = "新增机构", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "text/html;charset=utf-8")
	public String add(Long parentId,HttpServletRequest request) {
		OrgEntity entity=new OrgEntity();
		entity.setParentId(parentId);
		request.setAttribute("org", entity);
		request.setAttribute("org_allEntities",  GsonUtil.toJson(orgService.selectAllList()));
		return "/view/inlay/org/orgForm.jsp";
	}
	/**
	 * 更新机构页面
	 * 
	 * @param request
	 *            request对象
	 * @param id
	 *            数据编号
	 * @return 更新页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:org:edit"})
	@ErrorMsg(tag = "更新机构", type = ErrorType.JSON)
	@RequestMapping(value = "/update", produces = "text/html;charset=utf-8")
	public String updatePage(HttpServletRequest request, String id) {
		idCheck(id,MODULE_NAME);
		OrgEntity entity = orgService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		request.setAttribute("org", entity);
		request.setAttribute("org_allEntities",  GsonUtil.toJson(orgService.selectAllList()));
		return "/view/inlay/org/orgForm.jsp";
	}
	/**
	 * 机构的详情页面
	 *
	 * @param request
	 *            request对象
	 * @param id
	 *            数据编号
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:org:view:detail"})
	@ErrorMsg(tag = "查看机构", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "text/html;charset=utf-8")
	public String detailPage(String id, HttpServletRequest request) {
  		return updatePage(request,id);
	}

	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:org:permission" })
	@ErrorMsg(tag = "部门权限", type = ErrorType.JSON)
	@RequestMapping(value = "/orgPermission", produces = "text/html;charset=utf-8")
	public String orgPermission(String id, HttpServletRequest request) {
		idCheck(id,MODULE_NAME);
		OrgEntity entity = orgService.selectOneById(id + "");
		existCheck(entity,MODULE_NAME);
		request.setAttribute("id", id);
		request.setAttribute("allPermissions", permissionService.allPermission());
		request.setAttribute("orgPermissions", permissionService.orgPermissions(id));
		return "/view/inlay/org/orgPermission.jsp";
	}
}
