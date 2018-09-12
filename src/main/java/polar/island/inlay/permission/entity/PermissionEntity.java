package polar.island.inlay.permission.entity;

import org.apache.ibatis.type.Alias;
import polar.island.core.entity.BasicEntity;
import polar.island.core.validator.TAG;

import javax.validation.constraints.NotNull;

/**
 * 权限的实体类。
 *
 * @author PolarLoves
 *
 */
@Alias(value = "PermissionEntity")
public class PermissionEntity extends BasicEntity {
	/** 序列化编号 **/
	private static final long serialVersionUID = -7133541181443223028L;
	/** 注解编号 **/
	@TAG(value = { "updateAllById", "updateField" })
	@NotNull(message = "编号不能为空")
	private Long id;
	/** 权限名称  **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "权限名称不能为空")
	private String name;
	/** 中文名称  **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "中文名称不能为空")
	private String text;
	/** 权限描述  **/
	private String info;
	/** 排序号  **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "排序号不能为空")
	private Long orderNum;
	/** 父类编号  **/
	private Long parentId;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}
}