package polar.island.inlay.menuModel.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import polar.island.core.service.BasicServiceImpl;
import polar.island.inlay.menu.dao.MenuDao;
import polar.island.inlay.menuModel.dao.MenuModelDao;
import polar.island.inlay.menuModel.entity.MenuModelEntity;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Transactional(readOnly = true)
@Service(value = "menuModelService")
public class MenuModelServiceImpl extends BasicServiceImpl<MenuModelEntity,MenuModelEntity,MenuModelDao> implements MenuModelService {
	@Resource(name = "menuModelDao")
	private MenuModelDao menuModelDao;
	@Resource(name = "menuDao")
	private MenuDao menuDao;
	@Override
	public MenuModelDao getDao() {
		return menuModelDao;
	}
	@Transactional(readOnly = false)
	@Override
	public Object insert(Map<String, Object> condition) {
		menuModelDao.insert(condition);
		return condition.get("id");
	}
	@Transactional(readOnly = false)
	@Override
	public void setDefault(String id) {
		menuModelDao.cleanDefault();
		Map<String, Object> condition=new HashMap<String,Object>();
		condition.put("id", id);
		condition.put("defaultMenu", 1);
		menuModelDao.updateField(condition);
	}
	@Transactional(readOnly = false)
	public Long deleteByIdLogic(String id) {
		//删除用户-菜单
		menuModelDao.deleteUserMenuByMenuModelId(id);
		//删除模板-菜单
		menuDao.deleteModelMenuByModelId(id);
		return super.deleteByIdLogic(id);
	}
	@Override
	public List<MenuModelEntity> userMenuModels(String userId) {
		return menuModelDao.userMenuModels(userId);
	}
	@Transactional(readOnly = false)
	@Override
	public void updateUserMenuModels(String userId, String menuModelId) {
		menuModelDao.deleteUserMenuByUserId(userId);
		if (menuModelId != null && !menuModelId.equals("")) {
			Map<String, Object> condition = new HashMap<String,Object>();
			condition.put("userId", userId);
			condition.put("menuModelId", menuModelId);
			menuModelDao.insertUserMenu(condition);
		}
	}
}