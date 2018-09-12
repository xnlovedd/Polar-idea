package polar.island.inlay.logs.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import polar.island.core.service.BasicServiceImpl;
import polar.island.inlay.logs.dao.LogsDao;
import polar.island.inlay.logs.entity.LogsEntity;

import javax.annotation.Resource;
import java.util.Date;
import java.util.Map;

@Transactional(readOnly = true)
@Service(value = "logsService")
public class LogsServiceImpl extends BasicServiceImpl<LogsEntity,LogsEntity,LogsDao> implements LogsService {
	@Resource(name = "logsDao")
	private LogsDao logsDao;
	
	@Override
	public LogsDao getDao() {
		return logsDao;
	}
	@Transactional(readOnly = false)
	@Override
	public Object insert(Map<String, Object> condition) {
		Date date=new Date();
		condition.put("createTime", date);
		condition.put("createTimeMillions", date.getTime());
		logsDao.insert(condition);
		return condition.get("id");
	}
}