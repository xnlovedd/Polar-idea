package ${code.packageName}.${code.moduleName}.service;
import java.util.List;
import java.util.Map;
import java.util.Date;
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
	<#if code.deleteMode!=2>
	public Long deleteByIdPhysical(String id){
<#list columns as mData><#if mData.type==10||mData.type==12>
		attachmentDao.deleteAttachment("${code.tableName}_${mData.javaName}",id);
</#if></#list>
		return super.deleteByIdPhysical(id);
	}
	</#if>
	public <#if code.moduleType==1 || code.moduleType==3>${code.entityName}<#else>Map<String, Object></#if> selectOneById(String id) {
		<#if code.moduleType==1 || code.moduleType==3>${code.entityName}<#else>Map<String, Object></#if> result=super.selectOneById(id);
<#list columns as mData><#if mData.type==10||mData.type==12>
		<#if code.moduleType==1 || code.moduleType==3>result.set${mData.javaName?cap_first}(attachmentDao.selectAttachment("${code.tableName}_${mData.javaName}",id));<#else>result.put("${mData.javaName}",attachmentDao.selectAttachment("${code.tableName}_${mData.javaName}",id));</#if>
</#if>
</#list>
        return result;
    }
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