package polar.island.core.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.UUID;

public class CommonUtil {
    public static final Logger logger = LoggerFactory.getLogger(CommonUtil.class);

    private CommonUtil() {
    }

    /**
     * 转换String 为long,如果报错，则返回-1
     *
     * @param data 需要转换的数据
     * @return 转换完成的数据
     */
    public static long str2Long(String data) {
        try {
            return Long.parseLong(data);
        } catch (Exception e) {
            logger.error("字符串转换long错误,error:{}", e);
            return -1L;
        }
    }

    /**
     * 转换String 为double,如果报错，则返回-1
     *
     * @param data 需要转换的数据
     * @return 转换完成的数据
     */
    public static double str2Double(String data) {
        try {
            return Double.parseDouble(data);
        } catch (Exception e) {
            logger.error("字符串转换double错误,error:{}", e);
            return -1d;
        }
    }

    /**
     * 转换String 为float,如果报错，则返回-1
     *
     * @param data 需要转换的数据
     * @return 转换完成的数据
     */
    public static double str2Float(String data) {
        try {
            return Float.parseFloat(data);
        } catch (Exception e) {
            logger.error("字符串转换float错误,error:{}", e);
            return -1d;
        }
    }

    /**
     * 获取一个随机的32位编号
     *
     * @return 随机编号
     */
    public static String randomId() {
        try {
            return UUID.randomUUID().toString().replace("-", "");
        } catch (Exception e) {
            logger.error("获取随机id失败,error:{}", e);
            return null;
        }
    }

    /**
     * 转换String 为int,如果报错，则返回-1
     *
     * @param data 需要转换的数据
     * @return 转换完成的数据
     */
    public static int str2Int(String data) {
        try {
            return Integer.parseInt(data);
        } catch (Exception e) {
            logger.error("字符串转换int错误,error:{}", e);
            return -1;
        }
    }
    public static String valueOf(Object data){
        return data==null?null:String.valueOf(data);
    }
}
