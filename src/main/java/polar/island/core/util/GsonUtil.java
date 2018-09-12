package polar.island.core.util;

import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import polar.island.core.exception.JSONConvertException;
import polar.island.core.json.GsonIgnore;

/**
 * 转换Json的工具类。
 * 
 * @author PolarLoves
 *
 */
public class GsonUtil {
	private static Logger logger = LoggerFactory.getLogger(GsonUtil.class);
	//空值也需要序列化。
	public final static Gson gson = new GsonBuilder().setExclusionStrategies(new IgnoreExclusionStrategy()).serializeNulls()
			.setDateFormat("yyyy-MM-dd HH:mm:ss").create();
	private GsonUtil() {

	}

	public static Gson getGson() {
		return gson;
	}

	public static <T> T jsonToObject(String source, Class<T> t) {
		T result;
		try {
			result = (T) gson.fromJson(source, t);
		} catch (Exception e) {
			logger.error("JSON处理异常", e);
			throw new JSONConvertException("JSON反失败,待转换数据：" + source, e);
		}
		return result;
	}

	private static class IgnoreExclusionStrategy implements ExclusionStrategy {
		public boolean shouldSkipClass(Class<?> clazz) {
			return clazz.getAnnotation(GsonIgnore.class) != null;
		}

		public boolean shouldSkipField(FieldAttributes f) {
			return f.getAnnotation(GsonIgnore.class) != null;
		}
	}

	public static String toJson(Object source) {

		String result;
		try {
			result = gson.toJson(source);
		} catch (Exception e) {
			logger.error("JSON处理异常", e);
			throw new JSONConvertException("JSON转换失败,待转换数据：" + source, e);
		}
		return result;
	}

}
