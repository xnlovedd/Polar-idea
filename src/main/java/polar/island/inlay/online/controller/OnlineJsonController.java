package polar.island.inlay.online.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.session.ExpiredSessionException;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.DefaultSessionKey;
import org.apache.shiro.session.mgt.SessionManager;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import polar.island.core.config.Constants;
import polar.island.core.controller.BasicController;
import polar.island.core.entity.ResponseJson;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.core.exception.ValidationException;
import polar.island.inlay.online.entity.OnlineUserEntity;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.Deque;
import java.util.List;

@Controller(value = "onlineJsonController")
@RequestMapping(value = "/online/json")
public class OnlineJsonController extends BasicController {
    @Resource(name = "shiroCacheManager")
    private CacheManager cacheManager;
    @Resource(name = "sessionManager")
    private SessionManager sessionManager;
    private static final String MODULE_NAME = "在线用户";

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:online:view"})
    @ErrorMsg(tag = "查询用户", type = ErrorType.JSON)
    @RequestMapping(value = "/pageList", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson pageList(OnlineUserEntity entity) {
        if (StringUtils.isEmpty(entity.getUserId())) {
            throw new ValidationException("用户编号不能为空", null);
        }
        Cache<String, Deque<Serializable>> activeUserCache = cacheManager.getCache("activeUsers");
        Deque<Serializable> caches = activeUserCache.get(entity.getUserId());
        int size = 0;
        if (caches != null) {
            size = caches.size();
        }
        List<OnlineUserEntity> sessionList = new ArrayList<OnlineUserEntity>();
        int start = entity.getPageStartNumber();
        int end = entity.getPageOffsetNumber() + start;
        if (end > size) {
            end =  size;
        }
        if (start > size-1) {
            start = size-1;
        }
        if (size > 0) {
            int index = 0;
            for (Serializable sessionId : caches) {
                    if (index >= start && index < end) {
                    OnlineUserEntity tmp = new OnlineUserEntity();
                    try {
                        Session session = sessionManager.getSession(new DefaultSessionKey(sessionId));
                        tmp.setUserId(entity.getUserId());
                        tmp.setSessionId((String) sessionId);
                        tmp.setLastAccessTime(session.getLastAccessTime());
                        tmp.setLoginTime(session.getStartTimestamp());
                        tmp.setLoginIp(session.getHost());
                        if (session.getTimeout() > 0) {
                            tmp.setExpireTime(new Date(session.getLastAccessTime().getTime() + session.getTimeout()));
                        }
                    } catch (ExpiredSessionException e) {
                        tmp.setExpire(true);
                    }

                    sessionList.add(tmp);
                }
                index++;
            }
        }
        return new ResponseJson(Constants.CODE_SUCCESS, sessionList, null, (long)size);
    }

    @RequiresUser
    @RequiresPermissions(value = {"polar:backstage", "polar:online:downline"})
    @ErrorMsg(tag = "强制下线", type = ErrorType.JSON)
    @RequestMapping(value = "/forceDownLine", produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResponseJson forceDownLine(String sessionId, String message, String userId) {
        idCheck(sessionId, MODULE_NAME);
        try {
            Session session = sessionManager.getSession(new DefaultSessionKey(sessionId));
            if (session != null) {
                session.setAttribute(Constants.FORCE_DOWNLINE_FLAG, true);
                session.setAttribute(Constants.FORCE_DOWNLINE_MSG, message);
            }
        } catch (ExpiredSessionException e) {
                //用户过期，不做操作
        }
        //移除活跃用户
        Cache<String, Deque<Serializable>> activeUserCache = cacheManager.getCache("activeUsers");
        Deque<Serializable> caches = activeUserCache.get(userId);
        caches.remove(sessionId);
        //更新缓存
        activeUserCache.put(userId, caches);
        return new ResponseJson(Constants.CODE_SUCCESS, 1, "强制下线成功。");
    }

}
