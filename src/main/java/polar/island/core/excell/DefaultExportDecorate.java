package polar.island.core.excell;

import polar.island.core.util.CommonUtil;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 导出、导入表格的装饰器
 * 
 * @author PolarLoves
 *
 * @param <T>
 *            泛化类型
 */
public class DefaultExportDecorate<T> {

	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	/**
	 * 获取导入字段,默认和导出字段一致
	 * 
	 * @param entityClasses
	 *            字段类型
	 * @return 导入字段
	 */
	public List<ExcellField> getImportFields(Class<? extends T> entityClasses) {
		return getExportFields(entityClasses);
	}

	/**
	 * 获取导出字段
	 * 
	 * @param entityClasses
	 *            实体具体的类型
	 * 
	 * @return 导出字段
	 */
	public List<ExcellField> getExportFields(Class<? extends T> entityClasses) {
		List<ExcellField> fields = new ArrayList<ExcellField>();
		for (Field field : entityClasses.getDeclaredFields()) {
			polar.island.core.excell.ExcellField inner = field
					.getAnnotation(polar.island.core.excell.ExcellField.class);
			if (inner != null) {
				ExcellField mField = new ExcellField();
				mField.setName(field.getName());
				mField.setTitle(inner.title());
				mField.setClasses(field.getType());
				mField.setOrderNum(inner.orderNum());
				mField.setWidth(inner.width());
				fields.add(mField);
			}
		}
		Collections.sort(fields);
		return fields;
	}

	/**
	 * 获取导出值
	 * 
	 * @param entityClasses
	 *            实体具体类型
	 * @param type
	 *            导出类型
	 * @param object
	 *            实体对象
	 * @throws Exception
	 *             导出异常
	 * @return 获取导出值
	 * 
	 */
	@SuppressWarnings("unchecked")
	public String getExportValue(ExcellField type, Object object, Class<? extends T> entityClasses) throws Exception {
		Object value = null;
		if (object instanceof Map) {
			value = ((Map<String, Object>) object).get(type.getName());
		} else {
			value = getValue(type.getName(), (T) object, entityClasses);
		}
		return formatExportField(type, value, object);
	}

	/**
	 * 格式化导出字段的值。
	 * 
	 * @param type
	 *            导出类型
	 * @param value
	 *            导出值
	 * @param object
	 *            导出实体
	 * @return 格式化后的数据
	 */
	public String formatExportField(ExcellField type, Object value, Object object) {
		if (value == null) {
			return "";
		}
		if (type.getClasses() == Date.class) {
			return sdf.format(value);
		}
		return CommonUtil.valueOf(value);
	}

	/**
	 * 调用get方法获取值
	 * 
	 * @param fieldName
	 *            字段名称
	 * @param object
	 *            实体
	 * @param classes
	 *            实体类名
	 * @return 获取到的值
	 * @throws Exception
	 *             异常信息
	 */
	protected Object getValue(String fieldName, T object, Class<? extends T> classes) throws Exception {
		char[] cs = fieldName.toCharArray();
		cs[0] -= 32;
		String methodName = "get" + CommonUtil.valueOf(cs);
		Method method = classes.getDeclaredMethod(methodName);
		return method.invoke(object);
	}

	/**
	 * 格式化导入值
	 * 
	 * @param type
	 *            导出类型
	 * @param value
	 *            值
	 * @param object
	 *            需要放入的map对象
	 * @param entityClass
	 *            实体类的类型
	 * @throws Exception
	 *             错误信息
	 */
	public void formatImportField(ExcellField type, String value, Map<String, Object> object,
			Class<? extends T> entityClass) throws Exception {
		Class<?> fieldType = type.getClasses();
		Object realValue = formatImportValue(type.getName(), type.getTitle(), value, object, fieldType);
		object.put(type.getName(), realValue);
	}

	/**
	 * 调用set方法设置值。
	 * 
	 * @param fieldName
	 *            字段名称
	 * @param object
	 *            对象
	 * @param classes
	 *            对象类型
	 * @param value
	 *            值
	 * @param fieldClass
	 *            字段类型
	 * @throws Exception
	 *             错误信息
	 */
	protected void setValue(String fieldName, T object, Class<? extends T> classes, Object value, Class<?> fieldClass)
			throws Exception {
		char[] cs = fieldName.toCharArray();
		cs[0] -= 32;
		String methodName = "set" + CommonUtil.valueOf(cs);
		Method method = classes.getDeclaredMethod(methodName, fieldClass);
		method.invoke(object, value);
	}

	/**
	 * 格式化导入值
	 * 
	 * @param name
	 *            字段名称
	 * @param title
	 *            标题
	 * @param value
	 *            值
	 * @param object
	 *            需要设置的数据
	 * @param fieldType
	 *            字段类型
	 * @return 格式化后的值
	 * @throws Exception
	 *             错误信息
	 */
	public Object formatImportValue(String name, String title, String value, Map<String, Object> object,
			Class<?> fieldType) throws Exception {
		Object realValue = null;
		if (fieldType == int.class || fieldType == Integer.class) {
			if (value != null) {
				realValue =CommonUtil.str2Int(value);
			} else {
				if (fieldType == int.class) {
					realValue = 0;
				}
			}
		} else if (fieldType == long.class || fieldType == Long.class) {
			if (value != null) {
				realValue = CommonUtil.str2Long(value);
			} else {
				if (fieldType == long.class) {
					realValue = 0L;
				}
			}
		} else if (fieldType == byte.class || fieldType == Byte.class) {
			if (value != null) {
				realValue = Byte.parseByte(value);
			} else {
				if (fieldType == byte.class) {
					realValue = 0;
				}
			}
		} else if (fieldType == short.class || fieldType == Short.class) {
			if (value != null) {
				realValue = Short.parseShort(value);
			} else {
				if (fieldType == short.class) {
					realValue = 0;
				}
			}
		} else if (fieldType == double.class || fieldType == Double.class) {
			if (value != null) {
				realValue =CommonUtil.str2Double(value);
			} else {
				if (fieldType == double.class) {
					realValue = 0d;
				}
			}
		} else if (fieldType == float.class || fieldType == Float.class) {
			if (value != null) {
				realValue = CommonUtil.str2Float(value);
			} else {
				if (fieldType == float.class) {
					realValue = 0f;
				}
			}
		} else if (fieldType == boolean.class || fieldType == Boolean.class) {
			if (value != null) {
				realValue = Boolean.parseBoolean(value);
			} else {
				if (fieldType == boolean.class) {
					realValue = false;
				}
			}
		} else if (fieldType == String.class) {
			realValue = CommonUtil.valueOf(value);
		} else if (fieldType == Date.class) {
			realValue = sdf.parse(value);
		}
		return realValue;
	}

	public Object formatExportValue(String name, String title, Object value, T object) {
		return value;
	}

	public static class ExcellField implements Comparable<ExcellField> {
		private String name;
		private String title;
		private int width;
		private int orderNum;
		private Class<?> classes;

		public int getWidth() {
			return width;
		}

		public void setWidth(int width) {
			this.width = width;
		}

		public int getOrderNum() {
			return orderNum;
		}

		public void setOrderNum(int orderNum) {
			this.orderNum = orderNum;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getTitle() {
			return title;
		}

		public void setTitle(String title) {
			this.title = title;
		}

		public Class<?> getClasses() {
			return classes;
		}

		public void setClasses(Class<?> classes) {
			this.classes = classes;
		}

		@Override
		public int compareTo(ExcellField o) {
			int i = this.getOrderNum() - o.getOrderNum();
			return i;
		}

	}
}
