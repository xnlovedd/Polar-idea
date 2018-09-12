package ${code.packageName}.${code.moduleName}.web;

import java.util.Map;
import java.util.List;
import javax.annotation.Resource;
import javax.validation.Valid;
import polar.island.core.util.CommonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import ${code.packageName}.${code.moduleName}.entity.${code.entityName};
import ${code.packageName}.${code.moduleName}.service.${code.serviceName};
import polar.island.core.config.Constants;
import polar.island.core.controller.BasicController;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.core.exception.FrameWorkException;
import polar.island.core.entity.ResponseJson;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import polar.island.core.util.ExcellUtil;
import polar.island.core.util.FileUtil;
import polar.island.core.util.ResponseUtil;
import org.springframework.web.multipart.MultipartFile;
import polar.island.core.excell.DefaultExportDecorate;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * ${code.tableRemark}的接口，返回数据全部为json串。
 * 
 * @author ${code.author}
 *
 */
@Controller(value = "${code.controllerJsonTag}")
@RequestMapping(value = "${code.controllerJsonPath}")
public class ${code.controllerJsonName} extends BasicController {
	@Resource(name = "${code.serviceTag}")
	private ${code.serviceName} ${code.serviceName?uncap_first};
	private  static final  String MODULE_NAME="${code.tableRemark}";
	/**
	 * 校验访问权限
	 * 
	 * @return
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "${code.moduleName}:empty" })
	@ErrorMsg(tag = "校验用户${code.tableRemark}权限", type = ErrorType.JSON)
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
	 * @see ${code.packageName}.${code.moduleName}.entity.${code.entityName}
	 * @return 列表Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","${code.moduleName}:view:list"})
	@ErrorMsg(tag = "查询${code.tableRemark}", type = ErrorType.JSON)
	@RequestMapping(value = "/pageList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson pageList(${code.entityName} entity) {
		Map<String, Object> condition = beanToMap(entity);
		return new ResponseJson(Constants.CODE_SUCCESS, ${code.serviceName?uncap_first}.selectPageList(condition), null,
				${code.serviceName?uncap_first}.selectCount(condition));
	}
	/**
	 * 查看${code.tableRemark}详情的json串
	 * 
	 * @param ${code.idField}
	 *            数据编号
	 * @return 详情json串
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "${code.moduleName}:view:detail" })
	@ErrorMsg(tag = "查看${code.tableRemark}详情的json串", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "application/json;charset=utf-8")
	public ResponseJson detail(String ${code.idField}) {
		idCheck(${code.idField},MODULE_NAME);
		<#if code.moduleType==0 || code.moduleType==2>Map<String, Object><#else>${code.entityName}</#if> entity = ${code.serviceName?uncap_first}.selectOneById(${code.idField});
		existCheck(entity,MODULE_NAME);
		<#if code.deleteMode!=1>
		effectiveCheck( <#if code.moduleType==0 || code.moduleType==2>CommonUtil.valueOf(entity.get("${code.effectivenessField}"))<#else>CommonUtil.valueOf(entity.get${code.effectivenessField?cap_first}())</#if>,"${code.effectivenessValue}",MODULE_NAME);
		</#if>
		return new ResponseJson(Constants.CODE_SUCCESS, entity);
	}

	/**
	 * 依据数据编号更新此条数据的所有值<#if code.deleteMode==1>。<#else>其‘有效性’字段不会更新</#if>
	 * 
	 * @param entity
	 *            需要更新的实体
	 * @see ${code.packageName}.${code.moduleName}.entity.${code.entityName}
	 * @return 更新条目
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","${code.moduleName}:edit"})
	@ErrorMsg(tag = "更新${code.tableRemark}全部字段", type = ErrorType.JSON)
	@RequestMapping(value = "/updateAllById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson updateAllById(@Valid ${code.entityName} entity, BindingResult bindingResult) {
		validate(${code.entityName}.class, "updateAllById",bindingResult);
		Map<String, Object> condition = beanToMap(entity);
		Long result = ${code.serviceName?uncap_first}.updateAll(condition);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
	}

	/**
	 * 依据数据编号更新此条数据的所有值<#if code.deleteMode==1>。<#else>其‘有效性’字段不会更新</#if>
	 * 
	 * @param entity
	 *            需要更新的实体
	 * @see ${code.packageName}.${code.moduleName}.entity.${code.entityName}
	 * @return 更新条目
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","${code.moduleName}:edit"})
	@ErrorMsg(tag = "更新${code.tableRemark}单个字段", type = ErrorType.JSON)
	@RequestMapping(value = "/updateField", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson updateField(@Valid ${code.entityName} entity, BindingResult bindingResult) {
	    validate(${code.entityName}.class, "updateField",bindingResult);
		Map<String, Object> condition = beanToSingleField(entity);
		condition.put("${code.idField}",entity.get${code.idField?cap_first}());
		Long result = ${code.serviceName?uncap_first}.updateField(condition);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
	}

	/**
	 * 根据数据编号<#if code.deleteMode==1>物理<#else>逻辑</#if>删除数据。
	 * 
	 * @param ids
	 *            数据编号
	 * @return 删除结果。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","${code.moduleName}:delete"})
	@ErrorMsg(tag = "删除多个${code.tableRemark}", type = ErrorType.JSON)
	@RequestMapping(value = "/deleteMulitById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson deleteMulitById(@RequestParam(value = "ids[]", required = false) String[] ids) {
		idCheck(ids,MODULE_NAME);
		Long result = ${code.serviceName?uncap_first}.<#if code.deleteMode==1>deleteMulitByIdPhysical<#else>deleteMulitByIdPhysical</#if>(ids);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
	}

	/**
	 * 根据数据编号<#if code.deleteMode==1>物理<#else>逻辑</#if>删除数据。
	 * 
	 * @param ${code.idField}
	 *            数据编号
	 * @return 删除结果。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","${code.moduleName}:delete"})
	@ErrorMsg(tag = "删除一个${code.tableRemark}", type = ErrorType.JSON)
	@RequestMapping(value = "/deleteById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson deleteById(String ${code.idField}) {
		idCheck(${code.idField},MODULE_NAME);
		Long result = ${code.serviceName?uncap_first}.<#if code.deleteMode==1>deleteByIdPhysical<#else>deleteByIdLogic</#if>(${code.idField});
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
	}

	/**
	 * 新增一条数据。
	 * 
	 * @param entity
	 *            数据
	 * @see ${code.packageName}.${code.moduleName}.entity.${code.entityName}
	 * @return 新增结果。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","${code.moduleName}:add"})
	@ErrorMsg(tag = "新增${code.tableRemark}", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson add(@Valid ${code.entityName} entity, BindingResult bindingResult<#list columns as mData><#if mData.type==10||mData.type==12>,@RequestParam(value = "${mData.javaName}[]", required = false) String ${mData.javaName}[]</#if></#list>) {
		validate(${code.entityName}.class, "add",bindingResult);
		Map<String, Object> condition = beanToMap(entity);
		Object result=${code.serviceName?uncap_first}.insert(condition);
		return new ResponseJson(Constants.CODE_SUCCESS,result, "新增成功。");
	}
	
	/**
	 * 导出excell报表
	 * 
	 * @param entity
	 *            查询条件
	 * @param request
	 *            request对象
	 * @param response
	 *            response对象
	 * @see ${code.packageName}.${code.moduleName}.entity.${code.entityName}
	 *
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","${code.moduleName}:excell:export"})
	@ErrorMsg(tag = "导出${code.tableRemark}表格", type = ErrorType.WEB)
	@RequestMapping(value = "/exportExcell", produces = "text/html;charset=utf-8")
	public void exportExcell(HttpServletRequest request, HttpServletResponse response, ${code.entityName} entity) {
		Map<String, Object> condition = beanToMap(entity);
		List<Map<String,Object>> result = ${code.serviceName?uncap_first}.selectExportList(condition);
		try {
			ResponseUtil.renderResponseFileHeader("${code.tableRemark}.xls",response);
			ExcellUtil.exportExcell(result, new DefaultExportDecorate<${code.entityName}>(), ${code.entityName}.class,response.getOutputStream());
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
	@RequiresPermissions(value = { "polar:backstage","${code.moduleName}:excell:import"}) 
	@ErrorMsg(tag = "导入${code.tableRemark}导入模板", type = ErrorType.WEB)
	@RequestMapping(value = "/importExcellModel", produces = "text/html;charset=utf-8")
	public void importExcellModel(HttpServletResponse response) {
		try {
			ResponseUtil.renderResponseFileHeader("${code.tableRemark}导入模板.xls",response);
			ExcellUtil.importExcellMode(new DefaultExportDecorate<${code.entityName}>(), ${code.entityName}.class,response.getOutputStream());
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
	@RequiresPermissions(value = { "polar:backstage","${code.moduleName}:excell:import"}) 
	@ErrorMsg(tag = "导入${code.tableRemark}表格", type = ErrorType.JSON)
	@RequestMapping(value = "/importExcell", produces = "text/html;charset=utf-8")
	@ResponseBody
	public ResponseJson importExcell(MultipartFile file) {
		fileCheck(file);
		try {
			List<Map<String, Object>> entitys = ExcellUtil.importExcell(file.getInputStream(),
					new DefaultExportDecorate<${code.entityName}>(), ${code.entityName}.class);
			${code.serviceName?uncap_first}.importExcell(entitys);
			return new ResponseJson(Constants.CODE_SUCCESS, null, "导入成功。");
		} catch (FrameWorkException e) {
			throw e;
		} catch (Exception e) {
			throw new FrameWorkException(Constants.CODE_EXCELL_EXPORT, null, e);
		}
	}
}
