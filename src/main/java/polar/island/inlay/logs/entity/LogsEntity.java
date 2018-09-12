package polar.island.inlay.logs.entity;

import org.apache.ibatis.type.Alias;
import polar.island.core.entity.BasicEntity;
import polar.island.core.validator.TAG;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 日志记录表的实体类。 用来记录通用产出的错误信息。
 *
 * @author PolarLoves
 *
 */
@Alias(value = "LogsEntity")
public class LogsEntity extends BasicEntity {
	private static final long serialVersionUID = -4611262567428426961L;
	/** 主键编号 **/
	@TAG(value = { "updateAllById", "updateField" })
	@NotNull(message = "编号不能为空")
	private Long id;
	/** 当前登录用户 **/
	private String userId;
	/** 创建时间 **/
	private Date createTime;
	/** 接口名称 **/
	private String interfaceName;
	/** 错误信息 **/
	private String message;
	/** 引起的原因 **/
	private String caseBy;
	/** 创建时间毫秒 **/
	private Long createTimeMillions;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getInterfaceName() {
		return interfaceName;
	}

	public void setInterfaceName(String interfaceName) {
		this.interfaceName = interfaceName;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getCaseBy() {
		return caseBy;
	}

	public void setCaseBy(String caseBy) {
		this.caseBy = caseBy;
	}

	public Long getCreateTimeMillions() {
		return createTimeMillions;
	}

	public void setCreateTimeMillions(Long createTimeMillions) {
		this.createTimeMillions = createTimeMillions;
	}
}