package polar.island.core.exception;

import polar.island.core.config.Constants;

public class NotLoginException extends FrameWorkException {
	private static final long serialVersionUID = 5882883778754486270L;

	public NotLoginException(String message, Exception causeMessage) {
		super(Constants.CODE_NO_USER, message, causeMessage, false);
	}

}
