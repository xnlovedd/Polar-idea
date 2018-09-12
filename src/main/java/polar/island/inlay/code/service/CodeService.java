package polar.island.inlay.code.service;

import polar.island.core.service.BasicService;
import polar.island.inlay.code.entity.CodeColumn;
import polar.island.inlay.code.entity.CodeEntity;

import java.util.List;
import java.util.Map;

public interface CodeService extends BasicService<CodeEntity, CodeEntity> {
	/**
	 * 获取所有的表以及注释
	 * 
	 * @return 表数据
	 */
	public List<Map<String, Object>> allTableNames();

	/**
	 * 导入表以及列。
	 * 
	 * @param tableName
	 *            表名
	 * @param commont
	 *            表中文名
	 * @param moduleName
	 *            模块名称
	 */
	public void importTable(String tableName, String commont, String moduleName);

	@Deprecated
	public Long deleteByIdLogic(String id);

	@Deprecated
	public Long deleteByConditionLogic(Map<String, Object> condition);

	@Deprecated
	public Long deleteMulitByIdLogic(String[] ids);

	/**
	 * 增加列属性。
	 * 
	 * @param codeColumn
	 *            待增加的列
	 * @param tableId
	 *            表编号
	 */
	public void insertColumns(List<CodeColumn> codeColumn, Long tableId);

	/**
	 * 查询已生成的所有列。
	 * 
	 * @param tableId
	 *            表编号
	 * @return 查询到的列属性
	 */
	public List<CodeColumn> selectColumns(Long tableId);

	/**
	 * 生成表的列数据
	 * 
	 * @param tableId
	 *            表编号
	 * @param entity
	 *            查询到的实体
	 */
	public void genColumns(Long tableId, CodeEntity entity);

	/**
	 * 生成配置
	 * 
	 * @param entity 配置实体
	 */
	public void genSettings(CodeEntity entity);


	public List<Map<String, Object>> allChildrens(String parentTableId);
}
