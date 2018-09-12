package polar.island.core.exception;

import polar.island.core.config.Constants;

public class FileTooLargeException extends FrameWorkException {

	private static final long serialVersionUID = 7680574866311619137L;

	public FileTooLargeException(String message, Exception causeMessage) {
		super(Constants.CODE_FILE_TOOLARGE, message, causeMessage, false);
	}

}
