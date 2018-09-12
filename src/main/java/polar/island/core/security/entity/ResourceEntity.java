package polar.island.core.security.entity;

import org.apache.ibatis.type.Alias;
import polar.island.core.entity.BasicEntity;
import polar.island.core.validator.TAG;

import javax.validation.constraints.NotNull;

/**
 * 资源的实体类， 资源表信息
 *
 * @author PolarLoves
 *
 */
@Alias(value = "ResourceEntity")
public class ResourceEntity extends BasicEntity {
	private static final long serialVersionUID = 6809315447046587871L;
	/** 主键编号 **/
	@TAG(value = { "updateAllById", "updateField" })
	@NotNull(message = "编号不能为空")
	private Long id;
	/** 名称 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "名称不能为空")
	private String name;
	/** 中文名称 **/
	private String text;
	/** 访问路径 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "访问路径不能为空")
	private String path;
	/** 排序号 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "排序号不能为空")
	private Long orderNum;
	/** 描述 **/
	private String info;

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

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Long getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(Long orderNum) {
		this.orderNum = orderNum;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}
}