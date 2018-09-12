package ${code.packageName}.${code.moduleName}.web;

import javax.annotation.Resource;
import java.util.HashMap;
import polar.island.core.util.CommonUtil;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
<#if code.moduleType !=0>import ${code.packageName}.${code.moduleName}.entity.${code.entityName};<#else>import java.util.Map;</#if>
import ${code.packageName}.${code.moduleName}.service.${code.serviceName};
import polar.island.core.controller.BasicController;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
/**
 * ${code.tableRemark}的控制器类，返回参数为页面，为配合加载，出错时为Json串，可修改@ErrorMsg标签，使其出错时返回页面。
 * 
 * @author ${code.author}
 *
 */
@Controller(value = "${code.controllerWebTag}")
@RequestMapping(value = "${code.controllerWebPath}")
public class ${code.controllerWebName} extends BasicController {
	@Resource(name = "${code.serviceTag}")
	private ${code.serviceName} ${code.serviceName?uncap_first};
	private  static final  String MODULE_NAME="${code.tableRemark}";
	/**
	 * ${code.moduleRemark}列表页面
	 *
	 * @param request
	 *            request对象
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@ErrorMsg(tag = "${code.tableRemark}列表", type = ErrorType.JSON)
	@RequestMapping(value = { "/list", "" }, produces = "text/html;charset=utf-8")
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","${code.moduleName}:view:list"})
	public String list(HttpServletRequest request) {
		return "/view/modules/${code.moduleName}/${code.jspListName}.jsp";
	}
	/**
	 * ${code.moduleRemark}新增页面
	 * 
	 * @param request
	 *            request对象
	 * @return 新增页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","${code.moduleName}:add"})
	@ErrorMsg(tag = "新增${code.tableRemark}", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "text/html;charset=utf-8")
	public String add(HttpServletRequest request) {
		<#if code.moduleType==0 || code.moduleType==2>Map<String, Object> entity =new HashMap<String,Object>();<#else>${code.entityName} entity=new ${code.entityName}();</#if>
		request.setAttribute("${code.moduleName}", entity);
		return "/view/modules/${code.moduleName}/${code.jspEditName}.jsp";
	}
	/**
	 * 更新${code.moduleRemark}页面
	 * 
	 * @param request
	 *            request对象
	 * @param ${code.idField}
	 *            数据编号
	 * @return 更新页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","${code.moduleName}:edit"})
	@ErrorMsg(tag = "更新${code.tableRemark}", type = ErrorType.JSON)
	@RequestMapping(value = "/update", produces = "text/html;charset=utf-8")
	public String updatePage(HttpServletRequest request, String ${code.idField}) {
		idCheck(${code.idField},MODULE_NAME);
		<#if code.moduleType==0 || code.moduleType==2>Map<String, Object><#else>${code.entityName}</#if> entity = ${code.serviceName?uncap_first}.selectOneById(${code.idField});
		existCheck(entity,MODULE_NAME);
		<#if code.deleteMode!=1>
		effectiveCheck( <#if code.moduleType==0 || code.moduleType==2>entity.get("${code.effectivenessField}")==null?"":entity.get("${code.effectivenessField}").toString()<#else>entity.get${code.effectivenessField?cap_first}()</#if>,"${code.effectivenessValue}",MODULE_NAME);
		</#if>
		request.setAttribute("${code.moduleName}", entity);
		return "/view/modules/${code.moduleName}/${code.jspEditName}.jsp";
	}
	/**
	 * ${code.moduleRemark}的详情页面
	 *
	 * @param request
	 *            request对象
	 * @param ${code.idField}
	 *            数据编号
	 * @return 列表页面，如出错，则返回Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","${code.moduleName}:view:detail"})
	@ErrorMsg(tag = "查看${code.tableRemark}", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "text/html;charset=utf-8")
	public String detailPage(String ${code.idField}, HttpServletRequest request) {
  		return updatePage(request,${code.idField});
	}
}
