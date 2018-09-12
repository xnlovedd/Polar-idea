package ${code.packageName}.${code.moduleName}.service;
import java.util.*;
import org.springframework.util.CollectionUtils;
import javax.annotation.Resource;
import polar.island.core.util.EntityUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import polar.island.core.service.BasicServiceImpl;
import polar.island.core.util.CommonUtil;
import polar.island.database.AttachmentDao;
import polar.island.core.entity.AttachmentEntity;
<#list children as child>
import ${child.code.packageName}.${child.code.moduleName}.dao.${child.code.daoName};
import ${child.code.packageName}.${child.code.moduleName}.entity.${child.code.entityName};
</#list>
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
	<#list children as child>
	//${child.code.moduleName}的dao
	@Resource(name = "${child.code.daoTag}")
	private ${child.code.daoName} ${child.code.daoName?uncap_first};
	</#list>
	@Override
	public ${code.daoName} getDao() {
		return ${code.daoName?uncap_first};
	}
	/**
	 * 添加子表数据
	 * @param ${code.idField} 主表编号
	 * @param condition 包含子表数据的实体类
	 */
	private void addItems(Object ${code.idField},Map<String, Object> condition){
		//添加子表数据
<#list children as child>
	<#assign parentCode ><#list child.columns as mData><#if mData.name == child.code.childTableField>${mData.javaName}</#if></#list></#assign>
		List<${child.code.entityName}> ${child.code.entityName?uncap_first} =(List<${child.code.entityName}>)condition.get("${child.code.entityName?uncap_first}");
		if(!CollectionUtils.isEmpty(${child.code.entityName?uncap_first})){
			//添加${child.code.tableRemark}
			for(${child.code.entityName} item:${child.code.entityName?uncap_first}){
				Map<String,Object> itemValue=EntityUtil.beanToMap(item);
				Object id=null;
			<#if child.code.idType!=0>
				id=CommonUtil.randomId();
				condition.put("${child.code.idField}",id);
			</#if>
				//设置${child.code.tableRemark}其父类外键
				itemValue.put("${parentCode}",${code.idField});
				${child.code.daoName?uncap_first}.insert(itemValue);
				id=itemValue.get("${child.code.idField}");
	<#list child.columns as mData><#if mData.type==10||mData.type==12>
				insertChildAttachment(itemValue.get("${mData.javaName}"),id,"${mData.javaName}","${child.code.tableName}",CommonUtil.valueOf(${code.idField}));
	</#if>
	</#list>
			}
		}
</#list>
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
    private void insertChildAttachment(Object arg, Object id,String fieldName,String tableName,String pid) {
    	List<String> params = (List<String>) arg;
        if(params!=null&&params.size()>0){
			for (String param : params) {
				AttachmentEntity entity = new AttachmentEntity();
				entity.setAttachmentId(CommonUtil.valueOf(id));
				entity.setCreateDate(new Date());
				entity.setCreateDateMillions(System.currentTimeMillis());
				entity.setType(tableName+"_"+fieldName);
				entity.setVisitPath(param);
    		    entity.setPid(pid);
				attachmentDao.insert(entity);
			}
        }
	}
	@Override
	public <#if code.moduleType==0 || code.moduleType==2>Map<String, Object><#else>${code.entityName}</#if> selectOneById(String id) {
		<#if code.moduleType==0 || code.moduleType==2>Map<String, Object><#else>${code.entityName}</#if> entity=super.selectOneById(id);
		Map<String,Object> condition=new HashMap<String,Object>();
<#list children as child>
	<#assign parentCode ><#list child.columns as mData><#if mData.name == child.code.childTableField>${mData.javaName}</#if></#list></#assign>
	<#assign has=false/>
	<#list child.columns as mData><#if  mData.type==10||mData.type==12><#assign has=true/>
	</#if></#list>
		//查询${child.code.tableRemark}
		condition.put("${parentCode}",id);
		<#if has>
			<#if code.moduleType==0 || code.moduleType==2>entity.put("${child.code.entityName?uncap_first}",filter${child.code.moduleName?cap_first}(${child.code.daoName?uncap_first}.selectList(condition)));<#else>entity.set${child.code.entityName?cap_first}(filter${child.code.moduleName?cap_first}(${child.code.daoName?uncap_first}.selectList(condition)));</#if>
		    <#else>
		<#if code.moduleType==0 || code.moduleType==2>entity.put("${child.code.entityName?uncap_first}",${child.code.daoName?uncap_first}.selectList(condition));<#else>entity.set${child.code.entityName?cap_first}(${child.code.daoName?uncap_first}.selectList(condition));</#if>
		</#if>
		condition.clear();
</#list>
	<#list columns as mData><#if mData.type==10||mData.type==12>
		<#if code.moduleType==1 || code.moduleType==3>entity.set${mData.javaName?cap_first}(attachmentDao.selectAttachment("${code.tableName}_${mData.javaName}",id));<#else>entity.put("${mData.javaName}",attachmentDao.selectAttachment("${code.tableName}_${mData.javaName}",id));</#if>
	</#if>
	</#list>
		return entity;
	}
	@Override
	public  <#if code.moduleType==0 || code.moduleType==2>Map<String, Object><#else>${code.entityName}</#if> selectOneByCondition(Map<String, Object> condition) {
		<#if code.moduleType==0 || code.moduleType==2>Map<String, Object><#else>${code.entityName}</#if> entity=super.selectOneByCondition(condition);
		Object id=<#if code.moduleType==0 || code.moduleType==2>entity.get("${code.idField}");<#else > entity.get${code.idField?cap_first}();</#if>
<#list children as child><#assign has=false/>
	<#list child.columns as mData><#if  mData.type==10||mData.type==12><#assign has=true/>
	</#if></#list>
	<#assign parentCode ><#list child.columns as mData><#if mData.name == child.code.childTableField>${mData.javaName}</#if></#list></#assign>
		//查询${child.code.tableRemark}
		condition.put("${parentCode}",id);
	<#if has>
		<#if code.moduleType==0 || code.moduleType==2>entity.put("${child.code.entityName?uncap_first}",filter${child.code.moduleName?cap_first}(${child.code.daoName?uncap_first}.selectList(condition)));<#else>entity.set${child.code.entityName?cap_first}(filter${child.code.moduleName?cap_first}(${child.code.daoName?uncap_first}.selectList(condition)));</#if>
	<#else>
		<#if code.moduleType==0 || code.moduleType==2>entity.put("${child.code.entityName?uncap_first}",${child.code.daoName?uncap_first}.selectList(condition));<#else>entity.set${child.code.entityName?cap_first}(${child.code.daoName?uncap_first}.selectList(condition));</#if>
	</#if>
		condition.clear();
</#list>
<#list columns as mData><#if mData.type==10||mData.type==12>
		<#if code.moduleType==1 || code.moduleType==3>entity.set${mData.javaName?cap_first}(attachmentDao.selectAttachment("${code.tableName}_${mData.javaName}",CommonUtil.valueOf(entity.get${code.idField?cap_first}())));<#else>entity.put("${mData.javaName}",attachmentDao.selectAttachment("${code.tableName}_${mData.javaName}",CommonUtil.valueOf(entity.get("${code.idField}"))));</#if>
</#if>
</#list>
		return entity;
	}
	@Transactional(readOnly = false)
	@Override
	public Object insert(Map<String, Object> condition) {
		Object ${code.idField}=null;
		<#if code.idType==0>
		${code.daoName?uncap_first}.insert(condition);
		${code.idField}=condition.get("${code.idField}");
		<#else>
		${code.idField}=CommonUtil.randomId();
		condition.put("${code.idField}",${code.idField});
		${code.daoName?uncap_first}.insert(condition);
		</#if>
		addItems(${code.idField},condition);
	<#list columns as mData><#if mData.type==10||mData.type==12>
		insertAttachment(condition.get("${mData.javaName}"),${code.idField},"${mData.javaName}");
	</#if></#list>
		return ${code.idField};
	}

	@Override
	@Transactional(readOnly = false)
	public Long updateAll(Map<String, Object> condition) {
		Object ${code.idField}=condition.get("${code.idField}");
		//删除子表数据.
		Map<String,Object> deleteParams=new HashMap<String,Object>();
		<#list children as child>
            <#assign parentCode ><#list child.columns as mData><#if mData.name == child.code.childTableField>${mData.javaName}</#if></#list></#assign>
		deleteParams.put("${parentCode}",${code.idField});
		//删除${child.code.tableRemark}
		${child.code.daoName?uncap_first}.<#if child.code.deleteMode==1>deleteByConditionPhysical<#else>deleteByConditionLogic</#if>(deleteParams);
		deleteParams.clear();
		</#list>
		<#list children as child>
			<#list child.columns as mData><#if mData.type==10||mData.type==12>
		attachmentDao.deleteAttachmentByPid("${child.code.tableName}_${mData.javaName}",CommonUtil.valueOf(${code.idField}));
			</#if></#list>
		</#list>
		addItems(${code.idField},condition);
		String id=CommonUtil.valueOf(${code.idField});
	<#list columns as mData><#if mData.type==10||mData.type==12>
		attachmentDao.deleteAttachment("${code.tableName}_${mData.javaName}",id);
	</#if>
	</#list>
<#list columns as mData><#if mData.type==10||mData.type==12>
		insertAttachment(condition.get("${mData.javaName}"),id,"${mData.javaName}");
</#if></#list>
		return getDao().updateAll(condition);
	}
	<#if code.deleteMode==0||code.deleteMode==1>
	@Transactional(readOnly = false)
	public Long deleteByIdPhysical(String id) {
		//删除子表数据.
		Map<String,Object> deleteParams=new HashMap<String,Object>();
<#list children as child>
    <#assign parentCode ><#list  child.columns as mData><#if mData.name == child.code.childTableField>${mData.javaName}</#if></#list></#assign>
		deleteParams.put("${parentCode}",id);
		//删除${child.code.tableRemark}
		${child.code.daoName?uncap_first}.<#if child.code.deleteMode==1>deleteByConditionPhysical<#else>deleteByConditionLogic</#if>(deleteParams);
		deleteParams.clear();
</#list>
		<#list columns as mData><#if mData.type==10||mData.type==12>
		attachmentDao.deleteAttachment("${code.tableName}_${mData.javaName}",id);
		</#if>
		</#list>
		return super.deleteByIdPhysical(id);
	}
	</#if>
	<#if code.deleteMode==0||code.deleteMode==2>
	@Transactional(readOnly = false)
	public Long deleteByIdLogic(String id) {
		//删除子表数据.
		Map<String,Object> deleteParams=new HashMap<String,Object>();
<#list children as child>
    <#assign parentCode ><#list  child.columns as mData><#if mData.name == child.code.childTableField>${mData.javaName}</#if></#list></#assign>
		deleteParams.put("${parentCode}",id);
		//删除${child.code.tableRemark}
		${child.code.daoName?uncap_first}.<#if child.code.deleteMode==1>deleteByConditionPhysical<#else>deleteByConditionLogic</#if>(deleteParams);
		deleteParams.clear();
</#list>
		<#list columns as mData><#if mData.type==10||mData.type==12>
		attachmentDao.deleteAttachment("${code.tableName}_${mData.javaName}",id);
		</#if>
		</#list>
		return super.deleteByIdLogic(id);
	}
	</#if>

<#list children as child>
	<#assign has=false/>
	<#list child.columns as mData><#if  mData.type==10||mData.type==12><#assign has=true/>
	</#if></#list>
	<#if has &&(child.code.moduleType==0||child.code.moduleType==3)>
	/**
     *
	 * 去除${child.code.tableRemark}的重复数据，并且重新组装附件
     * @param datas
	 *				需要去重的数据
     * @return 去重后的数据
     */
    private List<Map<String,Object>> filter${child.code.moduleName?cap_first}(List<Map<String,Object>> datas){
        Set<String> ids=new HashSet<String>();
        List<Map<String,Object>> result=new ArrayList<Map<String,Object>>();
        for(Map<String,Object> data:datas){
            if(ids.add(CommonUtil.valueOf(data.get("${child.code.idField}")))){
                result.add(data);
            }
        }
        //开始比对子数据
        for(Map<String,Object> data:result){
	<#list child.columns as column>
		<#if column.type==10||column.type==12>
			Set<String> id_${column.javaName}=new HashSet<String>();
            List<String> data_${column.javaName}=new ArrayList<String>();
		</#if>
	</#list>
            String id=CommonUtil.valueOf(data.get("${child.code.idField}"));
            for(Map<String,Object> tmp:datas){
                if(id.equals(CommonUtil.valueOf(tmp.get("${child.code.idField}")))){
                    AttachmentEntity att=(AttachmentEntity)tmp.get("attachment");
	<#list child.columns as column>
		<#if column.type==10||column.type==12>
		    		if(att!=null&&"${child.code.tableName}_${column.javaName}".equals(att.getType())&&id_${column.javaName}.add(CommonUtil.valueOf(att.getId()))){
                        data_${column.javaName}.add(att.getVisitPath());
                    }
		</#if>
	</#list>
                }
            }
	<#list child.columns as column>
		<#if column.type==10||column.type==12>
	    	data.put("${column.javaName}",data_${column.javaName});
		</#if>
	</#list>
        }
        return result;
    }
	</#if>
</#list>
	<#list children as child>
		<#assign has=false/>
		<#list child.columns as mData><#if  mData.type==10||mData.type==12><#assign has=true/>
		</#if></#list>
		<#if has &&(child.code.moduleType==1||child.code.moduleType==2)>
	/**
     *
	 * 去除${child.code.tableRemark}的重复数据，并且重新组装附件
     * @param datas
	 *				需要去重的数据
     * @return 去重后的数据
     */
    private List<${child.code.entityName}> filter${child.code.moduleName?cap_first}(List<${child.code.entityName}> datas){
        Set<String> ids=new HashSet<String>();
        List<${child.code.entityName}> result=new ArrayList<${child.code.entityName}>();
        for(${child.code.entityName} data:datas){
            if(ids.add(CommonUtil.valueOf(data.get${child.code.idField?cap_first}()))){
                result.add(data);
            }
        }
        //开始比对子数据
        for(${child.code.entityName} data:result){
			<#list child.columns as column>
				<#if column.type==10||column.type==12>
	    	Set<String> id_${column.javaName}=new HashSet<String>();
            List<String> data_${column.javaName}=new ArrayList<String>();
				</#if>
			</#list>
            String id=CommonUtil.valueOf(data.get${child.code.idField?cap_first}());
            for(${child.code.entityName} tmp:datas){
                if(id.equals(CommonUtil.valueOf(tmp.get${child.code.idField?cap_first}()))){
                    AttachmentEntity att=tmp.getAttachment();
			<#list child.columns as column>
				<#if column.type==10||column.type==12>
		  			if(att!=null&&"${child.code.tableName}_${column.javaName}".equals(att.getType())&&id_${column.javaName}.add(CommonUtil.valueOf(att.getId()))){
                        data_${column.javaName}.add(att.getVisitPath());
                    }
				</#if>
			</#list>
                }
            }
			<#list child.columns as column>
				<#if column.type==10||column.type==12>
	   		data.set${column.javaName?cap_first}(data_${column.javaName});
				</#if>
			</#list>

        }
        return result;
    }
		</#if>
	</#list>

}