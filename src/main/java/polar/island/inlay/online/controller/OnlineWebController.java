package polar.island.inlay.online.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import polar.island.core.controller.BasicController;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.core.exception.ValidationException;

import javax.servlet.http.HttpServletRequest;

@Controller(value = "onlineWebController")
@RequestMapping(value = "/online/web")
public class OnlineWebController extends BasicController {

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:online:view"})
    @ErrorMsg(tag = "在线用户列表", type = ErrorType.JSON)
    @RequestMapping(value = {"/list", ""}, produces = "text/html;charset=utf-8")
    public String list(Long userId, HttpServletRequest request) {
        if (userId == null) {
            throw new ValidationException("用户编号不能为空", null);
        }
        request.setAttribute("userId", userId);
        return "/view/inlay/online/onlineList.jsp";
    }
}
