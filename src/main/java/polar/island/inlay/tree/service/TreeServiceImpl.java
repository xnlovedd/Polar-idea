package polar.island.inlay.tree.service;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import polar.island.core.entity.DictEntity;
import polar.island.core.service.BasicServiceImpl;
import polar.island.inlay.tree.dao.TreeDao;
import polar.island.inlay.tree.entity.TreeEntity;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Transactional(readOnly = true)
@Service(value = "treeService")
public class TreeServiceImpl extends BasicServiceImpl<TreeEntity,TreeEntity,TreeDao> implements TreeService {
	@Resource(name = "treeDao")
	private TreeDao treeDao;
	
	@Override
	public TreeDao getDao() {
		return treeDao;
	}
	@CacheEvict(value="treeCache",key="#condition.get('groupId')")
	@Transactional(readOnly = false)
	@Override
	public Object insert(Map<String, Object> condition) {
		treeDao.insert(condition);
		return condition.get("id");
	}
	@CacheEvict(value="treeCache",key="#condition.get('groupId')")
	@Override
	public Long updateAll(Map<String, Object> condition) {
		return super.updateAll(condition);
	}
	@CacheEvict(value="treeCache",allEntries=true)
	@Override
	public Long deleteByIdPhysical(String id) {
		return super.deleteByIdPhysical(id);
	}
	@CacheEvict(value="treeCache",allEntries=true)
	@Override
	public Long updateField(Map<String, Object> condition) {
		return super.updateField(condition);
	}
	@CacheEvict(value="treeCache",allEntries=true)
	@Override
	public Long deleteMulitByIdPhysical(String[] ids) {
		return super.deleteMulitByIdPhysical(ids);
	}
	@Override
	public List<DictEntity> allGroups() {
		return treeDao.allGroups();
	}
	@Cacheable(value="treeCache",key="#groupId")
	@Override
	public List<TreeEntity> getTree(String groupId) {
		return treeDao.getTree(groupId);
	}
}