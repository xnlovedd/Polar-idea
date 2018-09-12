package polar.island.inlay.dict.entity;

import org.apache.ibatis.type.Alias;
import polar.island.core.entity.BasicEntity;
import polar.island.core.validator.TAG;

import javax.validation.constraints.NotNull;

/**
 * 字典的实体类。 字典数据
 *
 * @author PolarLoves
 *
 */
@Alias(value = "DictEntity")
public class DictEntity extends BasicEntity {
	private static final long serialVersionUID = -3021051445418572480L;
	/** 主键编号 **/
	@TAG(value = { "updateAllById", "updateField" })
	@NotNull(message = "编号不能为空")
	private Long id;
	/** 组名 **/
	private String groupName;
	/** 组编号 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "所属组不能为空")
	private String groupId;
	/** 文本内容 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "文本内容不能为空")
	private String text;
	/** 值 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "值不能为空")
	private String value;
	/** 备注 **/
	private String remark;
	/** 排序号 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "排序号不能为空")
	private Long orderNum;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Long getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(Long orderNum) {
		this.orderNum = orderNum;
	}
}