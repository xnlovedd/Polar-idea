package polar.island.inlay.logs.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import polar.island.core.logger.LogRecordsService;
import polar.island.inlay.records.dao.RecordsDao;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
@Service(value = "logRecordsService")
public class LogRecordsServiceImpl implements LogRecordsService{
	@Resource(name = "recordsDao")
	private RecordsDao recordsDao;
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Override
	public void writeRecords(String pageName, String url, Integer platform, Date now, String userId, String ip) {
		if (url.startsWith("/records")) {
			return;
		}
		Map<String, Object> condition = new HashMap<String,Object>();
		condition.put("pageName", pageName);
		condition.put("vistUrl", url);
		condition.put("vistDate", now);
		condition.put("vistPlatform", platform);
		condition.put("vistPeople", userId);
		condition.put("vistIp", ip);
		final Map<String, Object> condition2 = condition;
		new Thread() {
			public void run() {
				try {
					recordsDao.insert(condition2);
				} catch (Exception e) {
					logger.error("新增访问记录失败,错误信息:{}", e);
				}
			};
		}.start();
	}
}
