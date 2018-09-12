package polar.island.inlay.code.dao;

import org.apache.ibatis.annotations.Param;
import polar.island.core.dao.BasicDao;
import polar.island.database.DAO;
import polar.island.inlay.code.entity.CodeColumn;
import polar.island.inlay.code.entity.CodeEntity;
import polar.island.inlay.code.entity.JdbcType;

import java.util.List;
import java.util.Map;

@DAO(value = "codeDao")
public interface CodeDao extends BasicDao<CodeEntity, CodeEntity> {

	@Deprecated
	public Long deleteByIdLogic(@Param(value = "id") String id);

	@Deprecated
	public Long deleteByConditionLogic(Map<String, Object> condition);

	// 依据表编号，删除列属性
	public Long deleteColumns(Long tableId);

	// 增加列
	public void insertColumns(CodeColumn codeColumn);

	// 查询表的列字段
	public List<CodeColumn> selectColumns(Long tableId);

	// 查询表的所有原始字段
	public List<JdbcType> selectColumnsFromTable(String tableName);

	// 查询表的主键
	public List<Map<String, Object>> selectPkFromTable(String tableName);
	//查询所有的表名
	public List<Map<String, Object>> allTableNames();
}
