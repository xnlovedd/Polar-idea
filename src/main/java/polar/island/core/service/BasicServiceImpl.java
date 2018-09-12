package polar.island.core.service;

import org.apache.ibatis.exceptions.TooManyResultsException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.transaction.annotation.Transactional;
import polar.island.core.config.Constants;
import polar.island.core.dao.BasicDao;
import polar.island.core.exception.FrameWorkException;

import java.util.List;
import java.util.Map;


/**
 * Service层的实现类。
 *
 * @param <T> 列表结果集泛化类型
 * @param <F> 详情结果集泛化类型
 * @param <D> Dao类型
 * @author PolarLoves
 */
@Transactional(readOnly = true)
public abstract class BasicServiceImpl<T, F, D extends BasicDao<T, F>> implements BasicService<T, F> {
    public final Logger logger = LoggerFactory.getLogger(getClass());

    public abstract D getDao();

    public F selectOneById(String id) {
        return getDao().selectOneById(id);
    }

    @Transactional(readOnly = false)
    public void importExcell(List<Map<String, Object>> condition) {
        for (Map<String, Object> arg : condition) {
            getDao().insert(arg);
        }
    }

    public F selectOneByCondition(Map<String, Object> condition) {
        try {
            return getDao().selectOneByCondition(condition);
        } catch (org.mybatis.spring.MyBatisSystemException e) {
            if (e.getCause() != null && e.getCause() instanceof TooManyResultsException) {
                throw new FrameWorkException(Constants.CODE_MULTI_RESULT, null, e, true);
            }
            throw e;
        }

    }

    public List<T> selectList(Map<String, Object> condition) {
        return getDao().selectList(condition);
    }

    public List<T> selectPageList(Map<String, Object> condition) {
        return getDao().selectPageList(condition);
    }

    public Long selectCount(Map<String, Object> condition) {
        return getDao().selectCount(condition);
    }

    @Transactional(readOnly = false)
    public Long updateAll(Map<String, Object> condition) {
        return getDao().updateAll(condition);
    }

    @Transactional(readOnly = false)
    public Long updateField(Map<String, Object> condition) {
        return getDao().updateField(condition);
    }

    @Transactional(readOnly = false)
    public Long deleteByIdPhysical(String id) {
        return getDao().deleteByIdPhysical(id);
    }

    @Transactional(readOnly = false)
    public Long deleteByIdLogic(String id) {
        return getDao().deleteByIdLogic(id);
    }

    @Transactional(readOnly = false)
    public Long deleteMulitByIdPhysical(String[] ids) {
        Long result = 0L;
        for (String id : ids) {
            result = result + getDao().deleteByIdPhysical(id);
        }
        return result;
    }

    @Transactional(readOnly = false)
    public Long deleteMulitByIdLogic(String[] ids) {
        Long result = 0L;
        for (String id : ids) {
            result = result + getDao().deleteByIdLogic(id);
        }
        return result;
    }

    @Transactional(readOnly = false)
    public Long deleteByConditionPhysical(Map<String, Object> condition) {
        return getDao().deleteByConditionPhysical(condition);
    }

    @Transactional(readOnly = false)
    public Long deleteByConditionLogic(Map<String, Object> condition) {
        return getDao().deleteByConditionLogic(condition);
    }

    public List<Map<String, Object>> selectExportList(Map<String, Object> condition) {
        return getDao().selectExportList(condition);
    }
}
