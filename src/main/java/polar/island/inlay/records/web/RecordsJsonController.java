package polar.island.inlay.records.web;

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
import polar.island.core.util.DateUtils;
import polar.island.inlay.records.entity.RecordsEntity;
import polar.island.inlay.records.service.RecordsService;

import javax.annotation.Resource;
import java.util.Map;

/**
 * 访问记录的接口，返回数据全部为json串。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "recordsJsonController")
@RequestMapping(value = "/records/json")
public class RecordsJsonController extends BasicController {
	@Resource(name = "recordsService")
	private RecordsService recordsService;
	private  static final  String MODULE_NAME=null;
	/**
	 * 校验访问权限
	 * 
	 * @return
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:records:empty" })
	@ErrorMsg(tag = "校验访问记录权限", type = ErrorType.JSON,writeLogs = false)
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
	 * @see polar.island.inlay.records.entity.RecordsEntity
	 * @return 列表Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:records:list" })
	@ErrorMsg(tag = "查询访问记录", type = ErrorType.JSON,writeLogs = false)
	@RequestMapping(value = "/pageList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson pageList(RecordsEntity entity) {
		Map<String, Object> condition = beanToMap(entity);
		if (entity.getVistSearchDate() != null) {
			try {
				String args[] = entity.getVistSearchDate().split("~");
				condition.put("startDate", DateUtils.parseDate(args[0].trim()));
				condition.put("endDate", DateUtils.parseDate(args[1].trim()));
			} catch (Exception e) {
			}
		}
		return new ResponseJson(Constants.CODE_SUCCESS, recordsService.selectPageList(condition),null,
				recordsService.selectCount(condition));
	}
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:records:detail" })
	@ErrorMsg(tag = "查看访问记录", type = ErrorType.JSON,writeLogs = false)
	@RequestMapping(value = "/detail", produces = "application/json;charset=utf-8")
	public ResponseJson detail(String id) {
		idCheck(id,MODULE_NAME);
		RecordsEntity entity = recordsService.selectOneById(id);
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
	@RequiresPermissions(value = { "polar:backstage", "polar:records:delete" })
	@ErrorMsg(tag = "删除多个访问记录", type = ErrorType.JSON,writeLogs = false)
	@RequestMapping(value = "/deleteMulitById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson deleteMulitById(@RequestParam(value = "ids[]", required = false) String[] ids) {
		idCheck(ids,MODULE_NAME);
		Long result = recordsService.deleteMulitByIdPhysical(ids);
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
	@RequiresPermissions(value = { "polar:backstage", "polar:records:delete" })
	@ErrorMsg(tag = "删除一个访问记录", type = ErrorType.JSON,writeLogs = false)
	@RequestMapping(value = "/deleteById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson deleteById(String id) {
		idCheck(id,MODULE_NAME);
		Long result = recordsService.deleteByIdPhysical(id);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
	}

}
