package polar.island.inlay.online.entity;

import polar.island.core.entity.BasicEntity;

import java.util.Date;

/**
 * 在线用户实体类
 *
 * @author PolarLoves
 */
public class OnlineUserEntity extends BasicEntity {
    /** 用户编号 **/
    private String userId;
    /** 编号 **/
    private String sessionId;
    /** 登录ip **/
    private String loginIp;
    /** 登录时间 **/
    private Date loginTime;
    /** 最后一次活跃时间 **/
    private Date lastAccessTime;
    /** 到期时间 **/
    private Date expireTime;
    private boolean expire;

    public boolean isExpire() {
        return expire;
    }

    public void setExpire(boolean expire) {
        this.expire = expire;
    }

    public Date getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(Date expireTime) {
        this.expireTime = expireTime;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public String getLoginIp() {
        return loginIp;
    }

    public void setLoginIp(String loginIp) {
        this.loginIp = loginIp;
    }

    public Date getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(Date loginTime) {
        this.loginTime = loginTime;
    }

    public Date getLastAccessTime() {
        return lastAccessTime;
    }

    public void setLastAccessTime(Date lastAccessTime) {
        this.lastAccessTime = lastAccessTime;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
}
