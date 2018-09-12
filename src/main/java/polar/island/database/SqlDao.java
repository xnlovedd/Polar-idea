package polar.island.database;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@DAO(value = "sqlDao")
public interface SqlDao {
	public List<Map<String, Object>> querySql(@Param(value = "sql") String sql);
	public Map<String, Object> queryOne(@Param(value = "sql") String sql);
	public void insertSql(@Param(value = "sql") String sql);

	public int updateSql(@Param(value = "sql") String sql);
}
