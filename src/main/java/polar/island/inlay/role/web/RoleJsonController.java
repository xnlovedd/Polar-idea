package polar.island.inlay.role.web;

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
import polar.island.inlay.role.entity.RoleEntity;
import polar.island.inlay.role.service.RoleService;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.Map;

/**
 * 角色的接口，返回数据全部为json串。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "roleJsonController")
@RequestMapping(value = "/role/json")
public class RoleJsonController extends BasicController {
	@Resource(name = "roleService")
	private RoleService roleService;
	private  static final  String MODULE_NAME="角色";
	/**
	 * 校验访问权限
	 * 
	 * @return
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:role:empty" })
	@ErrorMsg(tag = "校验角色权限", type = ErrorType.JSON)
	@RequestMapping(value = "/checkPermission", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson checkPermission() {
		return new ResponseJson(Constants.CODE_SUCCESS);
	}
	/**
	 * 依据条件查询数据
	 * 
	 * @param entity
	 *            查询条件
	 * @see polar.island.inlay.role.entity.RoleEntity
	 * @return 列表Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:role:view:list" })
	@ErrorMsg(tag = "查询角色", type = ErrorType.JSON)
	@RequestMapping(value = "/pageList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson pageList(RoleEntity entity) {
		Map<String, Object> condition = beanToMap(entity);
		return new ResponseJson(Constants.CODE_SUCCESS, roleService.selectList(condition));
	}
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:role:view:detail" })
	@ErrorMsg(tag = "查看角色", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "application/json;charset=utf-8")
	public ResponseJson detail(String id) {
		idCheck(id,MODULE_NAME);
		RoleEntity entity = roleService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		return new ResponseJson(Constants.CODE_SUCCESS, entity);
	}
	/**
	 * 依据数据编号更新此条数据的所有值。
	 * 
	 * @param entity
	 *            需要更新的实体
	 * @see polar.island.inlay.role.entity.RoleEntity
	 * @return 更新条目
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:role:edit" })
	@ErrorMsg(tag = "更新角色全部字段", type = ErrorType.JSON)
	@RequestMapping(value = "/updateAllById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson update(@Valid RoleEntity entity, BindingResult bindingResult) {
		validate(RoleEntity.class, "updateAllById",bindingResult);
		Map<String, Object> condition = beanToMap(entity);
		Long result = roleService.updateAll(condition);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
	}

	/**
	 * 根据数据编号物理删除数据。
	 * 
	 * @param id
	 *            数据编号
	 * @return 删除结果。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:role:delete" })
	@ErrorMsg(tag = "删除一个角色", type = ErrorType.JSON)
	@RequestMapping(value = "/deleteById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson deleteById(String id) {
		idCheck(id,MODULE_NAME);
		Long result = roleService.deleteByIdPhysical(id);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
	}

	/**
	 * 新增一条数据。
	 * 
	 * @param entity
	 *            数据
	 * @see polar.island.inlay.role.entity.RoleEntity
	 * @return 新增结果。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:role:add" })
	@ErrorMsg(tag = "新增角色", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson add(@Valid RoleEntity entity, BindingResult bindingResult) {
		validate(RoleEntity.class, "add",bindingResult);
		Map<String, Object> condition = beanToMap(entity);
		Object result = roleService.insert(condition);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "新增成功。");
	}

	/**
	 * 修改用户的角色信息
	 * 
	 * @param id
	 *            用户编号
	 * @param roleIds
	 *            角色列表
	 * @return 修改结果
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:user:role" })
	@ErrorMsg(tag = "修改用户角色", type = ErrorType.JSON)
	@RequestMapping(value = "/updateUserRole", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson updateUserRole(String id, @RequestParam(value = "roleIds[]", required = false) String[] roleIds) {
		idCheck(id,MODULE_NAME);
		roleService.updateUserRoles(id, roleIds);
		return new ResponseJson(Constants.CODE_SUCCESS, null, "用户角色分配成功");
	}
}
