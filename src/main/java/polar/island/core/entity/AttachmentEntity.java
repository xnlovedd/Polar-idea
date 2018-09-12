package polar.island.core.entity;
import org.apache.ibatis.type.Alias;
import polar.island.core.validator.TAG;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 *  附件的实体类。
 *
 * @author  PolarLoves
 *
 */
@Alias(value = "AttachmentEntity")
public class AttachmentEntity extends BasicEntity {
	/** 主键编号	**/
	@TAG(value = { "updateAllById" , "updateField" })
	@NotNull(message = "编号不能为空")
	private Long id;
	/** 访问路径 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "访问路径不能为空")
	private String visitPath;
	/** 外键编号 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "外键编号不能为空")
	private String attachmentId;
	/** 文件类型，一般以表名+字段名 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "文件类型不能为空")
	private String type;
	private String pid;
	private Date createDate;
	private Long createDateMillions;

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public Long getId(){
		return id;
	}
	
	public void setId(Long id){
		this.id = id;
	}
	
	public String getVisitPath(){
		return visitPath;
	}
	
	public void setVisitPath(String visitPath){
		this.visitPath = visitPath;
	}
	
	public String getAttachmentId(){
		return attachmentId;
	}
	
	public void setAttachmentId(String attachmentId){
		this.attachmentId = attachmentId;
	}
	
	public String getType(){
		return type;
	}
	
	public void setType(String type){
		this.type = type;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Long getCreateDateMillions() {
		return createDateMillions;
	}

	public void setCreateDateMillions(Long createDateMillions) {
		this.createDateMillions = createDateMillions;
	}
}