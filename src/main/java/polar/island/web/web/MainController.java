package polar.island.web.web;

import org.apache.commons.io.IOUtils;
import org.apache.ibatis.javassist.tools.reflect.CannotCreateException;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import polar.island.core.config.Constants;
import polar.island.core.controller.BasicController;
import polar.island.core.entity.ResponseJson;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.core.exception.FrameWorkException;
import polar.island.core.exception.ValidationException;
import polar.island.core.security.service.UserService;
import polar.island.core.util.*;
import polar.island.inlay.menu.service.MenuService;
import polar.island.security.realm.ShiroPrincipal;
import polar.island.web.util.UserUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;

@Controller(value = "mainController")
@RequestMapping(value = "/")
public class MainController extends BasicController {
    @Resource(name = "menuService")
    private MenuService menuService;
    @Resource(name = "userService")
    private UserService userService;

    @ErrorMsg(tag = "首页", type = ErrorType.WEB)
    @RequestMapping(value = {"mainPage"}, produces = "text/html;charset=utf-8")
    public String mainPage(HttpServletRequest request) {
        String userId = UserUtil.getUserId();
        if (userId != null) {
            request.setAttribute("menus", menuService.userMenus(UserUtil.getUserId()));
            request.setAttribute("user", userService.selectOneById(userId));
        }
        return "/view/sys/Main.jsp";
    }

    @ErrorMsg(tag = "开发文档", type = ErrorType.JSON,writeLogs = false)
    @RequestMapping(value = {"developmentDocument"}, produces = "text/html;charset=utf-8")
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage"})
    public String developmentDocument(HttpServletRequest request,String folder) {
        String path=folder.replace(",","/");
        String real=this.getClass().getClassLoader().getResource("").getPath()+"../../view/doc/"+path+".jsp";
        if(!new File(real).exists()){
            throw new ValidationException("您找的东西走丢了~",null) ;
        }
        return "/view/doc/"+path+".jsp";
    }

    @ErrorMsg(tag = "登录页", type = ErrorType.WEB)
    @RequestMapping(value = {""}, produces = "text/html;charset=utf-8")
    public String logInPage(HttpServletRequest request) {
        String userId = UserUtil.getUserId();
        if (userId != null) {
            request.setAttribute("menus", menuService.userMenus(UserUtil.getUserId()));
            request.setAttribute("user", userService.selectOneById(userId));
        } else {
            return "/view/sys/login.jsp";
        }
        return "/view/sys/Main.jsp";
    }

    @ErrorMsg(tag = "导航页", type = ErrorType.WEB)
    @RequestMapping(value = "/firstPage", produces = "text/html;charset=utf-8")
    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage"})
    public String firstPage() {
        return "/view/sys/index.jsp";
    }

    @ErrorMsg(tag = "文件上传", type = ErrorType.JSON)
    @RequestMapping(value = "/uploadFile", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson upLoadFile(MultipartFile file, HttpServletRequest request) {
        FileOutputStream out = null;
        InputStream inputStream = null;
        if (file == null) {
            throw new ValidationException("文件不能为空", null);
        }

        try {
            File file2 = new File(PropertieUtil.getSetting("FILE_PATH") + "/" + CommonUtil.randomId()+"/"+file.getOriginalFilename());
            if (!file2.getParentFile().exists()) {
                file2.getParentFile().mkdirs();
            }
            boolean flag = file2.createNewFile();
            if (!flag) {
                throw new CannotCreateException("文件无法被创建");
            }
            out = new FileOutputStream(file2);
            inputStream = file.getInputStream();
            byte[] tmp = new byte[1024];
            int i = -1;
            while ((i = inputStream.read(tmp)) != -1) {
                out.write(tmp, 0, i);
            }
            String path = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                    + request.getContextPath() + "/downFile?fileUrl="
                    + URLEncoder.encode(file2.getAbsolutePath(), "UTF-8");

            return new ResponseJson(Constants.CODE_SUCCESS, path);
        } catch (Exception e) {
            e.printStackTrace();
            throw new FrameWorkException(Constants.CODE_FILE, "文件上传失败", e, false);
        } finally {
            IOUtils.closeQuietly(out);
            IOUtils.closeQuietly(inputStream);
        }
    }

    @ErrorMsg(tag = "查看图片", type = ErrorType.JSON)
    @RequestMapping(value = "/downFile", produces = "application/json;charset=utf-8")
    public void viewPic(String fileUrl, HttpServletResponse response) {
        try {
            String path=URLDecoder.decode(fileUrl, "UTF-8");
            String name=path.substring(path.lastIndexOf(java.io.File.separator)+java.io.File.separator.length(),path.length());
            ResponseUtil.renderResponseFileHeader(name,response);
            FileUtil.writeFile(name, path,response.getOutputStream());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @ResponseBody
    @ErrorMsg(tag = "登录", type = ErrorType.JSON)
    @RequestMapping(value = "/logIn", produces = "application/json;charset=utf-8", method = RequestMethod.POST)
    public ResponseJson logIn(String userName, String password, String code, HttpSession httpSession,
                        HttpServletRequest request) {

        // SecurityUtils.getSubject().getSession().setTimeout(-1000l);--设置会话永不超时
        String rrcode = (String) httpSession.getAttribute("rrCode");
        if (rrcode == null) {
            throw new FrameWorkException(Constants.CODE_SERVER_COMMON, "验证码无效或者已经过期，请重新输入", null, false);
        }
        if (code == null) {
            throw new FrameWorkException(Constants.CODE_SERVER_COMMON, "请输入验证码", null, false);
        }
        if (!rrcode.equals(code)) {
            throw new FrameWorkException(Constants.CODE_SERVER_COMMON, "验证码输入错误，请重新输入", null, false);
        }
        if (SecurityUtils.getSubject().isAuthenticated()) {
            // 如果已认证，先退出登录
            SecurityUtils.getSubject().logout();
        }
        UsernamePasswordToken token = new UsernamePasswordToken(userName, password, false);
        SecurityUtils.getSubject().login(token);
        ShiroPrincipal principal = (ShiroPrincipal) SecurityUtils.getSubject().getPrincipal();
        userService.logIn(principal.getUser().getId(), RequestUtil.getIpAddr(request));
        return new ResponseJson(Constants.CODE_SUCCESS, null, "登录成功");
    }

    @ResponseBody
    @ErrorMsg(tag = "退出登录", type = ErrorType.JSON)
    @RequestMapping(value = "/logOut", produces = "application/json;charset=utf-8")
    public ResponseJson logOut() {
        SecurityUtils.getSubject().logout();
        return new ResponseJson(Constants.CODE_SUCCESS, null,"退出登录成功");
    }

    @ErrorMsg(tag = "获取验证码", type = ErrorType.JSON)
    @RequestMapping(value = "/code")
    public String code() {
        SecurityUtils.getSubject().getSession(true);
        return "/view/sys/code.jsp";
    }

}
