package polar.island.core.controller;

import org.apache.commons.lang3.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.multipart.MultipartFile;
import polar.island.core.config.Constants;
import polar.island.core.entity.BasicEntity;
import polar.island.core.exception.DataNotExistException;
import polar.island.core.exception.FrameWorkException;
import polar.island.core.exception.ValidationException;
import polar.island.core.util.DateUtils;
import polar.island.core.util.EntityUtil;
import polar.island.core.util.PropertieUtil;
import polar.island.core.validator.TAG;

import javax.annotation.Resource;
import java.beans.PropertyEditorSupport;
import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 基础的Controller类。
 *
 * @author PolarLoves
 */

public abstract class BasicController {
    /**
     * 日志记录器
     **/
    public final Logger logger = LoggerFactory.getLogger(getClass());

    @Resource(name = "validator")
    private Validator validator;

    /**
     * 初始化数据绑定 1. 将所有传递进来的String进行HTML编码，防止XSS攻击 2. 将字段中Date类型转换为String类型
     *
     * @param binder spring的写法
     */
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        // String类型转换，将所有传递进来的String进行HTML编码，防止XSS攻击
        binder.registerCustomEditor(String.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) {
                setValue(text == null ? null : StringEscapeUtils.escapeHtml4(text.trim()));
            }

            @Override
            public String getAsText() {
                Object value = getValue();
                return value != null ? value.toString() : "";
            }
        });
        // Date 类型转换
        binder.registerCustomEditor(Date.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) {
                setValue(DateUtils.parseDate(text));
            }
        });
        binder.setValidator(validator);

    }

    /**
     * 依据标签判断是否匹配，如果匹配则返回true。
     *
     * @param tag  需要校验的标签。
     * @param tags 标签数组。
     * @return 校验结果。
     */
    private boolean checkTAG(String tag, String[] tags) {
        if (tags != null && tags.length > 0 && tag != null) {
            boolean result = false;
            for (String temp : tags) {
                if (temp.equals(tag)) {
                    result = true;
                }
            }
            return result;
        }
        return true;
    }

    /**
     * 校验数据，如校验不通过，则抛出异常。
     *
     * @param result 校验结果字段
     */
    public void validate(BindingResult result) {
        if (result.hasErrors()) {
            FieldError error = result.getFieldErrors().get(0);
            throw new ValidationException(error.getDefaultMessage(), null);
        }
    }

    /**
     * 校验数据，如校验不通过，则抛出异常。
     *
     * @param entityClass 实体类
     * @param tag         标签，一般以方法名称命名，如果标签中的value，不含有tag值，则忽略此字段的异常。
     * @param result      校验结果
     * @param <T>         实体类型
     */
    public <T> void validate(Class<T> entityClass, String tag, BindingResult result) {
        if (result.hasErrors()) {
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                filterFieldErrorByTag(error, entityClass, tag);
            }
        }
    }

    private <T> Class getNextClass(Class<T> entityClass, String name) throws Exception {
        if (name.contains("[")) {
            //表示为集合，使用其泛型
            String realName = name.substring(0, name.indexOf("["));
            Field field = entityClass.getDeclaredField(realName);
            ParameterizedType parameterizedType = (ParameterizedType) field.getGenericType();
            Class nextClass = (Class) parameterizedType.getActualTypeArguments()[0];
            return nextClass;
        } else {
            Class nextClass = entityClass.getDeclaredField(name).getType();
            return nextClass;
        }
    }

    /**
     * 依据字段名称获取字段对应实体类类型，字段名称可以为如下格式：list[0].name
     *
     * @param name        字段名称
     * @param entityClass 数据类型
     * @param <T>
     * @return 字段类型
     * @throws Exception
     */
    private <T> Field getFiledByName(String name, Class<T> entityClass) throws Exception {
        if (name.contains(".")) {
            String subName = name.substring(name.indexOf(".") + ".".length());
            String currentName = name.substring(0, name.indexOf("."));
            Class nextClass = getNextClass(entityClass, currentName);
            return getFiledByName(subName, nextClass);
        } else {
            return entityClass.getDeclaredField(name);
        }
    }

    /**
     * 过滤掉不包含这个标签的所有错误
     *
     * @param error       校验错误
     * @param entityClass 实体类类型
     * @param tag         标签
     * @param <T>         实体类类型
     */
    private <T> void filterFieldErrorByTag(FieldError error, Class<T> entityClass, String tag) {
        try {
            Field field = getFiledByName(error.getField(), entityClass);
            TAG tagAnnotation = field.getAnnotation(TAG.class);
            if (tagAnnotation != null && checkTAG(tag, tagAnnotation.value())) {
                throw new ValidationException(error.getDefaultMessage(), null);
            } else {
                return;
            }
        } catch (ValidationException e) {
            throw e;
        } catch (Exception e) {
            throw new FrameWorkException(Constants.CODE_SERVER_ERROR, null, e, true);
        }
    }


    /**
     * 将JAVABEAN转为MAP类型。
     *
     * @param obj 待转的对象
     * @return 转换后的Map类型
     */
    public Map<String, Object> beanToMap(Object obj) {
        return EntityUtil.beanToMap(obj);
    }

    /**
     * 将实体转换为更新单个字段时的条件
     *
     * @param entity 实体类
     * @return 转换后的Map
     */
    public Map<String, Object> beanToSingleField(BasicEntity entity) {
        return EntityUtil.beanToSingleField(entity);
    }

    /**
     * 校验数据是否存在，如果不存在则抛出异常。
     *
     * @param entity 需要校验的数据
     * @param prefix 校验异常的前缀
     */
    public void existCheck(BasicEntity entity, String prefix) {
        if (entity == null) {
            throw new DataNotExistException(prefix == null ? PropertieUtil.getSetting("MSG_DATA_NOT_EXIST_DEFAULT") : (prefix + PropertieUtil.getSetting("MSG_DATA_NOT_EXIST")), null);
        }
    }

    /**
     * 校验数据是否存在，如果不存在则抛出异常。
     *
     * @param entity 需要校验的数据
     * @param prefix 校验异常的前缀
     */
    public void existCheck(Map<String, Object> entity, String prefix) {
        if (entity == null) {
            throw new DataNotExistException(prefix == null ? PropertieUtil.getSetting("MSG_DATA_NOT_EXIST_DEFAULT") : (prefix + PropertieUtil.getSetting("MSG_DATA_NOT_EXIST")), null);
        }
    }

    /**
     * 校验数据是否有效
     *
     * @param value
     * @param effectiveValue
     * @param prefix
     */
    public void effectiveCheck(String value, String effectiveValue, String prefix) {
        if (!effectiveValue.equalsIgnoreCase(value)) {
            throw new DataNotExistException(prefix == null ? PropertieUtil.getSetting("MSG_DATA_NOT_EFFECTIVE_DEFAULT") : (prefix + PropertieUtil.getSetting("MSG_DATA_NOT_EFFECTIVE")), null);
        }
    }

    /**
     * 校验数据编号是否存在
     *
     * @param id     数据编号
     * @param prefix 前缀
     */
    public void idCheck(String id, String prefix) {
        if (StringUtils.isEmpty(id)) {
            throw new ValidationException(prefix == null ? PropertieUtil.getSetting("MSG_DATA_ID_EMPTY") : (prefix + PropertieUtil.getSetting("MSG_DATA_ID_EMPTY_DEFAULT")), null);
        }
    }

    /**
     * 校验数据编号是否存在
     *
     * @param ids    数据编号
     * @param prefix 前缀
     */
    public void idCheck(String[] ids, String prefix) {
        if (ids == null || ids.length == 0) {
            throw new ValidationException(prefix == null ? PropertieUtil.getSetting("MSG_DATA_ID_EMPTY") : (prefix + PropertieUtil.getSetting("MSG_DATA_ID_EMPTY_DEFAULT")), null);
        }
    }

    /**
     * 校验文件是否为空
     *
     * @param file
     */
    public void fileCheck(MultipartFile file) {
        if (file == null) {
            throw new ValidationException(PropertieUtil.getSetting("MSG_FILE_EMPTY"), null);
        }
    }
}
