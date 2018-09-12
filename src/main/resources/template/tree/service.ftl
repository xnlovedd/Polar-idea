package ${code.packageName}.${code.moduleName}.service;
import java.util.Map;
import java.util.List;
import polar.island.core.service.BasicService;
<#if code.deleteMode !=0>import org.apache.ibatis.annotations.Param;</#if>
<#if code.moduleType !=0>import ${code.packageName}.${code.moduleName}.entity.${code.entityName};</#if>
/**
 * ${code.moduleRemark}的服务类，其实现类标签为：${code.serviceTag},删除模式为：<#if code.deleteMode==0>全部<#elseif code.deleteMode==1>仅物理删除<#else>仅逻辑删除</#if>。
 *
 * @author  ${code.author}
 *
 */
public interface ${code.serviceName} extends BasicService<<#if code.moduleType==0 || code.moduleType==3>Map<String, Object><#else>${code.entityName}</#if>,<#if code.moduleType==1 || code.moduleType==3>${code.entityName}<#else>Map<String, Object></#if>> {
	<#if code.deleteMode==1>
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
	</#if>
	<#if code.deleteMode==2>
	/**
	 * 由于仅有逻辑删除，此删除方法被移除
	 */
	@Deprecated
	public Long deleteByIdPhysical(String id);
	/**
	 * 由于仅有逻辑删除，此删除方法被移除
	 */
	@Deprecated
	public Long deleteByConditionPhysical(Map<String, Object> condition);
	</#if>
	/**
	 * 查询所有的数据,并且按照parentId进行升序排序,由前台进行排序处理。
     *
     * @return 所有的数据
	 */
	public List<<#if code.moduleType==0 || code.moduleType==3>Map<String, Object><#else>${code.entityName}</#if>> selectAllList();
}