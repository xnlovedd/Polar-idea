package polar.island.core.exception;

import polar.island.core.config.Constants;

/**
 * JSON转换异常
 * 
 * @author PolarLoves
 *
 */
public class JSONConvertException extends FrameWorkException {

	private static final long serialVersionUID = -1729854283087758401L;

	public JSONConvertException(String message, Exception causeMessage) {
		super(Constants.CODE_SERVER_COMMON, message, causeMessage);
	}
}
