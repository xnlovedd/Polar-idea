package polar.island.inlay.menuModel.web;

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
import polar.island.core.exception.ValidationException;
import polar.island.inlay.menuModel.entity.MenuModelEntity;
import polar.island.inlay.menuModel.service.MenuModelService;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.Map;

/**
 * 菜单模板的接口，返回数据全部为json串。
 *
 * @author PolarLoves
 */
@Controller(value = "menuModelJsonController")
@RequestMapping(value = "/menuModel/json")
public class MenuModelJsonController extends BasicController {
    @Resource(name = "menuModelService")
    private MenuModelService menuModelService;
    private static final String MODULE_NAME = null;

    /**
     * 校验访问权限
     *
     * @return
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menumodel:empty"})
    @ErrorMsg(tag = "校验菜单模板权限", type = ErrorType.JSON)
    @RequestMapping(value = "/checkPermission", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson checkPermission() {
        return new ResponseJson(Constants.CODE_SUCCESS);
    }

    /**
     * 依据条件查询分页数据，如果不传页码、每页条目，则默认分别为：1,10
     *
     * @param entity 查询条件
     * @return 列表Json串。
     * @see polar.island.inlay.menuModel.entity.MenuModelEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menumodel:view:list"})
    @ErrorMsg(tag = "查询菜单模板", type = ErrorType.JSON)
    @RequestMapping(value = "/pageList", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson pageList(MenuModelEntity entity) {
        Map<String, Object> condition = beanToMap(entity);
        return new ResponseJson(Constants.CODE_SUCCESS, menuModelService.selectPageList(condition), null,
                menuModelService.selectCount(condition));
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menumodel:view:detail"})
    @ErrorMsg(tag = "查看菜单模板", type = ErrorType.JSON)
    @RequestMapping(value = "/detail", produces = "application/json;charset=utf-8")
    public ResponseJson detail(String id) {
        idCheck(id, MODULE_NAME);
        MenuModelEntity entity = menuModelService.selectOneById(id);
        existCheck(entity, MODULE_NAME);
        return new ResponseJson(Constants.CODE_SUCCESS, entity);
    }

    /**
     * 依据数据编号更新此条数据的所有值。
     *
     * @param entity 需要更新的实体
     * @return 更新条目
     * @see polar.island.inlay.menuModel.entity.MenuModelEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menumodel:edit"})
    @ErrorMsg(tag = "更新菜单模板全部字段", type = ErrorType.JSON)
    @RequestMapping(value = "/updateAllById", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson update(@Valid MenuModelEntity entity, BindingResult bindingResult) {
        validate(MenuModelEntity.class, "updateAllById", bindingResult);
        Map<String, Object> condition = beanToMap(entity);
        Long result = menuModelService.updateAll(condition);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
    }

    /**
     * 依据数据编号更新此条数据的所有值。
     *
     * @param entity 需要更新的实体
     * @return 更新条目
     * @see polar.island.inlay.menuModel.entity.MenuModelEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menumodel:edit"})
    @ErrorMsg(tag = "更新菜单模板单个字段", type = ErrorType.JSON)
    @RequestMapping(value = "/updateField", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson updateField(@Valid MenuModelEntity entity, BindingResult bindingResult) {
        validate(MenuModelEntity.class, "updateField", bindingResult);
        Map<String, Object> condition = beanToSingleField(entity);
        condition.put("id", entity.getId());
        Long result = menuModelService.updateField(condition);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
    }

    /**
     * 根据数据编号物理删除数据。
     *
     * @param ids 数据编号
     * @return 删除结果。
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menumodel:delete"})
    @ErrorMsg(tag = "删除多个菜单模板", type = ErrorType.JSON)
    @RequestMapping(value = "/deleteMulitById", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson deleteMulitById(@RequestParam(value = "ids[]", required = false) String[] ids) {
        idCheck(ids, MODULE_NAME);
        Long result = menuModelService.deleteMulitByIdPhysical(ids);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
    }

    /**
     * 根据数据编号物理删除数据。
     *
     * @param id 数据编号
     * @return 删除结果。
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menumodel:delete"})
    @ErrorMsg(tag = "删除一个菜单模板", type = ErrorType.JSON)
    @RequestMapping(value = "/deleteById", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson deleteById(String id) {
        idCheck(id, MODULE_NAME);
        Long result = menuModelService.deleteByIdPhysical(id);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
    }

    /**
     * 新增一条数据。
     *
     * @param entity 数据
     * @return 新增结果。
     * @see polar.island.inlay.menuModel.entity.MenuModelEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menumodel:add"})
    @ErrorMsg(tag = "新增菜单模板", type = ErrorType.JSON)
    @RequestMapping(value = "/add", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson add(@Valid MenuModelEntity entity, BindingResult bindingResult) {
        validate(MenuModelEntity.class, "add", bindingResult);
        Map<String, Object> condition = beanToMap(entity);
        condition.put("defaultMenu", 0);
        Object result = menuModelService.insert(condition);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "新增成功。");
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:menumodel:default"})
    @ErrorMsg(tag = "设置默认模板", type = ErrorType.JSON)
    @RequestMapping(value = "/setDefault", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson setDefault(String id) {
        if (id == null || id.equals("")) {
            throw new ValidationException("数据编号不能为空", null);
        }
        menuModelService.setDefault(id);
        return new ResponseJson(Constants.CODE_SUCCESS, null, "设置默认模板成功");
    }
}
