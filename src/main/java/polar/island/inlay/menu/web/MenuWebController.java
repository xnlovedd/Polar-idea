package polar.island.inlay.menu.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import polar.island.core.controller.BasicController;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.inlay.menu.entity.MenuEntity;
import polar.island.inlay.menu.service.MenuService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 菜单的控制器类，返回参数为页面，为配合加载，出错时为Json串，可修改@ErrorMsg标签，使其出错时返回页面。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "menuWebController")
@RequestMapping(value = "/menu/web")
public class MenuWebController extends BasicController {
	@Resource(name = "menuService")
	private MenuService menuService;
	private  static final  String MODULE_NAME="菜单";
	/**
	 * 菜单列表页面
	 * 
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:menu:view:list" })
	@ErrorMsg(tag = "菜单列表", type = ErrorType.JSON)
	@RequestMapping(value = { "/list", "" }, produces = "text/html;charset=utf-8")
	public String list() {
		return "/view/inlay/menu/menuList.jsp";
	}

	/**
	 * 菜单列表页面
	 * 
	 * @param parentId
	 *            父类编号
	 * @param request
	 *            request对象
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:menu:add" })
	@ErrorMsg(tag = "新增菜单", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "text/html;charset=utf-8")
	public String add(Long parentId, HttpServletRequest request) {
		MenuEntity entity = new MenuEntity();
		entity.setParentId(parentId);
		request.setAttribute("menu", entity);
		return "/view/inlay/menu/menuForm.jsp";
	}

	/**
	 * 更新菜单页面
	 * 
	 * @param request
	 *            request对象
	 * @param id
	 *            数据编号
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:menu:edit" })
	@ErrorMsg(tag = "更新菜单", type = ErrorType.JSON)
	@RequestMapping(value = "/update", produces = "text/html;charset=utf-8")
	public String updatePage(HttpServletRequest request, String id) {
		idCheck(id,MODULE_NAME);
		MenuEntity entity = menuService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		request.setAttribute("menu", entity);
		return "/view/inlay/menu/menuForm.jsp";
	}

	/**
	 * 菜单的详情页面
	 * 
	 * @param id
	 *            数据编号
	 * @param request
	 *            request对象
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:menu:view:detail" })
	@ErrorMsg(tag = "查看菜单", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "text/html;charset=utf-8")
	public String detailPage(String id, HttpServletRequest request) {
		return updatePage(request,id);
	}
}
