package polar.island.inlay.dict.service;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import polar.island.core.service.BasicServiceImpl;
import polar.island.inlay.dict.dao.DictDao;
import polar.island.inlay.dict.entity.DictEntity;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Transactional(readOnly = true)
@Service(value = "dictService")
public class DictServiceImpl extends BasicServiceImpl<DictEntity, DictEntity, DictDao> implements DictService {
	@Resource(name = "dictDao")
	private DictDao dictDao;
	@Override
	public DictDao getDao() {
		return dictDao;
	}
	
	@Transactional(readOnly = false)
	@Override
	public Object insert(Map<String, Object> condition) {
		dictDao.insert(condition);
		return condition.get("id");
	}
	@CacheEvict(value="dictCache",key="#condition.get('groupId')")
	@Override
	public Long updateAll(Map<String, Object> condition) {
		return super.updateAll(condition);
	}
	@CacheEvict(value="dictCache",allEntries=true)
	@Override
	public Long deleteByIdPhysical(String id) {
		return super.deleteByIdPhysical(id);
	}
	@CacheEvict(value="dictCache",allEntries=true)
	@Override
	public Long updateField(Map<String, Object> condition) {
		return super.updateField(condition);
	}
	@CacheEvict(value="dictCache",allEntries=true)
	@Override
	public Long deleteMulitByIdPhysical(String[] ids) {
		return super.deleteMulitByIdPhysical(ids);
	}
	@Override
	public List<polar.island.core.entity.DictEntity> allGroups() {
		return dictDao.allGroups();
	}
	@Cacheable(value="dictCache",key="#id")
	@Override
	public List<polar.island.core.entity.DictEntity> findDictById(String id) {
		return dictDao.findDictById(id);
	}
}