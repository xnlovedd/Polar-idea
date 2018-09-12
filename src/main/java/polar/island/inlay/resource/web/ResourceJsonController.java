package polar.island.inlay.resource.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import polar.island.core.config.Constants;
import polar.island.core.controller.BasicController;
import polar.island.core.entity.ResponseJson;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.core.security.entity.ResourceEntity;
import polar.island.core.security.service.ResourceService;
import polar.island.inlay.permission.service.PermissionService;
import polar.island.security.service.SecurityService;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.Map;


/**
 * 资源的接口，返回数据全部为json串。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "resourceJsonController")
@RequestMapping(value = "/resource/json")
public class ResourceJsonController extends BasicController {
	@Resource(name = "resourceService")
	private ResourceService resourceService;
	@Resource(name = "permissionService")
	private PermissionService permissionService;
	@Resource(name = "securityService")
	private SecurityService securityService;
	private  static final  String MODULE_NAME="资源";
	/**
	 * 校验访问权限
	 * 
	 * @return
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:resource:empty" })
	@ErrorMsg(tag = "校验资源权限", type = ErrorType.JSON)
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
	 * @see polar.island.core.security.entity.ResourceEntity
	 * @return 列表Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:resource:view:list" })
	@ErrorMsg(tag = "查询资源", type = ErrorType.JSON)
	@RequestMapping(value = "/pageList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson pageList(ResourceEntity entity) {
		Map<String, Object> condition = beanToMap(entity);
		return new ResponseJson(Constants.CODE_SUCCESS, resourceService.selectPageList(condition), null,
				resourceService.selectCount(condition));
	}
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage","polar:resource:view:detail"})
	@ErrorMsg(tag = "查看资源", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "application/json;charset=utf-8")
	public ResponseJson detail(String id) {
		idCheck(id,MODULE_NAME);
		ResourceEntity entity = resourceService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		return new ResponseJson(Constants.CODE_SUCCESS, entity);
	}
	/**
	 * 依据数据编号更新此条数据的所有值。
	 * 
	 * @param entity
	 *            需要更新的实体
	 * @see polar.island.core.security.entity.ResourceEntity
	 * @return 更新条目
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:resource:edit" })
	@ErrorMsg(tag = "更新资源全部字段", type = ErrorType.JSON)
	@RequestMapping(value = "/updateAllById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson update(@Valid ResourceEntity entity, BindingResult bindingResult) {
		validate(ResourceEntity.class, "updateAllById",bindingResult);
		Map<String, Object> condition = beanToMap(entity);
		condition.put("id", entity.getId());
		Long result = resourceService.updateAll(condition);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
	}

	/**
	 * 依据数据编号更新此条数据的所有值。
	 * 
	 * @param entity
	 *            需要更新的实体
	 * @see polar.island.core.security.entity.ResourceEntity
	 * @return 更新条目
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:resource:edit" })
	@ErrorMsg(tag = "更新资源单个字段", type = ErrorType.JSON)
	@RequestMapping(value = "/updateField", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson updateField(@Valid ResourceEntity entity, BindingResult bindingResult)  {
		validate(ResourceEntity.class, "updateField",bindingResult);
		Map<String, Object> condition = beanToSingleField(entity);
		condition.put("id", entity.getId());
		Long result = resourceService.updateField(condition);
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
	@RequiresPermissions(value = { "polar:backstage", "polar:resource:delete" })
	@ErrorMsg(tag = "删除多个资源", type = ErrorType.JSON)
	@RequestMapping(value = "/deleteMulitById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson deleteMulitById(@RequestParam(value = "ids[]", required = false) String[] ids) {
		idCheck(ids,MODULE_NAME);
		Long result = resourceService.deleteMulitByIdPhysical(ids);
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
	@RequiresPermissions(value = { "polar:backstage", "polar:resource:delete" })
	@ErrorMsg(tag = "删除一个资源", type = ErrorType.JSON)
	@RequestMapping(value = "/deleteById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson deleteById(String id) {
		idCheck(id,MODULE_NAME);
		Long result = resourceService.deleteByIdPhysical(id);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
	}

	/**
	 * 新增一条数据。
	 * 
	 * @param entity
	 *            数据
	 * @return 新增结果。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:resource:add" })
	@ErrorMsg(tag = "新增资源", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson add(@Valid ResourceEntity entity, BindingResult bindingResult) {
		validate(ResourceEntity.class, "add",bindingResult);
		Map<String, Object> condition = beanToMap(entity);
		Object result = resourceService.insert(condition);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "新增成功。");
	}

	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:resource:permission" })
	@ErrorMsg(tag = "修改资源权限", type = ErrorType.JSON)
	@RequestMapping(value = "/updateResourcePermissions", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson updateResourcePermissions(String id,
			@RequestParam(value = "permissionIds[]", required = false) String[] permissionIds) {
		idCheck(id,MODULE_NAME);
		permissionService.updateResourcePermissions(id, permissionIds);
		return new ResponseJson(Constants.CODE_SUCCESS, null, "资源权限设置成功");
	}

	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:resource:reload" })
	@ErrorMsg(tag = "重置资源", type = ErrorType.JSON)
	@RequestMapping(value = "/reloadResource", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson reloadResource() {
		securityService.reloadResource();
		return new ResponseJson(Constants.CODE_SUCCESS, null, "重置资源成功");
	}

}
