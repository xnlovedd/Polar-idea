package polar.island.core.logger;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 日志记录器，只记录日志
 * 
 * @author PolarLoves
 *
 */
public class LocalLogger implements LoggerService {
	private final Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public void writeLog(String message, Exception error, LoggerLevel level, String interfaceName, String currentUser) {
		switch (level) {
		case DEBUG:
			logger.debug(message, error);
			break;
		case INFO:
			logger.info(message, error);
			break;
		case WARN:
			logger.warn(message, error);
			break;
		case ERROR:
			logger.warn(message, error);
			break;
		default:
			break;
		}
	}

}
