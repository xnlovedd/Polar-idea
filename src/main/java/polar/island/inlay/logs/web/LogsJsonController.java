package polar.island.inlay.logs.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import polar.island.core.config.Constants;
import polar.island.core.controller.BasicController;
import polar.island.core.entity.ResponseJson;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.core.exception.ValidationException;
import polar.island.core.util.DateUtils;
import polar.island.inlay.logs.entity.LogsEntity;
import polar.island.inlay.logs.service.LogsService;

import javax.annotation.Resource;
import java.util.Map;

/**
 * 日志记录表的接口，返回数据全部为json串。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "logsJsonController")
@RequestMapping(value = "/logs/json")
public class LogsJsonController extends BasicController {
	@Resource(name = "logsService")
	private LogsService logsService;
	private  static final  String MODULE_NAME="日志";
	/**
	 * 校验访问权限
	 * 
	 * @return
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:log:empty" })
	@ErrorMsg(tag = "校验日志权限", type = ErrorType.JSON)
	@RequestMapping(value = "/checkPermission", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson checkPermission() {
		return new ResponseJson(Constants.CODE_SUCCESS);
	}

	/**
	 * 依据条件查询分页数据，如果不传页码、每页条目，则默认分别为：1,10
	 * 
	 * @param entity
	 *            查询条件
	 * @param startTime
	 *            开始时间
	 * @param endTime
	 *            结束时间
	 * @see polar.island.inlay.logs.entity.LogsEntity
	 * @return 列表Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:log:view:list" })
	@ErrorMsg(tag = "查询日志记录表", type = ErrorType.JSON)
	@RequestMapping(value = "/pageList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson pageList(LogsEntity entity, String startTime, String endTime) {
		Map<String, Object> condition = beanToMap(entity);
		try {
			if (startTime != null) {
				condition.put("startTime", DateUtils.parseDate(startTime, "yyyy-MM-dd HH:mm:ss").getTime());
			}
		} catch (Exception e) {
			throw new ValidationException("开始时间格式不正确", null);
		}
		try {
			if (endTime != null) {
				condition.put("endTime", DateUtils.parseDate(endTime, "yyyy-MM-dd HH:mm:ss").getTime());
			}
		} catch (Exception e) {
			throw new ValidationException("结束时间格式不正确", null);
		}
		return new ResponseJson(Constants.CODE_SUCCESS, logsService.selectPageList(condition),null,
				logsService.selectCount(condition));
	}
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:log:view:detail" })
	@ErrorMsg(tag = "查看日志记录表", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "application/json;charset=utf-8")
	public ResponseJson detail(String id) {
		idCheck(id,MODULE_NAME);
		LogsEntity entity = logsService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		return new ResponseJson(Constants.CODE_SUCCESS, entity);
	}




	/**
	 * 根据数据编号物理删除数据。
	 * 
	 * @param ids
	 *            数据编号
	 * @return 删除结果。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:log:delete" })
	@ErrorMsg(tag = "删除多个日志记录表", type = ErrorType.JSON)
	@RequestMapping(value = "/deleteMulitById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson deleteMulitById(@RequestParam(value = "ids[]", required = false) String[] ids) {
		idCheck(ids,MODULE_NAME);
		Long result = logsService.deleteMulitByIdPhysical(ids);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
	}

	/**
	 * 根据数据编号物理删除数据。
	 * 
	 * @param id
	 *            数据编号
	 * @return 删除结果。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:log:delete" })
	@ErrorMsg(tag = "删除一个日志记录表", type = ErrorType.JSON)
	@RequestMapping(value = "/deleteById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson deleteById(String id) {
		idCheck(id,MODULE_NAME);
		Long result = logsService.deleteByIdPhysical(id);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
	}
}
