package polar.island.core.exception;

import polar.island.core.config.Constants;

/**
 * 数据校验异常
 * 
 * @author PolarLoves
 *
 */
public class ValidationException extends FrameWorkException {

	private static final long serialVersionUID = 6517151881688572443L;

	public ValidationException(String message, Exception causeMessage) {
		super(Constants.CODE_VALIDATION, message, causeMessage,false);
	}

}
