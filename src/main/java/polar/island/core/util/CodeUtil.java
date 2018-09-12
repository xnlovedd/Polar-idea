package polar.island.core.util;

import java.util.HashMap;
import java.util.Map;

public class CodeUtil {
    // 存储返回码的键名
    private static final String CODE = "code";
    // 存储返回数据的键名
    private static final String DATA = "data";
    // 存储返回消息的键名
    private static final String MSG = "msg";
    // 储存总条目的键名
    private static final String COUNT = "count";


    private CodeUtil() {

    }

    /**
     * 将数据转换成JSON串。
     *
     * @param code  编码。
     * @param msg   消息，如果传入为空，会根据编码从Local文件自动读取。
     * @param data  返回数据
     * @param count 数据条目
     * @return 生成的Json串
     */
    public static String generateDataStr(String code, Object data, String msg, Long count) {
        if (msg == null) {
            msg = PropertieUtil.getMsg(code);
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put(CODE, code);
        map.put(DATA, data);
        map.put(MSG, msg);
        map.put(COUNT, count);
        return GsonUtil.toJson(map);
    }

    /**
     * 将数据转换成JSON串。
     *
     * @param code 编码。
     * @return 生成的JSON串
     */
    public static String generateDataStr(String code) {
        return generateDataStr(code, null, null, null);
    }

    /**
     * 将数据转换成JSON串。
     *
     * @param code 编码。
     * @param msg  消息，如果传入为空，会根据编码从Local文件自动读取。
     * @param data 返回数据
     * @return 生成的JSON串
     */
    public static String generateDataStr(String code, Object data, String msg) {
        return generateDataStr(code, data, msg, null);
    }

    /**
     * 将数据转换成JSON串。
     *
     * @param code 编码。
     * @param data 返回数据
     * @return 生成的JSON串
     */
    public static String generateDataStr(String code, Object data) {
        return generateDataStr(code, data, null, null);
    }
}
