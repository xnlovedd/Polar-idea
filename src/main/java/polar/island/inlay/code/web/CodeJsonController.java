package polar.island.inlay.code.web;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import polar.island.core.config.Constants;
import polar.island.core.controller.BasicController;
import polar.island.core.entity.ResponseJson;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.core.exception.DataNotExistException;
import polar.island.core.exception.FrameWorkException;
import polar.island.core.exception.ValidationException;
import polar.island.core.util.CommonUtil;
import polar.island.core.util.EntityUtil;
import polar.island.core.util.GsonUtil;
import polar.island.inlay.code.entity.CodeColumn;
import polar.island.inlay.code.entity.CodeEntity;
import polar.island.inlay.code.entity.TableColumnEntity;
import polar.island.inlay.code.service.CodeService;
import polar.island.inlay.code.util.FreeMarkerUtil;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.*;

/**
 * XX的接口，返回数据全部为json串。
 *
 * @author N
 */
@Validated
@Controller(value = "codeJsonController")
@RequestMapping(value = "/code/json")
public class CodeJsonController extends BasicController {
    @Resource(name = "codeService")
    private CodeService codeService;
    private static final String MODULE_NAME = null;

    /**
     * 校验访问权限
     *
     * @return
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:empty"})
    @ErrorMsg(tag = "校验代码生成权限", type = ErrorType.JSON)
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
     * @see polar.island.inlay.code.entity.CodeEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:view:list"})
    @ErrorMsg(tag = "表单列表", type = ErrorType.JSON)
    @RequestMapping(value = "/pageList", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson pageList(CodeEntity entity) {
        Map<String, Object> condition = beanToMap(entity);
        return new ResponseJson(Constants.CODE_SUCCESS, codeService.selectPageList(condition), null, codeService.selectCount(condition));
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:view:detail"})
    @ErrorMsg(tag = "表单详情", type = ErrorType.JSON)
    @RequestMapping(value = "/detail", produces = "application/json;charset=utf-8")
    public ResponseJson detail(String id) {
        idCheck(id, MODULE_NAME);
        CodeEntity entity = codeService.selectOneById(id);
        existCheck(entity, MODULE_NAME);
        return new ResponseJson(Constants.CODE_SUCCESS, entity);
    }

    /**
     * 依据数据编号更新此条数据的所有值，如果为逻辑删除，其‘有效性’字段不会更新。
     *
     * @param entity 需要更新的实体
     * @return 更新条目
     * @see polar.island.inlay.code.entity.CodeEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:edit"})
    @ErrorMsg(tag = "更新表单", type = ErrorType.JSON)
    @RequestMapping(value = "/updateAllById", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson update(@Valid CodeEntity entity, BindingResult bindingResult) {
        validate(CodeEntity.class, "updateAllById", bindingResult);
        if (3 == entity.getTableType()) {
            if (entity.getModuleType() != 1) {
                throw new FrameWorkException(Constants.CODE_SERVER_COMMON, "子表必须列表详情均为实体类！", null, false);
            }
        }
        Map<String, Object> condition = beanToMap(entity);
        condition.put("updateDate", new Date());
        Long result = codeService.updateAll(condition);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
    }

    /**
     * 依据数据编号更新此条数据的所有值，如果为逻辑删除，其‘有效性’字段不会更新。
     *
     * @param entity 需要更新的实体
     * @return 更新条目
     * @see polar.island.inlay.code.entity.CodeEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:edit"})
    @ErrorMsg(tag = "更新表单", type = ErrorType.JSON)
    @RequestMapping(value = "/updateField", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson updateField(@Valid CodeEntity entity, BindingResult bindingResult) {
        validate(CodeEntity.class, "updateField", bindingResult);
        Map<String, Object> condition = beanToSingleField(entity);
        condition.put("updateDate", new Date());
        condition.put("id", entity.getId());
        Long result = codeService.updateField(condition);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功修改了" + result + "条数据。");
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:edit"})
    @ErrorMsg(tag = "导入表单", type = ErrorType.JSON)
    @RequestMapping(value = "/importTable", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson importTable(String tableName, String commont, String moduleName) {
        if (StringUtils.isEmpty(tableName)) {
            throw new ValidationException("表名不能为空", null);
        }
        if (StringUtils.isEmpty(commont)) {
            throw new ValidationException("表中文名不能为空", null);
        }
        if (StringUtils.isEmpty(moduleName)) {
            throw new ValidationException("模块名称不能为空", null);
        }
        codeService.importTable(tableName, commont, moduleName);
        return new ResponseJson(Constants.CODE_SUCCESS, "导入成功", null);
    }

    /**
     * 根据数据编号物理删除数据。
     *
     * @param ids 数据编号
     * @return 删除结果。
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:delete"})
    @ErrorMsg(tag = "删除表单", type = ErrorType.JSON)
    @RequestMapping(value = "/deleteMulitById", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson deleteMulitById(@RequestParam(value = "ids[]", required = false) String[] ids) {
        idCheck(ids, MODULE_NAME);
        Long result = codeService.deleteMulitByIdPhysical(ids);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
    }

    /**
     * 根据数据编号物理删除数据。
     *
     * @param id 数据编号
     * @return 删除结果。
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:delete"})
    @ErrorMsg(tag = "删除表单", type = ErrorType.JSON)
    @RequestMapping(value = "/deleteById", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson deleteByIdPhysical(String id) {
        idCheck(id, MODULE_NAME);
        Long result = codeService.deleteByIdPhysical(id);
        return new ResponseJson(Constants.CODE_SUCCESS, result, "您成功删除了" + result + "条数据。");
    }

    /**
     * 修改列。
     *
     * @param entity 访问参数
     * @return 修改结果
     * @see polar.island.inlay.code.entity.CodeEntity
     */
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:columns"})
    @ErrorMsg(tag = "修改列", type = ErrorType.JSON)
    @RequestMapping(value = "/updateColumns", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson updateColumns(@Valid TableColumnEntity entity, BindingResult bindingResult) {
        if (entity == null) {
            throw new ValidationException("数据不能为空", null);
        }
        if (entity.getTableId() == null) {
            throw new ValidationException("表编号不能为空", null);
        }
        if (entity.getList() == null || entity.getList().isEmpty()) {
            throw new ValidationException("列不能为空", null);
        }
        validate(bindingResult);
        codeService.insertColumns(entity.getList(), entity.getTableId());
        return new ResponseJson(Constants.CODE_SUCCESS, true, "列属性修改成功");
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:code"})
    @ErrorMsg(tag = "生成代码", type = ErrorType.JSON)
    @RequestMapping(value = "/writeCodes", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson writeCodes(String id) {
        idCheck(id, MODULE_NAME);
        CodeEntity entity = codeService.selectOneById(id);
        existCheck(entity, MODULE_NAME);
        if (3 == entity.getTableType()) {
            throw new FrameWorkException(Constants.CODE_VALIDATION,"子表无法执行此操作，请在主表执行此操作！", null, false);
        }
        List<CodeColumn> columns = null;
        try {
            columns = codeService.selectColumns(CommonUtil.str2Long(id));
        } catch (NumberFormatException e) {
            throw new ValidationException("数据编号格式不正确", null);
        }
        if (columns == null || columns.isEmpty()) {
            throw new DataNotExistException("列未配置， 请先配置列属性", null);
        }
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("code", entity);
        List<Map<String, Object>> columnData=new ArrayList<Map<String, Object>>();
        for(CodeColumn column:columns){
            Map<String, Object> bean= EntityUtil.beanToMap(column);
                String groupName=StringEscapeUtils.unescapeHtml4(CommonUtil.valueOf(bean.get("groupName")));
                if(StringUtils.isEmpty(groupName)){
                    Map<String, Object> groupData= new HashMap<>();
                    bean.put("group",groupData);
                    columnData.add(bean);
                    continue;
                }
                String[] groups=groupName.split(",");
                String group="";
                if(groups!=null&&groups.length>0){
                    int index=0;
                    for(String temp:groups){
                        String str=temp.replace(":","\":\"");
                        str="\""+str+"\"";
                        if(index==0){
                            group=group+str;
                        }else {
                            group=group+","+str;
                        }
                        index++;
                    }
                }
                group="{"+group+"}";
                Map<String, Object> groupData= GsonUtil.jsonToObject(group,HashMap.class);
                bean.put("group",groupData);
                columnData.add(bean);
        }
        data.put("columns", columnData);
        List<Map<String, Object>> children = null;
        if (2 == entity.getTableType()) {
            children = codeService.allChildrens("" + entity.getId());
        }
        String str;
        try {
            String path = "common";
            if (entity.getTableType() != null) {
                if (entity.getTableType() == 1) {
                    path = "tree";
                } else if (entity.getTableType() == 2) {
                    path = "many";
                }
            }
            if (!CollectionUtils.isEmpty(children)) {
                for (Map<String, Object> child : children) {
                    child.put("parent", data);
                    FreeMarkerUtil.genChildCode(child, "many/child");
                }
            }
            data.put("children", children);
            str = FreeMarkerUtil.genCode(data, path);
            return new ResponseJson(Constants.CODE_SUCCESS, str,"代码生成成功");
        } catch (Exception e) {
            throw new FrameWorkException(Constants.CODE_SERVER_COMMON, "代码生成失败", e);
        }
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:columns"})
    @ErrorMsg(tag = "生成列", type = ErrorType.JSON)
    @RequestMapping(value = "/genColumns", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson genColumns(String id) {
        idCheck(id, MODULE_NAME);
        CodeEntity entity = codeService.selectOneById(id);
        existCheck(entity, MODULE_NAME);
        codeService.genColumns(CommonUtil.str2Long(id), entity);
        return new ResponseJson(Constants.CODE_SUCCESS, true, "列生成成功");
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:setting"})
    @ErrorMsg(tag = "生成配置", type = ErrorType.JSON)
    @RequestMapping(value = "/genSetting", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson genSetting(String id) {
        idCheck(id, MODULE_NAME);
        CodeEntity entity = codeService.selectOneById(id);
        existCheck(entity, MODULE_NAME);
        codeService.genSettings(entity);
        return new ResponseJson(Constants.CODE_SUCCESS, true, "权限生成成功");
    }
}
