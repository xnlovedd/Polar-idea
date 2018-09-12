package polar.island.core.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 基础持久化类。
 * 
 * @author PolarLoves
 *
 * @param <T>
 *            列表结果集泛化类型
 * @param <D>
 *            详情结果集泛化类型
 */
public interface BasicDao<T, D> {
	/**
	 * 依据数据编号查找一条数据。
	 * 
	 * @param id
	 *            数据编号。
	 * @return 查找的实体数据。
	 */
	public D selectOneById(@Param(value = "id") String id);

	/**
	 * 依据数据编号查找一条数据。
	 * 
	 * @param condition
	 *            查询条件。
	 * @return 查找的实体数据。
	 */
	public D selectOneByCondition(Map<String, Object> condition);

	/**
	 * 依据条件查询多条数据，不带分页。
	 * 
	 * @param condition
	 *            查询条件。
	 * @return 查询到的数据
	 */
	public List<T> selectList(Map<String, Object> condition);
	/**
	 * 查询导出数据
	 * @param condition 查询参数
	 * @return 查询出来的结果
	 */
	public List<Map<String,Object>> selectExportList(Map<String, Object> condition);

	/**
	 * 依据条件查询多条数据，带有分页。
	 * 
	 * @param condition
	 *            查询条件。
	 * @return 查询到的数据
	 */
	public List<T> selectPageList(Map<String, Object> condition);

	/**
	 * 查询符合条件的总数量。
	 * 
	 * @param condition
	 *            查询条件。
	 * @return 查询到的数据条目。
	 */
	public Long selectCount(Map<String, Object> condition);

	/**
	 * 更新表中所有的字段。
	 * 
	 * @param condition
	 *            更新条件。
	 * @return 更新的条目数。
	 */
	public Long updateAll(Map<String, Object> condition);

	/**
	 * 更新表中一个或多个字段。
	 * 
	 * @param condition
	 *            更新条件。
	 * @return 更新的条目数。
	 */
	public Long updateField(Map<String, Object> condition);

	/**
	 * 依据数据编号物理删除数据。
	 * 
	 * @param id
	 *            数据编号
	 * @return 删除的数量。
	 */
	public Long deleteByIdPhysical(@Param(value = "id") String id);

	/**
	 * 依据条件物理删除数据。
	 * 
	 * @param condition
	 *            删除条件
	 * @return 删除的数量。
	 */
	public Long deleteByConditionPhysical(Map<String, Object> condition);

	/**
	 * 新增一条数据,如果想要返回数据，请修改mapper文件下的insert语句，useGeneratedKeys="true" keyProperty="id"
	 * 
	 * @param condition
	 *            待增加的数据
	 */
	public void insert(Map<String, Object> condition);

	/**
	 * 依据数据编号逻辑删除数据。
	 * 
	 * @param id
	 *            数据编号
	 * @return 删除的数量。
	 */
	public Long deleteByIdLogic(@Param(value = "id") String id);

	/**
	 * 依据条件逻辑删除数据。
	 * 
	 * @param condition
	 *            删除条件
	 * @return 删除的数量。
	 */
	public Long deleteByConditionLogic(Map<String, Object> condition);
}
