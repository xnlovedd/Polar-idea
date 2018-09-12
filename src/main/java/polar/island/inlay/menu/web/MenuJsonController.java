package polar.island.inlay.menu.web;

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
import polar.island.inlay.menu.entity.MenuEntity;
import polar.island.inlay.menu.service.MenuService;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.Map;

/**
 * 菜单的接口，返回数据全部为json串。
 *
 * @author PolarLoves
 */
@Controller(value = "menuJsonController")
@RequestMapping(value = "/menu/json")
public class MenuJsonController extends BasicController {
    @Resource(name = "menuService")
    private MenuService menuService;
    private static final String MODULE_NAME = "菜单";

    /**
     * 校验访问权限
     *
     * @return
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menu:empty"})
    @ErrorMsg(tag = "校验菜单权限", type = ErrorType.JSON)
    @RequestMapping(value = "/checkPermission", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson checkPermission() {
        return new ResponseJson(Constants.CODE_SUCCESS);
    }

    /**
     * 依据条件查询数据
     *
     * @param entity 查询条件
     * @return 列表Json串。
     * @see polar.island.inlay.menu.entity.MenuEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menu:view:list"})
    @ErrorMsg(tag = "查询菜单", type = ErrorType.JSON)
    @RequestMapping(value = "/pageList", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson pageList(MenuEntity entity) {
        Map<String, Object> condition = beanToMap(entity);
        return new ResponseJson(Constants.CODE_SUCCESS, menuService.selectList(condition), null,
                menuService.selectCount(condition));
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menu:view:detail"})
    @ErrorMsg(tag = "查看菜单", type = ErrorType.JSON)
    @RequestMapping(value = "/detail", produces = "application/json;charset=utf-8")
    public ResponseJson detail(String id) {
        idCheck(id, MODULE_NAME);
        MenuEntity entity = menuService.selectOneById(id);
        existCheck(entity, MODULE_NAME);
        return new ResponseJson(Constants.CODE_SUCCESS, entity);
    }

    /**
     * 依据数据编号更新此条数据的所有值。
     *
     * @param entity 需要更新的实体
     * @return 更新条目
     * @see polar.island.inlay.menu.entity.MenuEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menu:edit"})
    @ErrorMsg(tag = "更新菜单全部字段", type = ErrorType.JSON)
    @RequestMapping(value = "/updateAllById", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson update(@Valid MenuEntity entity, BindingResult bindingResult) {
        validate(MenuEntity.class, "updateAllById", bindingResult);
        Map<String, Object> condition = beanToMap(entity);
        Long result = menuService.updateAll(condition);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
    }

    /**
     * 依据数据编号更新此条数据的所有值。
     *
     * @param entity 需要更新的实体
     * @return 更新条目
     * @see polar.island.inlay.menu.entity.MenuEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menu:edit"})
    @ErrorMsg(tag = "更新菜单单个字段", type = ErrorType.JSON)
    @RequestMapping(value = "/updateField", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson updateField(MenuEntity entity, BindingResult bindingResult) {
        validate(MenuEntity.class, "updateField", bindingResult);
        Map<String, Object> condition = beanToSingleField(entity);
        condition.put("id", entity.getId());
        Long result = menuService.updateField(condition);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
    }

    /**
     * 根据数据编号物理删除数据。
     *
     * @param ids 数据编号
     * @return 删除结果。
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menu:delete"})
    @ErrorMsg(tag = "删除多个菜单", type = ErrorType.JSON)
    @RequestMapping(value = "/deleteMulitById", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson deleteMulitById(@RequestParam(value = "ids[]", required = false) String[] ids) {
        idCheck(ids, MODULE_NAME);
        Long result = menuService.deleteMulitByIdPhysical(ids);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
    }

    /**
     * 根据数据编号物理删除数据。
     *
     * @param id 数据编号
     * @return 删除结果。
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menu:delete"})
    @ErrorMsg(tag = "删除一个菜单", type = ErrorType.JSON)
    @RequestMapping(value = "/deleteById", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson deleteById(String id) {
        idCheck(id, MODULE_NAME);
        Long result = menuService.deleteByIdPhysical(id);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
    }

    /**
     * 新增一条数据。
     *
     * @param entity 菜单数据
     * @return 新增结果。
     * @see polar.island.inlay.menu.entity.MenuEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menu:add"})
    @ErrorMsg(tag = "新增菜单", type = ErrorType.JSON)
    @RequestMapping(value = "/add", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson add(@Valid MenuEntity entity, BindingResult bindingResult) {
        validate(MenuEntity.class, "add", bindingResult);
        Map<String, Object> condition = beanToMap(entity);
        Object result = menuService.insert(condition);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "新增成功。");
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menumodel:menu"})
    @ErrorMsg(tag = "修改模板菜单", type = ErrorType.JSON)
    @RequestMapping(value = "/updateModelMenus", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson updateUserRole(String modelId, @RequestParam(value = "menuId[]", required = false) String[] menuId) {
        idCheck(modelId, null);
        menuService.updateModelMenus(modelId, menuId);
        return new ResponseJson(Constants.CODE_SUCCESS, null, "模板菜单分配成功");
    }

}
