package polar.island.core.exception;

import polar.island.core.config.Constants;

public class DataNotExistException extends FrameWorkException {

	private static final long serialVersionUID = 6517151881688572443L;

	public DataNotExistException(String message, Exception causeMessage) {
		super(Constants.CODE_DATA_NOT_EXIST, message, causeMessage,false);
	}

}
