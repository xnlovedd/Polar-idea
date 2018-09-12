package polar.island.inlay.logs.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import polar.island.core.logger.LoggerLevel;
import polar.island.core.logger.LoggerService;
import polar.island.core.util.ExceptionUtil;
import polar.island.inlay.logs.dao.LogsDao;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service(value = "loggerService")
public class LoggerServiceImpl implements LoggerService {
	@Resource(name = "logsDao")
	private LogsDao logsDao;
	private final Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public void writeLog(String message, Exception error, LoggerLevel level, String interfaceName, String currentUser) {
		try {
			Map<String, Object> condition = new HashMap<String,Object>();
			Date date = new Date();
			condition.put("createTime", date);
			condition.put("createTimeMillions", date.getTime());
			condition.put("message", message);
			condition.put("caseBy", ExceptionUtil.getExceptionAllinformation(error));
			condition.put("interfaceName", interfaceName);
			condition.put("userId", currentUser);
			logsDao.insert(condition);
		} catch (Exception e) {
			logger.error(message, error);
		}
	}
}
