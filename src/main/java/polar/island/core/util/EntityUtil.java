package polar.island.core.util;

import org.apache.commons.beanutils.PropertyUtilsBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import polar.island.core.entity.BasicEntity;
import polar.island.core.exception.BeanConvertException;
import polar.island.core.exception.ValidationException;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

public class EntityUtil {
	// 日志记录器
	public static final Logger logger = LoggerFactory.getLogger(EntityUtil.class);

	private EntityUtil() {

	}

	/**
	 * 将JAVABEAN转为MAP类型。
	 * 
	 * @param obj
	 *            待转的对象
	 * @return 转换后的Map类型
	 */
	public static Map<String, Object> beanToMap(Object obj) {
		try {
			if (obj == null) {
				return new HashMap<String, Object>();
			}
			Map<String, Object> params = new HashMap<String, Object>(0);

			PropertyUtilsBean propertyUtilsBean = new PropertyUtilsBean();
			PropertyDescriptor[] descriptors = propertyUtilsBean.getPropertyDescriptors(obj);
			for (int i = 0; i < descriptors.length; i++) {
				String name = descriptors[i].getName();
				if (!"class".equals(name)) {
					Object value = propertyUtilsBean.getNestedProperty(obj, name);
					if (name.length() > 1 && Character.isUpperCase(name.charAt(1))) {
						// 如果第一个字母大于1，则将其小写处理，符合规范
						char[] ac = name.toCharArray();
						ac[0] = Character.toLowerCase(ac[0]);
						name = new String(ac);
					}
					params.put(name, value);
				}
			}
			return params;
		} catch (Exception e) {
			logger.error("[数据类型转换失败]", e);
			throw new BeanConvertException("数据类型转换失败", e);
		}
	}

	/**
	 * 将对象转换为更新单个字段专用的map
	 * 
	 * @param obj
	 *            对象
	 * @return 更新单个字段专用的map
	 */
	public static Map<String, Object> beanToSingleField(BasicEntity obj) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			if (obj == null) {
				throw new ValidationException("更新字段名称不能为空", null);
			}
			String field = obj.getFieldName();
			if (field == null || field.trim().length() == 0) {
				throw new ValidationException("更新字段名称不能为空", null);
			}
			Object value = null;
			Method method = obj.getClass().getDeclaredMethod(
					"get" + field.substring(0, 1).toUpperCase() + field.substring(1, field.length()));
			value = method.invoke(obj);
			map.put(field, value);
			return map;
		} catch (ValidationException e) {
			throw e;
		} catch (NoSuchMethodException e) {
			throw new ValidationException("不支持的更新字段", e);
		} catch (Exception e) {
			logger.error("[转换更新字段及类型失败]", e);
			throw new BeanConvertException("转换更新字段及类型失败", e);
		}
	}
}
