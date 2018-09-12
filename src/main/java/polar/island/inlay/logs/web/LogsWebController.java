package polar.island.inlay.logs.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import polar.island.core.controller.BasicController;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.inlay.logs.entity.LogsEntity;
import polar.island.inlay.logs.service.LogsService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 日志记录表的控制器类，返回参数为页面，为配合加载，出错时为Json串，可修改@ErrorMsg标签，使其出错时返回页面。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "logsWebController")
@RequestMapping(value = "/logs/web")
public class LogsWebController extends BasicController {
	@Resource(name = "logsService")
	private LogsService logsService;
	private  static final  String MODULE_NAME="日志";
	/**
	 * 日志记录表,用来记录通用产出的错误信息。列表页面
	 * 
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:log:view:list" })
	@ErrorMsg(tag = "日志记录表列表", type = ErrorType.JSON)
	@RequestMapping(value = { "/list", "" }, produces = "text/html;charset=utf-8")
	public String list() {
		return "/view/inlay/logs/logsList.jsp";
	}




	/**
	 * 日志记录表,用来记录通用产出的错误信息的详情页面
	 * 
	 * @param id
	 *            数据编号
	 * @param request
	 *            request对象
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:log:view:detail" })
	@ErrorMsg(tag = "查看日志记录表", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "text/html;charset=utf-8")
	public String detailPage(String id, HttpServletRequest request) {
		idCheck(id,MODULE_NAME);
		LogsEntity entity = logsService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		request.setAttribute("logs", entity);
		return "/view/inlay/logs/logsForm.jsp";
	}
}
