package polar.island.inlay.permission.web;

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
import polar.island.inlay.permission.entity.PermissionEntity;
import polar.island.inlay.permission.service.PermissionService;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.Map;

/**
 * 权限的接口，返回数据全部为json串。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "permissionJsonController")
@RequestMapping(value = "/permission/json")
public class PermissionJsonController extends BasicController {
	@Resource(name = "permissionService")
	private PermissionService permissionService;
	private  static final  String MODULE_NAME=null;
	/**
	 * 校验访问权限
	 * 
	 * @return
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:permission:empty" })
	@ErrorMsg(tag = "校验权限管理权限", type = ErrorType.JSON)
	@RequestMapping(value = "/checkPermission", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson checkPermission() {
		return new ResponseJson(Constants.CODE_SUCCESS, null);
	}
	/**
	 * 依据条件查询数据
	 * 
	 * @param entity
	 *            查询条件
	 * @see polar.island.inlay.permission.entity.PermissionEntity
	 * @return 列表Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:permission:view:list" })
	@ErrorMsg(tag = "查询权限", type = ErrorType.JSON)
	@RequestMapping(value = "/pageList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson pageList(PermissionEntity entity) {
		Map<String, Object> condition = beanToMap(entity);
		return new ResponseJson(Constants.CODE_SUCCESS, permissionService.selectList(condition), null,
				permissionService.selectCount(condition));
	}
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:permission:view:detail" })
	@ErrorMsg(tag = "查看权限", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "application/json;charset=utf-8")
	public String detail(String id) {
		idCheck(id,MODULE_NAME);
		PermissionEntity entity = permissionService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		return "/view/inlay/permission/permissionForm.jsp";
	}
	/**
	 * 依据数据编号更新此条数据的所有值。
	 * 
	 * @param entity
	 *            需要更新的实体
	 * @return 更新条目
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:permission:edit" })
	@ErrorMsg(tag = "更新权限全部字段", type = ErrorType.JSON)
	@RequestMapping(value = "/updateAllById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson update(@Valid PermissionEntity entity, BindingResult bindingResult) {
		validate(PermissionEntity.class, "updateAllById",bindingResult);
		Map<String, Object> condition = beanToMap(entity);
		Long result = permissionService.updateAll(condition);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
	}

	/**
	 * 依据数据编号更新此条数据的所有值。
	 * 
	 * @param entity
	 *            需要更新的实体
	 * @see polar.island.inlay.permission.entity.PermissionEntity
	 * @return 更新条目
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:permission:edit" })
	@ErrorMsg(tag = "更新权限单个字段", type = ErrorType.JSON)
	@RequestMapping(value = "/updateField", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson updateField(@Valid PermissionEntity entity, BindingResult bindingResult) {
		validate(PermissionEntity.class, "updateField",bindingResult);
		Map<String, Object> condition = beanToSingleField(entity);
		condition.put("id", entity.getId());
		Long result = permissionService.updateField(condition);
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
	@RequiresPermissions(value = { "polar:backstage", "polar:permission:delete" })
	@ErrorMsg(tag = "删除多个权限", type = ErrorType.JSON)
	@RequestMapping(value = "/deleteMulitById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson deleteMulitById(@RequestParam(value = "ids[]", required = false) String[] ids) {
		idCheck(ids,MODULE_NAME);
		Long result = permissionService.deleteMulitByIdPhysical(ids);
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
	@RequiresPermissions(value = { "polar:backstage", "polar:permission:delete" })
	@ErrorMsg(tag = "删除一个权限", type = ErrorType.JSON)
	@RequestMapping(value = "/deleteById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson deleteById(String id) {
		idCheck(id,MODULE_NAME);
		Long result = permissionService.deleteByIdPhysical(id);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
	}

	/**
	 * 新增一条数据。
	 * 
	 * @param entity
	 *            数据
	 * @see polar.island.inlay.permission.entity.PermissionEntity
	 * @return 新增结果。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:permission:add" })
	@ErrorMsg(tag = "新增权限", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson add(@Valid PermissionEntity entity ,BindingResult bindingResult) {
		validate(PermissionEntity.class, "add",bindingResult);
		Map<String, Object> condition = beanToMap(entity);
		Object result = permissionService.insert(condition);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "新增成功。");
	}

	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:role:permission" })
	@ErrorMsg(tag = "修改角色权限", type = ErrorType.JSON)
	@RequestMapping(value = "/updateRolePermissions", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson updateRolePermissions(String id,
			@RequestParam(value = "permissionIds[]", required = false) String[] permissionIds) {
		idCheck(id,MODULE_NAME);
		idCheck(permissionIds,MODULE_NAME);
		permissionService.updateRolePermissions(id, permissionIds);
		return new ResponseJson(Constants.CODE_SUCCESS, null, "角色权限分配成功");
	}

	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:org:permission" })
	@ErrorMsg(tag = "修改部门权限", type = ErrorType.JSON)
	@RequestMapping(value = "/updateOrgPermissions", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson updateOrgPermissions(String id,
											  @RequestParam(value = "permissionIds[]", required = false) String[] permissionIds) {
		idCheck(id,MODULE_NAME);
		idCheck(permissionIds,MODULE_NAME);
		permissionService.updateOrgPermissions(id, permissionIds);
		return new ResponseJson(Constants.CODE_SUCCESS, null, "部门权限分配成功");
	}
}
