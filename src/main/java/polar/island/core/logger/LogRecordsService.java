package polar.island.core.logger;

import java.util.Date;

public interface LogRecordsService {
	/**
	 * 存入访问日志
	 * 
	 * @param pageName
	 *            页面名称
	 * @param url
	 *            访问路径
	 * @param platform
	 *            访问平台
	 * @param now
	 *            现在的时间
	 * @param userId
	 *            用户编号
	 * @param ip
	 *            访问IP
	 */
	public void writeRecords(String pageName, String url, Integer platform, Date now, String userId, String ip);
}
