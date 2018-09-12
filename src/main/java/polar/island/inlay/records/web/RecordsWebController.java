package polar.island.inlay.records.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import polar.island.core.controller.BasicController;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.inlay.records.entity.RecordsEntity;
import polar.island.inlay.records.service.RecordsService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 访问记录的控制器类，返回参数为页面，为配合加载，出错时为Json串，可修改@ErrorMsg标签，使其出错时返回页面。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "recordsWebController")
@RequestMapping(value = "/records/web")
public class RecordsWebController extends BasicController {
	@Resource(name = "recordsService")
	private RecordsService recordsService;
	private  static final  String MODULE_NAME="菜单";
	/**
	 * 访问记录列表页面
	 * 
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@ErrorMsg(tag = "访问记录列表", type = ErrorType.JSON,writeLogs = false)
	@RequestMapping(value = { "/list", "" }, produces = "text/html;charset=utf-8")
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:records:list" })
	public String list() {
		return "/view/inlay/records/recordsList.jsp";
	}

	/**
	 * 访问记录的详情页面
	 * 
	 * @param id
	 *            数据编号
	 * @param request
	 *            request对象
	 * @return 详情页面
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:records:detail" })
	@ErrorMsg(tag = "查看访问记录", type = ErrorType.JSON,writeLogs = false)
	@RequestMapping(value = "/detail", produces = "text/html;charset=utf-8")
	public String detailPage(String id, HttpServletRequest request) {
		idCheck(id,MODULE_NAME);
		RecordsEntity entity = recordsService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		request.setAttribute("records", entity);
		return "/view/inlay/records/recordsForm.jsp";
	}
}
