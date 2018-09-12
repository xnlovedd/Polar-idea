package ${code.packageName}.${code.moduleName}.dao;
import java.util.Map;
<#if code.deleteMode !=0>import org.apache.ibatis.annotations.Param;</#if>
<#if code.moduleType !=0>import ${code.packageName}.${code.moduleName}.entity.${code.entityName};</#if>
import polar.island.core.dao.BasicDao;
import polar.island.database.DAO;
/**
 * ${code.tableRemark}的持久化层,${parent.code.tableRemark}的子表，其列表字段与详情字段一致。
 * 
 * @author ${code.author}
 *
 */
@DAO(value="${code.daoTag}")
public interface ${code.daoName} extends BasicDao<<#if code.moduleType==0 || code.moduleType==3>Map<String, Object><#else>${code.entityName}</#if>,<#if code.moduleType==1 || code.moduleType==3>${code.entityName}<#else>Map<String, Object></#if>> {
	<#if code.deleteMode==1>
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
	</#if>
	<#if code.deleteMode==2>
	/**
	 * 由于仅有逻辑删除，此删除方法被移除
	 */
	@Deprecated
	public Long deleteByIdPhysical(@Param(value = "id") String id);
	/**
	 * 由于仅有逻辑删除，此删除方法被移除
	 */
	@Deprecated
	public Long deleteByConditionPhysical(Map<String, Object> condition);
	</#if>
}
