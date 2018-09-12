package polar.island.inlay.menu.service;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import polar.island.core.entity.TreeEntity;
import polar.island.core.service.BasicServiceImpl;
import polar.island.inlay.menu.dao.MenuDao;
import polar.island.inlay.menu.entity.MenuEntity;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Transactional(readOnly = true)
@Service(value = "menuService")
public class MenuServiceImpl extends BasicServiceImpl<MenuEntity, MenuEntity, MenuDao> implements MenuService {
    @Resource(name = "menuDao")
    private MenuDao menuDao;

    @Override
    public MenuDao getDao() {
        return menuDao;
    }

    @Transactional(readOnly = false)
    @Override
    public Object insert(Map<String, Object> condition) {
        menuDao.insert(condition);
        return condition.get("id");
    }

    @Override
    public List<TreeEntity> allMenus() {
        return menuDao.allMenus();
    }

    @Override
    public List<MenuEntity> modelMenus(String menuModelId) {
        return menuDao.modelMenus(menuModelId);
    }

    @Override
    public Long deleteByIdPhysical(String id) {
        return deleteMenu(id, menuDao.allMenus(), 0l);
    }

    private Long deleteMenu(String id, List<TreeEntity> all, Long count) {
        count = count + menuDao.deleteByIdPhysical(id);
        menuDao.deleteModelMenuByMenuId(id);
        if (all != null && all.size() > 0) {
            for (TreeEntity entity : all) {
                if (id.equals(entity.getParentId() + "")) {
                    count = deleteMenu(entity.getId(), all, count);
                }
            }
        }

        return count;
    }

    @Transactional(readOnly = false)
    @Override
    public void updateModelMenus(String modelId, String[] menuId) {
        menuDao.deleteModelMenuByModelId(modelId);
        if (menuId != null && menuId.length > 0) {
            for (String id : menuId) {
                Map<String, Object> condition = new HashMap<String, Object>();
                condition.put("menuModelId", modelId);
                condition.put("menuId", id);
                menuDao.insertModelMenu(condition);
            }
        }
    }

    @Override
    public Long maxOrderNum() {
        return menuDao.maxOrderNum();
    }

    @Cacheable(value = "menuCache", key = "#userId")
    @Override
    public List<MenuEntity> userMenus(String userId) {
        List<MenuEntity> result = menuDao.userMenus(userId);
        if (result == null || result.size() == 0) {
            // 使用默认菜单
            result = menuDao.defaultMenus();
        }
        List<MenuEntity> temp = new ArrayList<MenuEntity>();
        if (result != null && result.size() > 0) {
            for (MenuEntity entity : result) {
                if (entity.getParentId() == null) {
                    temp.add(entity);
                }
            }
        }
        result.removeAll(temp);
        for (MenuEntity entity : temp) {
            addClidren(entity, result);
        }
        return temp;
    }

    private void addClidren(MenuEntity current, List<MenuEntity> datas) {
        Long parentId = current.getId();
        if (current.getChildren() == null) {
            current.setChildren(new ArrayList<MenuEntity>());
        }
        for (MenuEntity data : datas) {
            if (parentId.equals(data.getParentId())) {
                current.getChildren().add(data);
            }
        }
        //移除不需要的集合，提高效率
        datas.removeAll(current.getChildren());
        for (MenuEntity data : current.getChildren()) {
            addClidren(data, datas);
        }
    }

    @CacheEvict(value = "menuCache", key = "#userId")
    @Override
    public void clearUserMenusCache(String userId) {

    }

    @CacheEvict(value = "menuCache", allEntries = true)
    @Override
    public void clearAllMenusCache() {

    }
}