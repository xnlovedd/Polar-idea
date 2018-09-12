package polar.island.web.handler;

import eu.bitwalker.useragentutils.DeviceType;
import eu.bitwalker.useragentutils.OperatingSystem;
import eu.bitwalker.useragentutils.UserAgent;
import org.apache.commons.io.IOUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.UnauthenticatedException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter;
import polar.island.core.config.Constants;
import polar.island.core.err.ErrorMsg;
import polar.island.core.err.ErrorType;
import polar.island.core.exception.FileTooLargeException;
import polar.island.core.exception.FrameWorkException;
import polar.island.core.exception.NoPermissionException;
import polar.island.core.exception.NotLoginException;
import polar.island.core.logger.LocalLogger;
import polar.island.core.logger.LogRecordsService;
import polar.island.core.logger.LoggerLevel;
import polar.island.core.logger.LoggerService;
import polar.island.core.util.CodeUtil;
import polar.island.core.util.PropertieUtil;
import polar.island.core.util.RequestUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

public class JsonWebHandlerAdapter extends RequestMappingHandlerAdapter {
	private String MSG_DEFAULT = PropertieUtil.getDefaultMsg();
	private String MAPPING_DEFAULT = PropertieUtil.getDefaultMapping();
	private LoggerService logger = new LocalLogger();
	@Autowired(required = false)
	private LogRecordsService logRecordsService;
	private List<String> logInUrls;
	private String exceptionName = "exception";
	private String forceDownLineName = Constants.FORCE_DOWNLINE_MSG;
	private String forceDownLineFlag = Constants.FORCE_DOWNLINE_FLAG;

	@Override
	protected ModelAndView handleInternal(HttpServletRequest request, HttpServletResponse response,
										  HandlerMethod handlerMethod) throws Exception {
		if (handlerMethod != null) {
			writeRecords(request, handlerMethod);
			Exception ex = (Exception) getRequstAttribute(exceptionName, request);
			if (ex != null) {
				return resolveException(request, response, handlerMethod, ex);
			}
			boolean matches = false;
			if (logInUrls != null && !logInUrls.isEmpty()) {
				String requestUri = request.getServletPath();
				for (String url : logInUrls) {
					if (url.equals(requestUri)) {
						matches = true;
						break;
					}
				}
			}
			if (!matches) {
				Subject subject = SecurityUtils.getSubject();
				if (subject.isAuthenticated()) {
					Session session = subject.getSession();
					Boolean flag = (Boolean) getSessionAttribute(forceDownLineFlag, session);
					if (flag != null && flag) {
						String errorMsg = (String) getSessionAttribute(forceDownLineName, session);
						request.setAttribute(exceptionName,
								new FrameWorkException(Constants.CODE_FORCE_DOWNLINE, errorMsg, null, false));
						// 用户已经被强制下线
						subject.logout();
						return resolveException(request, response, handlerMethod,
								new FrameWorkException(Constants.CODE_FORCE_DOWNLINE, errorMsg, null, false));
					}
				}
			}
		}

		try {
			return super.handleInternal(request, response, handlerMethod);
		} catch (UnauthenticatedException e) {
			// 用户未认证
			return resolveException(request, response, handlerMethod, new NotLoginException(null, e));
		} catch (org.apache.shiro.authz.AuthorizationException e) {
			// 无权限访问此页面
			return resolveException(request, response, handlerMethod, new NoPermissionException(null, e));
		} catch (org.apache.shiro.authc.AuthenticationException e) {
			if (e.getCause() != null && e.getCause() instanceof FrameWorkException) {
				return resolveException(request, response, handlerMethod, (FrameWorkException) (e.getCause()));
			} else {
				return resolveException(request, response, handlerMethod, e);
			}
		} catch (org.springframework.web.multipart.MaxUploadSizeExceededException e) {
			// 文件过大
			return resolveException(request, response, handlerMethod, new FileTooLargeException(null, e));
		} catch (Exception e) {
			e.printStackTrace();
			return resolveException(request, response, handlerMethod, e);
		}
	}

	private Object getRequstAttribute(String name, HttpServletRequest request) {
		return request.getAttribute(name);
	}

	private Object getSessionAttribute(String name, Session session) {
		return session.getAttribute(name);
	}



	private void writeRecords(HttpServletRequest request, HandlerMethod handlerMethod) {
		if (logRecordsService != null) {
			String pageName = null;
			final String url = request.getRequestURI();
			Integer platform = null;
			final Date now = new Date();
			final String userId = getUserId();
			final String ip = RequestUtil.getIpAddr(request);
			ErrorMsg err = handlerMethod.getMethodAnnotation(ErrorMsg.class);
			if (err != null && err.tag() != null) {
				pageName = err.tag();
				if (!err.writeLogs()) {
					return;
				}
			} else {
				return;
			}
			UserAgent useragent = new UserAgent(request.getHeader("user-agent"));
			OperatingSystem sys = useragent.getOperatingSystem();
			DeviceType deviceType = sys.getDeviceType();
			if (deviceType == DeviceType.MOBILE) {
				platform = 2;
			} else if (deviceType == DeviceType.COMPUTER) {
				platform = 1;
			} else {
				platform = -1;
			}
			final String finalPageName = pageName;
			final Integer finalPlatform = platform;
			new Thread() {
				@Override
				public void run() {
					logRecordsService.writeRecords(finalPageName, url, finalPlatform, now, userId, ip);
				}
			}.start();

		}

	}

	public String getUserName() {
		Object shiroPrincipal = SecurityUtils.getSubject().getPrincipal();
		if (shiroPrincipal != null) {
			String userName = null;
			try {
				Object user = shiroPrincipal.getClass().getDeclaredMethod("getUser").invoke(shiroPrincipal);
				userName = user.getClass().getDeclaredMethod("getUserName").invoke(user).toString();
			} catch (Exception e) {
				logger.writeLog("无法获取用户名称.", e, LoggerLevel.WARN, null, null);
			}
			return userName;
		}
		return null;
	}

	public String getUserId() {
		Object shiroPrincipal = SecurityUtils.getSubject().getPrincipal();
		if (shiroPrincipal != null) {
			String userName = null;
			try {
				Object user = shiroPrincipal.getClass().getDeclaredMethod("getUser").invoke(shiroPrincipal);
				userName = user.getClass().getDeclaredMethod("getId").invoke(user).toString();
			} catch (Exception e) {
				logger.writeLog("无法获取用户编号.", e, LoggerLevel.WARN, null, null);
			}
			return userName;
		}
		return null;
	}

	/**
	 * 处理异常信息。
	 *
	 * @param request       request对象
	 * @param response      response对象
	 * @param handlerMethod handlerMethod
	 * @param exception     处理异常
	 * @return 处理后定位的页面
	 */
	private ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response,
										  HandlerMethod handlerMethod, Exception exception) {
		ErrorMsg errorMsg = getAnnotation(handlerMethod);
		String userId = getUserName();
		writeLog(errorMsg, exception, request.getRequestURI(), userId);
		String code = getErrorCode(exception);
		String message = findErrorMessage(errorMsg, exception, code);
		ErrorType type = getType(errorMsg);
		if (type == ErrorType.WEB || (type == ErrorType.BOTH && !isMobile(request))) {
			String mapping = getMapper(errorMsg, code, request.getRequestURI(), userId);
			ModelAndView view = new ModelAndView(mapping);
			request.setAttribute("code", code);
			request.setAttribute("message", message);
			return view;
		} else {
			try {
				response.setCharacterEncoding("UTF-8");
				response.setContentType("application/json;charset=utf-8");
				response.getOutputStream().write(CodeUtil.generateDataStr(code, null, message).getBytes("UTF-8"));
				response.getOutputStream().flush();
			} catch (Exception ex) {
				// 写出异常时，不记录日志
				// logger.writeLog(TAG, "[写出异常]", ex, LoggerLevel.ERROR,
				// request.getRequestURI(), userId);
			} finally {
				try {
					IOUtils.closeQuietly(response.getOutputStream());
				} catch (Exception e) {
				}
			}
			return null;
		}
	}

	/**
	 * 判断请求是否为手机端。
	 *
	 * @param request request对象
	 * @return 是否为手机端
	 */
	private boolean isMobile(HttpServletRequest request) {
		UserAgent useragent = new UserAgent(request.getHeader("user-agent"));
		OperatingSystem sys = useragent.getOperatingSystem();
		DeviceType deviceType = sys.getDeviceType();
		if (deviceType == DeviceType.MOBILE) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 获取错误类型需要返回的数据格式，默认返回json串。
	 *
	 * @param errorMsg ErrorMsg标签
	 * @return 错误类型
	 * @see ErrorMsg
	 */
	private ErrorType getType(ErrorMsg errorMsg) {
		if (errorMsg == null) {
			return ErrorType.JSON;
		} else {
			return errorMsg.type();
		}
	}

	/**
	 * 获取注解标签
	 *
	 * @param handlerMethod handlerMethod
	 * @return ErrorMsg对象
	 */
	private ErrorMsg getAnnotation(HandlerMethod handlerMethod) {
		ErrorMsg errorMsg = handlerMethod.getMethodAnnotation(ErrorMsg.class);
		return errorMsg;
	}

	/**
	 * 根据代码获取错误信息。
	 *
	 * @param errorMsg 标签
	 * @param e        错误信息
	 * @param code     错误码
	 * @return 错误信息
	 */
	public String findErrorMessage(ErrorMsg errorMsg, Exception e, String code) {
		String message = null;
		if (errorMsg == null) {
			if (e instanceof FrameWorkException) {
				FrameWorkException ex = (FrameWorkException) e;
				message = ex.getFrameWorkMessage();
				PropertieUtil.getMsg(code);
				if (message == null) {
					message = PropertieUtil.getMsg(code);
				}
			} else {
				message = MSG_DEFAULT;
			}
		} else {
			if (errorMsg.overrideAll() && !errorMsg.msg().equals("")) {
				message = errorMsg.msg();
			} else {
				if (e instanceof FrameWorkException) {
					FrameWorkException ex = (FrameWorkException) e;
					message = ex.getFrameWorkMessage();
					if (message == null) {
						if (message == null) {
							message = PropertieUtil.getMsg(code);
						}
					}
					if (!message.equals(MSG_DEFAULT)) {
						if (!errorMsg.prefix().equals("")) {
							message = errorMsg.prefix() + "," + message;
						}
						if (!errorMsg.suffix().equals("")) {
							message = message + "," + errorMsg.suffix();
						}
					}
				} else {
					message = MSG_DEFAULT;
				}
			}

		}
		return message;
	}

	/**
	 * 获取错误码
	 *
	 * @param e 异常类型
	 * @return 错误码
	 */
	public String getErrorCode(Exception e) {
		String code = null;
		if (e instanceof FrameWorkException) {
			FrameWorkException ex = (FrameWorkException) e;
			code = ex.getCode();
			if (code == null) {
				code = Constants.CODE_SERVER_ERROR;
			}
		} else {
			return Constants.CODE_SERVER_ERROR;
		}
		return code;
	}

	/**
	 * 获取重定向路径
	 *
	 * @param errorMsg 注解
	 * @param code     错误码
	 * @param url      访问路径
	 * @param userId   用户编号
	 * @return 重定向路径
	 */
	public String getMapper(ErrorMsg errorMsg, String code, String url, String userId) {
		if (errorMsg != null && errorMsg.mapper().equals("")) {
			return PropertieUtil.getMapping(code);

		}
		return MAPPING_DEFAULT;
	}

	/**
	 * 写入日志
	 *
	 * @param errorMsg 注解
	 * @param e        错误信息
	 * @param url      访问路径
	 * @param userId   用户编号
	 */
	public void writeLog(final ErrorMsg errorMsg, final Exception e, final String url, final String userId) {
		if (e instanceof FrameWorkException) {
			FrameWorkException ex = (FrameWorkException) e;
			if (!ex.isLog()) {
				return;
			}
		}
		if (errorMsg == null || errorMsg.tag().equals("")) {
			new Thread() {
				@Override
				public void run() {
					logger.writeLog("未指定的标签", e, LoggerLevel.ERROR, url, userId);
				}
			}.start();

		} else {
			new Thread() {
				@Override
				public void run() {
					logger.writeLog(errorMsg.tag(), e, LoggerLevel.ERROR, url, userId);
				}
			}.start();
		}
	}

	public List<String> getLogInUrls() {
		return logInUrls;
	}

	public void setLogInUrls(List<String> logInUrls) {
		this.logInUrls = logInUrls;
	}

	public LoggerService getLogger() {
		return logger;
	}

	public void setLogger(LoggerService logger) {
		this.logger = logger;
	}


	public LogRecordsService getLogRecordsService() {
		return logRecordsService;
	}

	public void setLogRecordsService(LogRecordsService logRecordsService) {
		this.logRecordsService = logRecordsService;
	}

	public String getExceptionName() {
		return exceptionName;
	}

	public void setExceptionName(String exceptionName) {
		this.exceptionName = exceptionName;
	}

	public String getForceDownLineName() {
		return forceDownLineName;
	}

	public void setForceDownLineName(String forceDownLineName) {
		this.forceDownLineName = forceDownLineName;
	}

	public String getForceDownLineFlag() {
		return forceDownLineFlag;
	}

	public void setForceDownLineFlag(String forceDownLineFlag) {
		this.forceDownLineFlag = forceDownLineFlag;
	}

}
