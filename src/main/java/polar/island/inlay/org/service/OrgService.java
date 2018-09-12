package polar.island.inlay.org.service;
import java.util.Map;
import java.util.List;
import polar.island.core.service.BasicService;
import org.apache.ibatis.annotations.Param;
import polar.island.inlay.org.entity.OrgEntity;
/**
 * 机构的服务类，其实现类标签为：orgService,删除模式为：仅物理删除。
 *
 * @author  PolarLoves
 *
 */
public interface OrgService extends BasicService<OrgEntity,OrgEntity> {
	/**
	 * 由于仅有物理删除，此删除方法被移除
	 */
	@Deprecated
	public Long deleteByIdLogic(String id);
	/**
	 * 由于仅有物理删除，此删除方法被移除
	 */
	@Deprecated
	public Long deleteByConditionLogic(Map<String, Object> condition);
	/**
	 * 查询所有的数据,并且按照parentId进行升序排序,由前台进行排序处理。
     *
     * @return 所有的数据
	 */
	public List<OrgEntity> selectAllList();
}