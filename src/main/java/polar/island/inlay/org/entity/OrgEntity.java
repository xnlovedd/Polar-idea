package polar.island.inlay.org.entity;
import org.apache.ibatis.type.Alias;
import polar.island.core.config.Constants;
import polar.island.core.entity.BasicEntity;
import polar.island.core.validator.TAG;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

/**
 *  机构的实体类。
 *
 * @author  PolarLoves
 *
 */
@Alias(value = "OrgEntity")
public class OrgEntity extends BasicEntity {
	/** 主键编号	**/
	@TAG(value = { "updateAllById" , "updateField" })
	@NotNull(message = "编号不能为空")
	private Long id;
	/** 机构名称 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "机构名称不能为空")
	private String name;
	/** 上级部门 **/
	private Long parentId;
	/** 机构编码 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "机构编码不能为空")
	private String orgCode;
	/** 机构介绍 **/
	private String orgDescribe;
	/** 联系人 **/
	private String contactPeople;
	/** 联系电话 **/
	@TAG(value = { "updateAllById", "add" })
	@Pattern(message = "联系电话必须为手机号",regexp = Constants.REG_PHONE)
	private String contactPhone;
	/** 联系邮箱 **/
	@TAG(value = { "updateAllById", "add" })
	@Pattern(message = "联系邮箱必须为邮箱格式",regexp = Constants.REG_EMAIL)
	private String contactEmail;

	public Long getId(){
		return id;
	}

	public void setId(Long id){
		this.id = id;
	}

	public String getName(){
		return name;
	}

	public void setName(String name){
		this.name = name;
	}

	public Long getParentId(){
		return parentId;
	}

	public void setParentId(Long parentId){
		this.parentId = parentId;
	}

	public String getOrgCode(){
		return orgCode;
	}

	public void setOrgCode(String orgCode){
		this.orgCode = orgCode;
	}

	public String getOrgDescribe(){
		return orgDescribe;
	}

	public void setOrgDescribe(String orgDescribe){
		this.orgDescribe = orgDescribe;
	}

	public String getContactPeople(){
		return contactPeople;
	}

	public void setContactPeople(String contactPeople){
		this.contactPeople = contactPeople;
	}

	public String getContactPhone(){
		return contactPhone;
	}

	public void setContactPhone(String contactPhone){
		this.contactPhone = contactPhone;
	}

	public String getContactEmail(){
		return contactEmail;
	}

	public void setContactEmail(String contactEmail){
		this.contactEmail = contactEmail;
	}
}