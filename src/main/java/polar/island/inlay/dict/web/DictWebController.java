package polar.island.inlay.dict.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import polar.island.core.controller.BasicController;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.inlay.dict.entity.DictEntity;
import polar.island.inlay.dict.service.DictService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 字典的控制器类，返回参数为页面，为配合加载，出错时为Json串，可修改@ErrorMsg标签，使其出错时返回页面。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "dictWebController")
@RequestMapping(value = "/dict/web")
public class DictWebController extends BasicController {
	@Resource(name = "dictService")
	private DictService dictService;
	private  static final  String MODULE_NAME="字典";
	/**
	 * 字典数据列表页面
	 * 
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:dict:view:list" })
	@ErrorMsg(tag = "字典列表", type = ErrorType.JSON)
	@RequestMapping(value = { "/list", "" }, produces = "text/html;charset=utf-8")
	public String list() {
		return "/view/inlay/dict/dictList.jsp";
	}

	/**
	 * 字典数据列表页面
	 * 
	 * @param request
	 *            web请求对象
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:dict:add" })
	@ErrorMsg(tag = "添加字典", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "text/html;charset=utf-8")
	public String add(HttpServletRequest request) {
		DictEntity entity = new DictEntity();
		request.setAttribute("dict", entity);
		return "/view/inlay/dict/dictForm.jsp";
	}

	/**
	 * 更新字典数据页面
	 * 
	 * @param request
	 *            request对象
	 * @param id
	 *            数据编号
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:dict:edit" })
	@ErrorMsg(tag = "更新字典", type = ErrorType.JSON)
	@RequestMapping(value = "/update", produces = "text/html;charset=utf-8")
	public String updatePage(HttpServletRequest request, String id) {
		idCheck(id,MODULE_NAME);
		DictEntity entity = dictService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		request.setAttribute("dict", entity);
		return "/view/inlay/dict/dictForm.jsp";
	}

	/**
	 * 字典数据的详情页面
	 * 
	 * @param id
	 *            数据编号
	 * @param request
	 *            request对象
	 * 
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:dict:view:detail" })
	@ErrorMsg(tag = "查看字典", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "text/html;charset=utf-8")
	public String detailPage(String id, HttpServletRequest request) {
		return updatePage(request,id);
	}
}
