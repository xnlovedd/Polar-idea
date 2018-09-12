package polar.island.core.exception;



/**
 * 框架异常，基础异常。
 *
 * @author PolarLoves
 */
public class FrameWorkException extends RuntimeException {
    private static final long serialVersionUID = -2706346606153075352L;
    private String code;
    private String frameWorkMessage;
    // 是否需要记录日志
    private boolean log = true;

    public boolean isLog() {
        return log;
    }

    public void setLog(boolean log) {
        this.log = log;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }


    public String getFrameWorkMessage() {
		return frameWorkMessage;
	}

	public void setFrameWorkMessage(String frameWorkMessage) {
		this.frameWorkMessage = frameWorkMessage;
	}

	public FrameWorkException(String code, String message, Exception causeMessage) {
        super(causeMessage);
        this.code = code;
        this.frameWorkMessage = message;
    }

    public FrameWorkException(String code, String message, Exception causeMessage, boolean log) {
        super();
        this.code = code;
        this.frameWorkMessage = message;
        this.log = log;
    }
}
