package polar.island.inlay.tree.entity;

import org.apache.ibatis.type.Alias;
import polar.island.core.entity.BasicEntity;
import polar.island.core.validator.TAG;

import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 树结构的实体类。 树结构
 *
 * @author PolarLoves
 *
 */
@Alias(value = "TreeEntity")
public class TreeEntity extends BasicEntity implements Serializable {
	private static final long serialVersionUID = -6204088061581557251L;
	/** 主键编号 **/
	@TAG(value = { "updateAllById", "updateField" })
	@NotNull(message = "编号不能为空")
	private Long id;
	/** 组编号 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "组编号不能为空")
	private String groupId;
	/** 组名 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "组名不能为空")
	private String groupName;
	/** 文本内容 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "文本内容不能为空")
	private String text;
	/** 值 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "值不能为空")
	private String value;
	/** 别名 **/
	private String textAlias;
	/** 编号 **/
	private String textId;
	/** 父级编号 **/
	private String parentId;
	/** 类型 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "类型不能为空")
	private Integer type;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
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

	public String getTextAlias() {
		return textAlias;
	}

	public void setTextAlias(String textAlias) {
		this.textAlias = textAlias;
	}

	public String getTextId() {
		return textId;
	}

	public void setTextId(String textId) {
		this.textId = textId;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
}