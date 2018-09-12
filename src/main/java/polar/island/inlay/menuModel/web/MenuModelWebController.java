package polar.island.inlay.menuModel.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import polar.island.core.controller.BasicController;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.inlay.menu.service.MenuService;
import polar.island.inlay.menuModel.entity.MenuModelEntity;
import polar.island.inlay.menuModel.service.MenuModelService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 菜单模板的控制器类，返回参数为页面，为配合加载，出错时为Json串，可修改@ErrorMsg标签，使其出错时返回页面。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "menuModelWebController")
@RequestMapping(value = "/menuModel/web")
public class MenuModelWebController extends BasicController {
	@Resource(name = "menuModelService")
	private MenuModelService menuModelService;
	@Resource(name = "menuService")
	private MenuService menuService;
	private  static final  String MODULE_NAME=null;
	/**
	 * 菜单模板列表页面
	 * 
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:menumodel:view:list" })
	@ErrorMsg(tag = "菜单模板列表", type = ErrorType.JSON)
	@RequestMapping(value = { "/list", "" }, produces = "text/html;charset=utf-8")
	public String list() {
		return "/view/inlay/menuModel/menuModelList.jsp";
	}

	/**
	 * 菜单模板列表页面
	 * 
	 * @param request
	 *            request对象
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:menumodel:add" })
	@ErrorMsg(tag = "新增菜单模板", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "text/html;charset=utf-8")
	public String add(HttpServletRequest request) {
		MenuModelEntity entity = new MenuModelEntity();
		request.setAttribute("menuModel", entity);
		return "/view/inlay/menuModel/menuModelForm.jsp";
	}

	/**
	 * 更新菜单模板页面
	 * 
	 * @param request
	 *            request对象
	 * @param id
	 *            数据编号
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:menumodel:edit" })
	@ErrorMsg(tag = "更新菜单模板", type = ErrorType.JSON)
	@RequestMapping(value = "/update", produces = "text/html;charset=utf-8")
	public String updatePage(HttpServletRequest request, String id) {
		idCheck(id,MODULE_NAME);
		MenuModelEntity entity = menuModelService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		request.setAttribute("menuModel", entity);
		return "/view/inlay/menuModel/menuModelForm.jsp";
	}

	/**
	 * 菜单模板的详情页面
	 * 
	 * @param id
	 *            数据编号
	 * @param request
	 *            request对象
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:menumodel:view:detail" })
	@ErrorMsg(tag = "查看菜单模板", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "text/html;charset=utf-8")
	public String detailPage(String id, HttpServletRequest request) {
		return updatePage(request,id);
	}

	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:menumodel:menu" })
	@ErrorMsg(tag = "查看模板菜单", type = ErrorType.JSON)
	@RequestMapping(value = "/modelMenus", produces = "text/html;charset=utf-8")
	public String modelMenus(String id, HttpServletRequest request) {
		idCheck(id,MODULE_NAME);
		MenuModelEntity entity = menuModelService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		request.setAttribute("id", id);
		request.setAttribute("allMenus", menuService.allMenus());
		request.setAttribute("modelMenus", menuService.modelMenus(id));
		return "/view/inlay/menuModel/menu.jsp";
	}
}
