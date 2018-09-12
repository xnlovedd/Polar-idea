package polar.island.core.config;

/**
 * 配置文件
 *
 * @author PolarLoves
 */
public class Constants {
	private Constants() {
	}
	public static final  String FORCE_DOWNLINE_MSG = "forceDownLineMsg";
	public static final  String FORCE_DOWNLINE_FLAG = "forceDownLine";
	public static final String REG_PHONE=  "^1\\d{10}$"; //手机号的正则表达式
	public static final String REG_EMAIL="(^$)|^([a-zA-Z0-9_\\.\\-])+\\@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$"; //邮箱的正则表达式
	public static final String REG_IDCARD="(^$)|(^\\d{15}$)|(^\\d{17}(x|X|\\d)$)"; //身份证号的正则表达式

	// 数据校验异常
	public static final String CODE_VALIDATION = "000001";
	// 实体转换异常
	public static final String CODE_BEAN_CONVERT = "000002";
	// JSON转换异常
	public static final String CODE_JSON_CONVERT = "000003";
	// 服务器内部异常
	public static final String CODE_SERVER_COMMON = "000004";
	// 太多结果集
	public static final String CODE_MULTI_RESULT = "000005";
	// 数据不存在
	public static final String CODE_DATA_NOT_EXIST = "000006";
	// 一般的异常
	public static final String CODE_COMMON = "000007";
	// 用户未登录异常
	public static final String CODE_NO_USER = "000008";
	// 无权限异常
	public static final String CODE_NO_AUTH = "000009";
	// 强制下线
	public static final String CODE_FORCE_DOWNLINE = "000010";
	// 服务器未知异常
	public static final String CODE_SERVER_ERROR = "999999";
	// 成功的编码
	public static final String CODE_SUCCESS = "000000";
	// 缓存异常
	public static final String CODE_CACHE = "900000";
	// 密码不正确
	public static final String CODE_UNCORRENT_CREDENTIALS = "010000";
	// 用户不存在
	public static final String CODE_UNKNOW_USER = "010001";
	// 用户已被锁定
	public static final String CODE_LOCKED_USER = "010002";
	// 用户已被删除
	public static final String CODE_DELETE_USER = "010003";

	// 导出异常
	public static final String CODE_EXCELL_EXPORT = "020000";
	// 导入异常
	public static final String CODE_EXCELL_IMPORT = "020001";
	// 文件过大
	public static final String CODE_FILE_TOOLARGE = "030000";
	// 文件上传失败
	public static final String CODE_FILE = "030001";


}
