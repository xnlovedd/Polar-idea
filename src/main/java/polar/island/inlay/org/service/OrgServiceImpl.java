package polar.island.inlay.org.service;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import polar.island.core.entity.AttachmentEntity;
import polar.island.core.exception.ValidationException;
import polar.island.core.service.BasicServiceImpl;
import polar.island.core.util.CommonUtil;
import polar.island.database.AttachmentDao;
import polar.island.inlay.org.dao.OrgDao;
import polar.island.inlay.org.entity.OrgEntity;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Transactional(readOnly = true)
@Service(value = "orgService")
public class OrgServiceImpl extends BasicServiceImpl<OrgEntity,OrgEntity,OrgDao> implements OrgService {
	@Resource(name = "orgDao")
	private OrgDao orgDao;
	@Resource(name = "attachmentDao")
    private AttachmentDao attachmentDao;
	@Override
	public OrgDao getDao() {
		return orgDao;
	}
	@Transactional(readOnly = false)
	@Override
	public Object insert(Map<String, Object> condition) {
		Object name=condition.get("orgCode");
		Map<String, Object> condition2=new HashMap<String, Object>();
		condition2.put("orgCode",name);
		Long count=getDao().selectCount(condition2);
		if(count>0){
			throw new ValidationException("部门编号已存在",null);
		}
		Object id=null;
		orgDao.insert(condition);
		id= condition.get("id");
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
				entity.setType("t_polar_org_"+fieldName);
				entity.setVisitPath(param);
				attachmentDao.insert(entity);
			}
		}
    }
	@Transactional(readOnly = true)
	@Override
	public List<OrgEntity> selectAllList(){
		return getDao().selectAllList();
	}
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
	private Long deleteChildrenPhysical(OrgEntity current, List<OrgEntity> entities, Long count) {
		String id=CommonUtil.valueOf(current.getId());
		count = count +  getDao().deleteByIdPhysical(id);
        if (CollectionUtils.isEmpty(entities)) {
			String childId=CommonUtil.valueOf(current.getParentId());
            for (OrgEntity entity : entities) {
				String parentId=CommonUtil.valueOf(entity.getParentId());
                if (childId.equals(parentId)) {
                    count = deleteChildrenPhysical(entity, entities, count);
                }
            }
        }
	    return count;
	}
	@Override
	public OrgEntity selectOneById(String id) {
		OrgEntity result=super.selectOneById(id);
        return result;
    }
	@Override
	public OrgEntity selectOneByCondition(Map<String, Object> condition) {
		OrgEntity result=super.selectOneByCondition(condition);
        return result;
    }
	@Override
	public Long updateAll(Map<String, Object> condition) {
		String id=CommonUtil.valueOf(condition.get("id"));
		return super.updateAll(condition);
	}
}