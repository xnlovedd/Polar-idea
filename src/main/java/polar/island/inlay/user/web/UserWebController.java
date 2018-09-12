package polar.island.inlay.user.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import polar.island.core.controller.BasicController;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.core.security.entity.UserEntity;
import polar.island.core.security.service.UserService;
import polar.island.core.util.GsonUtil;
import polar.island.inlay.menuModel.service.MenuModelService;
import polar.island.inlay.org.service.OrgService;
import polar.island.inlay.role.service.RoleService;
import polar.island.web.util.UserUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 用户的控制器类，返回参数为页面，为配合加载，出错时为Json串，可修改@ErrorMsg标签，使其出错时返回页面。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "userWebController")
@RequestMapping(value = "/user/web")
public class UserWebController extends BasicController {
	@Resource(name = "userService")
	private UserService userService;
	@Resource(name = "roleService")
	private RoleService roleService;
	@Resource(name = "menuModelService")
	private MenuModelService menuModelService;
	@Resource(name = "orgService")
	private OrgService orgService;
	private  static final  String MODULE_NAME="用户";
	/**
	 * 用户基本信息管理列表页面
	 * 
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:user:view:list" })
	@ErrorMsg(tag = "用户列表", type = ErrorType.JSON)
	@RequestMapping(value = { "/list", "" }, produces = "text/html;charset=utf-8")
	public String list() {
		return "/view/inlay/user/userList.jsp";
	}

	/**
	 * 用户基本信息管理列表页面
	 * 
	 * @param request
	 *            request对象
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:user:add" })
	@ErrorMsg(tag = "用户列表", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "text/html;charset=utf-8")
	public String add(HttpServletRequest request) {
		UserEntity entity = new UserEntity();
		request.setAttribute("user", entity);
		return "/view/inlay/user/userForm.jsp";
	}

	/**
	 * 更新用户基本信息管理页面
	 * 
	 * @param request
	 *            request对象
	 * @param id
	 *            数据编号
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:user:edit" })
	@ErrorMsg(tag = "更新用户", type = ErrorType.JSON)
	@RequestMapping(value = "/update", produces = "text/html;charset=utf-8")
	public String updatePage(HttpServletRequest request, String id) {
		idCheck(id,MODULE_NAME);
		UserEntity entity = userService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		effectiveCheck(entity.getState()+"","1",MODULE_NAME);
		request.setAttribute("org_allEntities",  GsonUtil.toJson(orgService.selectAllList()));
		request.setAttribute("user", entity);
		return "/view/inlay/user/userForm.jsp";
	}

	/**
	 * 用户基本信息管理的详情页面
	 * 
	 * @param id
	 *            数据编号
	 * @param request
	 *            request对象
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:user:view:detail" })
	@ErrorMsg(tag = "查看用户", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "text/html;charset=utf-8")
	public String detailPage(String id, HttpServletRequest request) {
		return updatePage(request,id);
	}

	@RequiresUser
	@ErrorMsg(tag = "用户详情", type = ErrorType.JSON)
	@RequestMapping(value = "/selfDetail", produces = "text/html;charset=utf-8")
	public String selfDetail(HttpServletRequest request) {
		UserEntity entity = userService.selectOneById(UserUtil.getUserId());
		existCheck(entity,MODULE_NAME);
		effectiveCheck(entity.getState()+"","1",MODULE_NAME);
		request.setAttribute("user", entity);
		return "/view/inlay/user/selfUser.jsp";
	}

	@RequiresUser
	@ErrorMsg(tag = "更新密码", type = ErrorType.JSON)
	@RequestMapping(value = "/updatePwd", produces = "text/html;charset=utf-8")
	public String updatePwd(HttpServletRequest request) {
		return "/view/inlay/user/upDatePassword.jsp";
	}

	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:user:role:empty" })
	@ErrorMsg(tag = "查看用户角色", type = ErrorType.JSON)
	@RequestMapping(value = "/userRole", produces = "text/html;charset=utf-8")
	public String userRole(String id, HttpServletRequest request) {
		idCheck(id,MODULE_NAME);
		UserEntity entity = userService.selectOneById(id + "");
		existCheck(entity,MODULE_NAME);
		effectiveCheck(entity.getState()+"","1",MODULE_NAME);
		request.setAttribute("id", id);
		request.setAttribute("allRoles", roleService.allRoles());
		request.setAttribute("userRoles", roleService.userRoles(id));
		return "/view/inlay/user/userRole.jsp";
	}

	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:user:menu" })
	@ErrorMsg(tag = "查看用户菜单", type = ErrorType.JSON)
	@RequestMapping(value = "/userMenuModel", produces = "text/html;charset=utf-8")
	public String userMenuModel(String id, HttpServletRequest request) {
		idCheck(id,MODULE_NAME);
		UserEntity entity = userService.selectOneById(id + "");
		existCheck(entity,MODULE_NAME);
		effectiveCheck(entity.getState()+"","1",MODULE_NAME);
		request.setAttribute("id", id);
		request.setAttribute("allMenuModels", menuModelService.selectList(null));
		request.setAttribute("userMenuModels", menuModelService.userMenuModels(id));
		return "/view/inlay/user/userMenuModels.jsp";
	}

}
