package polar.island.inlay.tree.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import polar.island.core.controller.BasicController;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.inlay.tree.entity.TreeEntity;
import polar.island.inlay.tree.service.TreeService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 树结构的控制器类，返回参数为页面，为配合加载，出错时为Json串，可修改@ErrorMsg标签，使其出错时返回页面。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "treeWebController")
@RequestMapping(value = "/tree/web")
public class TreeWebController extends BasicController {
	@Resource(name = "treeService")
	private TreeService treeService;
	private  static final  String MODULE_NAME="树结构";
	/**
	 * 树结构列表页面
	 * 
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:tree:view:list" })
	@ErrorMsg(tag = "树结构列表", type = ErrorType.JSON)
	@RequestMapping(value = { "/list", "" }, produces = "text/html;charset=utf-8")
	public String list() {
		return "/view/inlay/tree/treeList.jsp";
	}

	/**
	 * 树结构列表页面
	 * 
	 * @param request
	 *            request对象
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:tree:add" })
	@ErrorMsg(tag = "树结构列表", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "text/html;charset=utf-8")
	public String add(HttpServletRequest request) {
		TreeEntity entity = new TreeEntity();
		request.setAttribute("tree", entity);
		return "/view/inlay/tree/treeForm.jsp";
	}

	/**
	 * 更新树结构页面
	 * 
	 * @param request
	 *            request对象
	 * @param id
	 *            数据编号
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:tree:edit" })
	@ErrorMsg(tag = "更新树结构", type = ErrorType.JSON)
	@RequestMapping(value = "/update", produces = "text/html;charset=utf-8")
	public String updatePage(HttpServletRequest request, String id) {
		idCheck(id,MODULE_NAME);
		TreeEntity entity = treeService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		request.setAttribute("tree", entity);
		return "/view/inlay/tree/treeForm.jsp";
	}

	/**
	 * 树结构的详情页面
	 * 
	 * @param request
	 *            request对象
	 * @param id
	 *            数据编号
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:tree:view:detail" })
	@ErrorMsg(tag = "查看树结构", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "text/html;charset=utf-8")
	public String detailPage(String id, HttpServletRequest request) {
		return updatePage(request,id);
	}
}
