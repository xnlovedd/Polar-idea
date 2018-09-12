package polar.island.inlay.org.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import polar.island.core.config.Constants;
import polar.island.core.controller.BasicController;
import polar.island.core.entity.ResponseJson;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.core.excell.DefaultExportDecorate;
import polar.island.core.exception.FrameWorkException;
import polar.island.core.util.ExcellUtil;
import polar.island.core.util.ResponseUtil;
import polar.island.inlay.org.entity.OrgEntity;
import polar.island.inlay.org.service.OrgService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * 机构的接口，返回数据全部为json串。
 *
 * @author PolarLoves
 *
 */
@Controller(value = "orgJsonController")
@RequestMapping(value = "/org/json")
public class OrgJsonController extends BasicController {
	@Resource(name = "orgService")
	private OrgService orgService;
	private  static final  String MODULE_NAME="机构";
	/**
	 * 校验访问权限
	 *
	 * @return
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:org:empty" })
	@ErrorMsg(tag = "校验用户机构权限", type = ErrorType.JSON)
	@RequestMapping(value = "/checkPermission", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson checkPermission() {
		return new ResponseJson(Constants.CODE_SUCCESS);
	}
	/**
	 * 查询所有的数据
	 *
	 * @return 列表Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:org:view:list"})
	@ErrorMsg(tag = "查询机构", type = ErrorType.JSON)
	@RequestMapping(value = "/list", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson list() {
		return new ResponseJson(Constants.CODE_SUCCESS, orgService.selectAllList(), null);
	}
	/**
	 * 查看机构详情的json串
	 *
	 * @param id
	 *            数据编号
	 * @return 详情json串
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:org:view:detail" })
	@ErrorMsg(tag = "查看机构详情的json串", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "application/json;charset=utf-8")
	public ResponseJson detail(String id) {
		idCheck(id,MODULE_NAME);
		OrgEntity entity = orgService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		return new ResponseJson(Constants.CODE_SUCCESS, entity);
	}


	/**
	 * 依据数据编号更新此条数据的所有值。
	 *
	 * @param entity
	 *            需要更新的实体
	 * @see polar.island.inlay.org.entity.OrgEntity
	 * @return 更新条目
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:org:edit"})
	@ErrorMsg(tag = "更新机构全部字段", type = ErrorType.JSON)
	@RequestMapping(value = "/updateAllById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson updateAllById(@Valid OrgEntity entity, BindingResult bindingResult) {
		validate(OrgEntity.class, "updateAllById",bindingResult);
		Map<String, Object> condition = beanToMap(entity);
		Long result = orgService.updateAll(condition);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
	}
	/**
	 * 依据数据编号更新此条数据的单个字段。
	 *
	 * @param entity
	 *            需要更新的实体
	 * @see polar.island.inlay.org.entity.OrgEntity
	 * @return 更新条目
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:org:edit"})
	@ErrorMsg(tag = "更新机构单个字段", type = ErrorType.JSON)
	@RequestMapping(value = "/updateField", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson updateField(@Valid OrgEntity entity, BindingResult bindingResult) {
	    validate(OrgEntity.class, "updateField",bindingResult);
		Map<String, Object> condition = beanToSingleField(entity);
		condition.put("id",entity.getId());
		Long result = orgService.updateField(condition);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
	}

	/**
	 * 根据数据编号物理删除数据。
	 *
	 * @param ids
	 *            数据编号
	 * @return 删除结果。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:org:delete"})
	@ErrorMsg(tag = "删除多个机构", type = ErrorType.JSON)
	@RequestMapping(value = "/deleteMulitById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson deleteMulitById(@RequestParam(value = "ids[]", required = false) String[] ids) {
		idCheck(ids,MODULE_NAME);
		Long result = orgService.deleteMulitByIdPhysical(ids);
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
	@RequiresPermissions(value = { "polar:backstage","polar:org:delete"})
	@ErrorMsg(tag = "删除一个机构", type = ErrorType.JSON)
	@RequestMapping(value = "/deleteById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson deleteById(String id) {
		idCheck(id,MODULE_NAME);
		Long result = orgService.deleteByIdPhysical(id);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
	}

	/**
	 * 新增一条数据。
	 *
	 * @param entity
	 *            数据
	 * @see polar.island.inlay.org.entity.OrgEntity
	 * @return 新增结果。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:org:add"})
	@ErrorMsg(tag = "新增机构", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson add(@Valid OrgEntity entity, BindingResult bindingResult) {
		validate(OrgEntity.class, "add",bindingResult);
		Map<String, Object> condition = beanToMap(entity);
		Object result=orgService.insert(condition);
		return new ResponseJson(Constants.CODE_SUCCESS,result, "新增成功。");
	}

	/**
	 * 导出excell报表
	 *
	 * @param request
	 *            request对象
	 * @param response
	 *            response对象
	 * @see polar.island.inlay.org.entity.OrgEntity
	 *
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:org:excell:export"})
	@ErrorMsg(tag = "导出机构表格", type = ErrorType.WEB)
	@RequestMapping(value = "/exportExcell", produces = "text/html;charset=utf-8")
	public void exportExcell(HttpServletRequest request, HttpServletResponse response) {
		try {
			ResponseUtil.renderResponseFileHeader("机构.xls",response);
			ExcellUtil.exportExcell(orgService.selectAllList(), new DefaultExportDecorate<OrgEntity>(), OrgEntity.class,response.getOutputStream());
		} catch (Exception e) {
			throw new FrameWorkException(Constants.CODE_EXCELL_EXPORT, null, e);
		}
	}

	/**
	 * 下载导入模板
	 *
	 * @param response
	 *            response对象
	 *
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:org:excell:import"})
	@ErrorMsg(tag = "导入机构导入模板", type = ErrorType.WEB)
	@RequestMapping(value = "/importExcellModel", produces = "text/html;charset=utf-8")
	public void importExcellModel(HttpServletResponse response) {
		try {
			ResponseUtil.renderResponseFileHeader("机构导入模板.xls",response);
			ExcellUtil.importExcellMode(new DefaultExportDecorate<OrgEntity>(), OrgEntity.class,response.getOutputStream());
		} catch (Exception e) {
			throw new FrameWorkException(Constants.CODE_EXCELL_EXPORT, null, e);
		}
	}

	/**
	 * 导入数据
	 *
	 * @param file
	 *            excell文件
	 * @return 导入结果。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:org:excell:import"})
	@ErrorMsg(tag = "导入机构表格", type = ErrorType.JSON)
	@RequestMapping(value = "/importExcell", produces = "text/html;charset=utf-8")
	@ResponseBody
	public ResponseJson importExcell(MultipartFile file) {
		fileCheck(file);
		try {
			List<Map<String, Object>> entitys = ExcellUtil.importExcell(file.getInputStream(),
					new DefaultExportDecorate<OrgEntity>(), OrgEntity.class);
			orgService.importExcell(entitys);
			return new ResponseJson(Constants.CODE_SUCCESS, null, "导入成功。");
		} catch (FrameWorkException e) {
			throw e;
		} catch (Exception e) {
			throw new FrameWorkException(Constants.CODE_EXCELL_EXPORT, null, e);
		}
	}
}
