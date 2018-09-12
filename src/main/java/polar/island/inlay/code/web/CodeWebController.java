package polar.island.inlay.code.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import polar.island.core.controller.BasicController;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.core.exception.ValidationException;
import polar.island.inlay.code.entity.CodeEntity;
import polar.island.inlay.code.service.CodeService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用于网页版访问，返回页面。
 *
 * @author N
 */
@Controller(value = "codeWebController")
@RequestMapping(value = "/code/web")
public class CodeWebController extends BasicController {
    @Resource(name = "codeService")
    private CodeService codeService;
    private static final String MODULE_NAME = null;

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:view:list"})
    @ErrorMsg(tag = "表单列表", type = ErrorType.JSON)
    @RequestMapping(value = {"/list", ""}, produces = "text/html;charset=utf-8")
    public String list(HttpServletRequest request) {
        return "/view/inlay/code/codeList.jsp";
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:columns"})
    @ErrorMsg(tag = "列配置", type = ErrorType.JSON)
    @RequestMapping(value = "/columns", produces = "text/html;charset=utf-8")
    public String columns(Long id, HttpServletRequest request) {
        if (id == null) {
            throw new ValidationException("数据编号不能为空", null);
        }
        request.setAttribute("columns", codeService.selectColumns(id));
        request.setAttribute("id", id);
        return "/view/inlay/code/columns.jsp";
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:edit"})
    @ErrorMsg(tag = "更新表单", type = ErrorType.JSON, suffix = "更新表单信息失败")
    @RequestMapping(value = "/update", produces = "text/html;charset=utf-8")
    public String updatePage(HttpServletRequest request, String id) {
        idCheck(id, MODULE_NAME);
        CodeEntity entity = codeService.selectOneById(id);
        request.setAttribute("code", entity);
        existCheck(entity, MODULE_NAME);
        Map<String, Object> args = new HashMap<>();
        args.put("tableType", 2);
        //查询所有的主表
        List<CodeEntity> allMainTables = codeService.selectList(args);
        request.setAttribute("allMainTables", allMainTables);
        return "/view/inlay/code/codeForm.jsp";
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:view:detail"})
    @ErrorMsg(tag = "表单详情", type = ErrorType.JSON)
    @RequestMapping(value = "/detail", produces = "text/html;charset=utf-8")
    public String detailPage(String id, HttpServletRequest request) {
        return updatePage(request, id);
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:code:edit"})
    @ErrorMsg(tag = "导入表单", type = ErrorType.JSON)
    @RequestMapping(value = "/importTable", produces = "text/html;charset=utf-8")
    public String importTable(HttpServletRequest request) {
        request.setAttribute("tableList", codeService.allTableNames());
        return "/view/inlay/code/importTable.jsp";
    }

}
