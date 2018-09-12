package polar.island.inlay.records.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import polar.island.core.service.BasicServiceImpl;
import polar.island.inlay.records.dao.RecordsDao;
import polar.island.inlay.records.entity.RecordsEntity;

import javax.annotation.Resource;
import java.util.Map;

@Transactional(readOnly = true)
@Service(value = "recordsService")
public class RecordsServiceImpl extends BasicServiceImpl<RecordsEntity,RecordsEntity,RecordsDao> implements RecordsService {
	@Resource(name = "recordsDao")
	private RecordsDao recordsDao;
	
	@Override
	public RecordsDao getDao() {
		return recordsDao;
	}
	@Transactional(readOnly = false)
	@Override
	public Object insert(Map<String, Object> condition) {
		recordsDao.insert(condition);
		return condition.get("id");
	}
}