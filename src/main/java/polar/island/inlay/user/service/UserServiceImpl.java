package polar.island.inlay.user.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import polar.island.core.config.Constants;
import polar.island.core.exception.FrameWorkException;
import polar.island.core.security.EncryManager;
import polar.island.core.security.entity.UserEntity;
import polar.island.core.security.service.UserService;
import polar.island.core.service.BasicServiceImpl;
import polar.island.inlay.menuModel.dao.MenuModelDao;
import polar.island.inlay.user.dao.UserDao;

import javax.annotation.Resource;
import java.util.*;

@Transactional(readOnly = true)
@Service(value = "userService")
public class UserServiceImpl extends BasicServiceImpl<UserEntity, UserEntity, UserDao> implements UserService {
    @Resource(name = "userDao")
    private UserDao userDao;
    @Resource(name = "menuModelDao")
    private MenuModelDao menuModelDao;
    @Resource(name = "encryManager")
    private EncryManager encryManager;


    @Override
    public UserDao getDao() {
        return userDao;
    }

    @Transactional(readOnly = false)
    @Override
    public Object insert(Map<String, Object> condition) {
        if (selectUserByUserName(condition.get("userName").toString()) != null) {
            throw new FrameWorkException(Constants.CODE_COMMON, "当前用户已被注册", null);
        }
        userDao.insert(condition);
        return condition.get("id");
    }

    @Override
    public UserEntity selectUserByUserName(String userName) {
        Map<String, Object> condition = new HashMap<String, Object>();
        condition.put("userName", userName);
        return selectOneByCondition(condition);
    }

    @Transactional(readOnly = false)
    @Override
    public void logIn(Long id, String host) {
        Map<String, Object> condition = new HashMap<String, Object>();
        condition.put("id", id);
        condition.put("host", host);
        condition.put("logInDate", new Date());
        userDao.logIn(condition);
    }


    @Override
    public Set<String> userRoles(String userId) {
        Map<String, Object> condition = new HashMap<String, Object>();
        condition.put("userId", userId);
        List<String> result = userDao.userRoles(condition);
        Set<String> set = new HashSet<String>();
        set.addAll(result);
        return set;
    }

    @Transactional(readOnly = false)
    @Override
    public Long deleteByIdPhysical(String id) {
        return super.deleteByIdPhysical(id);
    }

    @Transactional(readOnly = false)
    public Long disableUser(String id) {
        return getDao().disableUser(id);
    }

    @Transactional(readOnly = false)
    public Long enableUser(String id) {
        return getDao().enableUser(id);
    }
    @Transactional(readOnly = false)
    @Override
    public Long updateSelf(Map<String, Object> condition) {
        return getDao().updateSelf(condition);
    }

    @Override
    public Set<String> userPermissions(String userId) {
        Map<String, Object> condition = new HashMap<String, Object>();
        condition.put("userId", userId);
        List<String> result = userDao.userPermissions(condition);
        Set<String> set = new HashSet<String>();
        set.addAll(result);
        List<String> orgPermissions = userDao.orgPermissions(condition);
        set.addAll(orgPermissions);
        return set;
    }

    @Transactional(readOnly = false)
    @Override
    public void changePassword(String userId, String oldPwd, String newPwd) {
        UserEntity user = selectOneById(userId);
        if (!encryManager.encry(user.getUserName(), oldPwd, user.getUserName()).equals(user.getPassword())) {
            throw new FrameWorkException(Constants.CODE_UNCORRENT_CREDENTIALS, "原始密码输入错误。", null, false);
        }
        Map<String, Object> condition = new HashMap<String, Object>();
        condition.put("id", user.getId());
        condition.put("password", encryManager.encry(user.getUserName(), newPwd, user.getUserName()));
        updateField(condition);
    }
}