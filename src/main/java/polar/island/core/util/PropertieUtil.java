package polar.island.core.util;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

/**
 * 读取配置文件的工具类，用来读取配置文件.
 *
 * @author PolarLoves
 */
public class PropertieUtil {
    private static final Logger logger = LoggerFactory.getLogger(PropertieUtil.class);
    private static Map<String, String> settingData = new HashMap<String, String>();
    private static Map<String, String> msgData = new HashMap<String, String>();
    private static Map<String, String> mappingData = new HashMap<String, String>();
    private static final String PATH_SETTING = "config/settings.properties";
    private static final String PATH_MSG = "config/msg.properties";
    private static final String PATH_MAPPING = "config/mapping.properties";
    private static final String MSG_PREFIX = "MSG_";
    private static final String MAPPING_PREFIX = "MP_";

    private static void readProperties(Properties properties, Map<String, String> to) {
        Iterator<Map.Entry<Object, Object>> it = properties.entrySet().iterator();
        it = properties.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<Object, Object> entry = it.next();
            Object key = entry.getKey();
            Object value = entry.getValue();
            to.put(key.toString(), value.toString());
        }
    }

    static {
        logger.debug("start load properties to memory------------>");
        InputStream is = null;
        ResourceLoader resourceLoader = new DefaultResourceLoader();
        try {
            logger.debug("load setting properties from:{}", PATH_SETTING);
            Resource resource = resourceLoader.getResource(PATH_SETTING);
            is = resource.getInputStream();
            Properties properties = new Properties();
            properties.load(is);
            readProperties(properties, settingData);
            properties.clear();
            logger.debug("load setting properties success,close InputStream");
            IOUtils.closeQuietly(is);
            logger.debug("load msg properties from:{}", PATH_MSG);
            resource = resourceLoader.getResource(PATH_MSG);
            is = resource.getInputStream();
            properties.load(is);
            readProperties(properties, msgData);
            properties.clear();
            logger.debug("load msg properties success,close InputStream");
            IOUtils.closeQuietly(is);
            logger.debug("load mapping properties from:{}", PATH_MAPPING);
            resource = resourceLoader.getResource(PATH_MAPPING);
            is = resource.getInputStream();
            properties.load(is);
            readProperties(properties, mappingData);
            properties.clear();
            logger.debug("load mapping properties success,the InputStream will close in finally block.");

        } catch (IOException ex) {
            logger.error("can not read properties config,error:{}", ex);
        } finally {
            IOUtils.closeQuietly(is);
            logger.debug("close InputStream in finally block", PATH_MAPPING);
        }
        logger.debug("load properties success<------------");
    }

    private PropertieUtil() {

    }

    /**
     * 依据key获取配置属性
     *
     * @param key 设置的key
     * @return 配置属性
     */
    public static String getSetting(String key) {
        String value = settingData.get(key);
        if (value == null) {
            logger.error("setting config file not set for :{}" + key);
        }
        return value;
    }

    /**
     * 依据代码获取错误信息文本。
     *
     * @param key 错误代码
     * @return 错误信息文本
     */
    public static String getMsg(String key) {
        String value = msgData.get(MSG_PREFIX + key);
        //获取不到文本，使用默认的错误信息
        if (value == null) {
            return msgData.get("DEFAULT");
        }
        return value;
    }
    public static String getDefaultMsg() {
        return msgData.get("DEFAULT");
    }
    public static String getDefaultMapping() {
        return mappingData.get("DEFAULT");
    }
    public  static  void main(String args[]){
        getSetting("LOAD_CHANNEL");
    }
    /**
     * 依据代码获取网页路径。
     *
     * @param key 错误代码
     * @return 网页路径
     */
    public static String getMapping(String key) {
        String value = mappingData.get(MAPPING_PREFIX + key);
        //获取不到文本，使用默认的数据
        if (value == null) {
            return mappingData.get("DEFAULT");
        }
        return value;
    }
}
