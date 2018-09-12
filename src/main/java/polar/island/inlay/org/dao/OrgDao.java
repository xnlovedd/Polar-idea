package polar.island.inlay.org.dao;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import polar.island.inlay.org.entity.OrgEntity;
import polar.island.core.dao.BasicDao;
import polar.island.database.DAO;
import java.util.List;
/**
 * 机构的持久化层。
 * 
 * @author PolarLoves
 *
 */
@DAO(value="orgDao")
public interface OrgDao extends BasicDao<OrgEntity,OrgEntity> {
	/**
	 * 由于仅有物理删除，此删除方法被移除
	 */
	@Deprecated
	public Long deleteByIdLogic(@Param(value = "id") String id);
	/**
	 * 由于仅有物理删除，此删除方法被移除
	 */
	@Deprecated
	public Long deleteByConditionLogic(Map<String, Object> condition);
	/**
	 * 查询所有的数据,并且按照parentId进行升序排序
     *
     * @return 所有的数据
	 */
	public List<OrgEntity> selectAllList();

}
