package polar.island.inlay.tree.web;

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
import polar.island.inlay.tree.entity.TreeEntity;
import polar.island.inlay.tree.service.TreeService;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.Map;

/**
 * 树结构的接口，返回数据全部为json串。
 * 
 * @author PolarLoves
 *
 */
@Controller(value = "treeJsonController")
@RequestMapping(value = "/tree/json")
public class TreeJsonController extends BasicController {
	@Resource(name = "treeService")
	private TreeService treeService;
	private  static final  String MODULE_NAME="树结构";
	/**
	 * 校验访问权限
	 * 
	 * @return
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:tree:empty" })
	@ErrorMsg(tag = "校验树结构权限", type = ErrorType.JSON)
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
	 * @see polar.island.inlay.tree.entity.TreeEntity
	 * @return 列表Json串。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:tree:view:list" })
	@ErrorMsg(tag = "查询树结构", type = ErrorType.JSON)
	@RequestMapping(value = "/pageList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson pageList(TreeEntity entity) {
		Map<String, Object> condition = beanToMap(entity);
		return new ResponseJson(Constants.CODE_SUCCESS,  treeService.selectPageList(condition),null,
				treeService.selectCount(condition));
	}

	/**
	 * 查看树结构详情的json串
	 * 
	 * @param id
	 *            数据编号
	 * @return 详情json串
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:tree:view:detail" })
	@ErrorMsg(tag = "查看树结构详情的json串", type = ErrorType.JSON)
	@RequestMapping(value = "/detail", produces = "application/json;charset=utf-8")
	public ResponseJson detail(String id) {
		idCheck(id,MODULE_NAME);
		TreeEntity entity = treeService.selectOneById(id);
		existCheck(entity,MODULE_NAME);
		return new ResponseJson(Constants.CODE_SUCCESS, entity);
	}

	/**
	 * 依据数据编号更新此条数据的所有值。
	 * 
	 * @param entity
	 *            需要更新的实体
	 * @see polar.island.inlay.tree.entity.TreeEntity
	 * @return 更新条目
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:tree:edit" })
	@ErrorMsg(tag = "更新树结构全部字段", type = ErrorType.JSON)
	@RequestMapping(value = "/updateAllById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson update(@Valid TreeEntity entity, BindingResult bindingResult) {
		validate(TreeEntity.class, "updateAllById",bindingResult);
		Map<String, Object> condition = beanToMap(entity);
		Long result = treeService.updateAll(condition);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
	}

	/**
	 * 依据数据编号更新此条数据的所有值。
	 * 
	 * @param entity
	 *            需要更新的实体
	 * @see polar.island.inlay.tree.entity.TreeEntity
	 * @return 更新条目
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:tree:edit" })
	@ErrorMsg(tag = "更新树结构单个字段", type = ErrorType.JSON)
	@RequestMapping(value = "/updateField", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson updateField(@Valid TreeEntity entity, BindingResult bindingResult){
		validate(TreeEntity.class, "updateField",bindingResult);
		Map<String, Object> condition = beanToSingleField(entity);
		condition.put("id", entity.getId());
		Long result = treeService.updateField(condition);
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
	@RequiresPermissions(value = { "polar:backstage", "polar:tree:delete" })
	@ErrorMsg(tag = "删除多个树结构", type = ErrorType.JSON)
	@RequestMapping(value = "/deleteMulitById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson deleteMulitById(@RequestParam(value = "ids[]", required = false) String[] ids) {
		idCheck(ids,MODULE_NAME);
		Long result = treeService.deleteMulitByIdPhysical(ids);
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
	@RequiresPermissions(value = { "polar:backstage", "polar:tree:delete" })
	@ErrorMsg(tag = "删除一个树结构", type = ErrorType.JSON)
	@RequestMapping(value = "/deleteById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson deleteById(String id) {
		idCheck(id,MODULE_NAME);
		Long result = treeService.deleteByIdPhysical(id);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
	}

	/**
	 * 新增一条数据。
	 * 
	 * @param entity
	 *            数据
	 * @see polar.island.inlay.tree.entity.TreeEntity
	 * @return 新增结果。
	 */
	@RequiresUser
	@RequiresPermissions(value = { "polar:backstage", "polar:tree:add" })
	@ErrorMsg(tag = "新增树结构", type = ErrorType.JSON)
	@RequestMapping(value = "/add", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseJson add(@Valid TreeEntity entity, BindingResult bindingResult) {
		validate(TreeEntity.class, "add",bindingResult);
		Map<String, Object> condition = beanToMap(entity);
		Object result = treeService.insert(condition);
		return new ResponseJson(Constants.CODE_SUCCESS, result, "新增成功。");
	}
}
