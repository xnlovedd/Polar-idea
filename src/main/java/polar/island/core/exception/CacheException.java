package polar.island.core.exception;

import polar.island.core.config.Constants;

public class CacheException extends FrameWorkException {
	private static final long serialVersionUID = -6151566786524457270L;

	public CacheException(String message, Exception causeMessage) {
		super(Constants.CODE_CACHE, message, causeMessage);
	}


}
