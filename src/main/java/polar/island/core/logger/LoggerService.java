package polar.island.core.logger;


public interface LoggerService {
	/**
	 * 写入日志
	 * 
	 * @param message
	 *            信息
	 * @param error
	 *            错误信息
	 * @param level
	 *            错误级别
	 * @param interfaceName
	 *            接口名称
	 * @param currentUser
	 *            当前用户
	 */
	public void writeLog( String message, Exception error, LoggerLevel level, String interfaceName,
			String currentUser);

	
}
