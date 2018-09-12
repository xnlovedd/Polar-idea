package polar.island.inlay.role.entity;

import org.apache.ibatis.type.Alias;
import polar.island.core.entity.BasicEntity;
import polar.island.core.validator.TAG;

import javax.validation.constraints.NotNull;

/**
 * 角色的实体类。 角色管理
 *
 * @author PolarLoves
 *
 */
@Alias(value = "RoleEntity")
public class RoleEntity extends BasicEntity {
	private static final long serialVersionUID = -1873840638467309305L;
	/** 主键编号 **/
	@TAG(value = { "updateAllById", "updateField" })
	@NotNull(message = "编号不能为空")
	private Long id;
	/** 父类id **/
	private Long parentId;
	/** 角色名称 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "角色名称不能为空")
	private String name;
	/** 角色中文名称 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "角色中文名称不能为空")
	private String text;
	/** 角色描述 **/
	private String info;
	/** 排序 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "排序不能为空")
	private Long orderNum;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public Long getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(Long orderNum) {
		this.orderNum = orderNum;
	}
}