package ${code.packageName}.${code.moduleName}.service;
import java.util.Map;
import java.util.Date;
import java.util.List;
import org.springframework.util.CollectionUtils;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import polar.island.core.service.BasicServiceImpl;
import polar.island.database.AttachmentDao;
import polar.island.core.entity.AttachmentEntity;
<#if code.idType!=0>import polar.island.core.util.CommonUtil;</#if>
import ${code.packageName}.${code.moduleName}.dao.${code.daoName};
<#if code.moduleType!=0>import ${code.packageName}.${code.moduleName}.entity.${code.entityName};</#if>
import polar.island.core.util.CommonUtil;
<#assign parentCode ><#if code.idField==code.parentField>${code.idField}<#else><#list columns as mData><#if mData.name == code.parentField>${mData.javaName}</#if></#list></#if></#assign>
<#assign childCode ><#if code.childField==code.idField>${code.idField}<#else><#list columns as mData><#if mData.name == code.childField>${mData.javaName}</#if></#list></#if></#assign>
<#assign nameCode ><#if code.idField==code.nameField>${code.idField}<#else><#list columns as mData><#if mData.name == code.nameField>${mData.javaName}</#if></#list></#if></#assign>
<#assign valueCode ><#if code.idField==code.valueField>${code.idField}<#else><#list columns as mData><#if mData.name == code.valueField>${mData.javaName}</#if></#list></#if></#assign>
@Transactional(readOnly = true)
@Service(value = "${code.serviceTag}")
public class ${code.serviceImplName} extends BasicServiceImpl<<#if code.moduleType==0 || code.moduleType==3>Map<String, Object><#else>${code.entityName}</#if>,<#if code.moduleType==1 || code.moduleType==3>${code.entityName}<#else>Map<String, Object></#if>,${code.daoName}> implements ${code.serviceName} {
	@Resource(name = "${code.daoTag}")
	private ${code.daoName} ${code.daoName?uncap_first};
	@Resource(name = "attachmentDao")
    private AttachmentDao attachmentDao;
	@Override
	public ${code.daoName} getDao() {
		return ${code.daoName?uncap_first};
	}
	@Transactional(readOnly = false)
	@Override
	public Object insert(Map<String, Object> condition) {
		Object id=null;
<#if code.idType==0>
		${code.daoName?uncap_first}.insert(condition);
		id= condition.get("${code.idField}");
<#else>
		id=CommonUtil.randomId();
		condition.put("${code.idField}",id);
		${code.daoName?uncap_first}.insert(condition);
</#if>
<#list columns as mData><#if mData.type==10||mData.type==12>
		insertAttachment(condition.get("${mData.javaName}"),id,"${mData.javaName}");
</#if></#list>
		return id;
	}

 	private void insertAttachment(Object arg, Object id,String fieldName) {
	 	List<String> params = (List<String>) arg;
		if(params!=null&&params.size()>0){
			for (String param : params) {
				AttachmentEntity entity = new AttachmentEntity();
				entity.setAttachmentId(CommonUtil.valueOf(id));
				entity.setCreateDate(new Date());
				entity.setCreateDateMillions(System.currentTimeMillis());
				entity.setType("${code.tableName}_"+fieldName);
				entity.setVisitPath(param);
				attachmentDao.insert(entity);
			}
		}
    }
	@Transactional(readOnly = true)
	@Override
	public List<<#if code.moduleType==0 || code.moduleType==3>Map<String, Object><#else>${code.entityName}</#if>> selectAllList(){
		return getDao().selectAllList();
	}
	<#if code.deleteMode==1 || code.deleteMode==0>
	public Long deleteByIdPhysical(String id){
		return deleteChildrenPhysical(getDao().selectOneById(id),getDao().selectAllList(),0l);
	}
	/**
	 * 物理删除当前的数据以及其子数据。
     *
	 * @param current
	 *            当前需要删除的数据.
	 * @param entities
	 *            所有的数据.
	 * @param count
	 *            计数开始值.
     * @return 删除的总条目
	 */
	private Long deleteChildrenPhysical(<#if code.moduleType==0 || code.moduleType==3>Map<String, Object><#else>${code.entityName}</#if> current, List<<#if code.moduleType==0 || code.moduleType==3>Map<String, Object><#else>${code.entityName}</#if>> entities, Long count) {
		String id=<#if code.moduleType==0 || code.moduleType==3>CommonUtil.valueOf(current.get("${code.idField}"))<#else>CommonUtil.valueOf(current.get${code.idField?cap_first}())</#if>;
		count = count +  getDao().deleteByIdPhysical(id);
		<#list columns as mData><#if mData.type==10||mData.type==12>
		attachmentDao.deleteAttachment("${code.tableName}_${mData.javaName}",id);
		</#if></#list>
        if (CollectionUtils.isEmpty(entities)) {
			String childId=<#if code.moduleType==0 || code.moduleType==3>CommonUtil.valueOf(current.get("${childCode}"))<#else>CommonUtil.valueOf(current.get${parentCode?cap_first}())</#if>;
            for (<#if code.moduleType==0 || code.moduleType==3>Map<String, Object><#else>${code.entityName}</#if> entity : entities) {
				String parentId=<#if code.moduleType==0 || code.moduleType==3>CommonUtil.valueOf(entity.get("${parentCode}"))<#else>CommonUtil.valueOf(entity.get${parentCode?cap_first}())</#if>;
                if (childId.equals(parentId)) {
                    count = deleteChildrenPhysical(entity, entities, count);
                }
            }
        }
	    return count;
	}
	</#if>
	<#if code.deleteMode==2 || code.deleteMode==0>
	public Long deleteByIdLogic(String id){
		return deleteChildrenLogic(getDao().selectOneById(id),getDao().selectAllList(),0l);
	}
	/**
	 * 逻辑删除当前的数据以及其子数据。
     *
	 * @param current
	 *            当前需要删除的数据.
	 * @param entities
	 *            所有的数据.
	 * @param count
	 *            计数开始值.
     * @return 删除的总条目
	 */
	private Long deleteChildrenLogic(<#if code.moduleType==0 || code.moduleType==3>Map<String, Object><#else>${code.entityName}</#if> current, List<<#if code.moduleType==0 || code.moduleType==3>Map<String, Object><#else>${code.entityName}</#if>> entities, Long count) {
		String id=<#if code.moduleType==0 || code.moduleType==3>CommonUtil.valueOf(current.get("${code.idField}"))<#else>CommonUtil.valueOf(current.get${code.idField?cap_first}())</#if>;
		count = count +  getDao().deleteByIdLogic(id);
		<#list columns as mData><#if mData.type==10||mData.type==12>
		attachmentDao.deleteAttachment("${code.tableName}_${mData.javaName}",id);
		</#if></#list>
        if (CollectionUtils.isEmpty(entities)) {
			String childId=<#if code.moduleType==0 || code.moduleType==3>CommonUtil.valueOf(current.get("${childCode}"))<#else>CommonUtil.valueOf(current.get${parentCode?cap_first}())</#if>;
            for (<#if code.moduleType==0 || code.moduleType==3>Map<String, Object><#else>${code.entityName}</#if> entity : entities) {
				String parentId=<#if code.moduleType==0 || code.moduleType==3>CommonUtil.valueOf(entity.get("${parentCode}"))<#else>CommonUtil.valueOf(entity.get${parentCode?cap_first}())</#if>;
                if (childId.equals(parentId)) {
                    count = deleteChildrenLogic(entity, entities, count);
                }
            }
        }
	    return count;
	}
	</#if>
	@Override
	public <#if code.moduleType==1 || code.moduleType==3>${code.entityName}<#else>Map<String, Object></#if> selectOneById(String id) {
		<#if code.moduleType==1 || code.moduleType==3>${code.entityName}<#else>Map<String, Object></#if> result=super.selectOneById(id);
<#list columns as mData><#if mData.type==10||mData.type==12>
		<#if code.moduleType==1 || code.moduleType==3>result.set${mData.javaName?cap_first}(attachmentDao.selectAttachment("${code.tableName}_${mData.javaName}",id));<#else>result.put("${mData.javaName}",attachmentDao.selectAttachment("${code.tableName}_${mData.javaName}",id));</#if>
</#if>
</#list>
        return result;
    }
	@Override
	public <#if code.moduleType==1 || code.moduleType==3>${code.entityName}<#else>Map<String, Object></#if> selectOneByCondition(Map<String, Object> condition) {
		<#if code.moduleType==1 || code.moduleType==3>${code.entityName}<#else>Map<String, Object></#if> result=super.selectOneByCondition(condition);
<#list columns as mData><#if mData.type==10||mData.type==12>
		<#if code.moduleType==1 || code.moduleType==3>result.set${mData.javaName?cap_first}(attachmentDao.selectAttachment("${code.tableName}_${mData.javaName}",CommonUtil.valueOf(result.get${code.idField?cap_first}())));<#else>result.put("${mData.javaName}",attachmentDao.selectAttachment("${code.tableName}_${mData.javaName}",CommonUtil.valueOf(result.get("${code.idField}"))));</#if>
</#if>
</#list>
        return result;
    }
	@Override
	public Long updateAll(Map<String, Object> condition) {
		String id=CommonUtil.valueOf(condition.get("${code.idField}"));
<#list columns as mData><#if mData.type==10||mData.type==12>
		attachmentDao.deleteAttachment("${code.tableName}_${mData.javaName}",id);
</#if>
</#list>
<#list columns as mData><#if mData.type==10||mData.type==12>
		insertAttachment(condition.get("${mData.javaName}"),id,"${mData.javaName}");
</#if></#list>
		return super.updateAll(condition);
	}
}