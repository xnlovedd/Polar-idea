package polar.island.inlay.menu.entity;

import org.apache.ibatis.type.Alias;
import polar.island.core.entity.BasicEntity;
import polar.island.core.util.GsonUtil;
import polar.island.core.validator.TAG;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.List;

/**
 * 菜单的实体类。 菜单
 *
 * @author PolarLoves
 *
 */
@Alias(value = "MenuEntity")
public class MenuEntity extends BasicEntity implements Serializable {
	private static final long serialVersionUID = 43942967956196188L;
	// 主键编号
	@TAG(value = { "updateAllById", "updateField" })
	@NotNull(message = "编号不能为空")
	private Long id;
	// 名称
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "名称不能为空")
	private String name;
	// 图标
	private String icon;
	// 访问路径
	private String path;
	// 排序号
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "排序号不能为空")
	private Long orderNum;
	// 父级编号
	private Long parentId;
	// 是否默认展开
	private Integer defaultOpen;
	private List<MenuEntity> children;

	public List<MenuEntity> getChildren() {
		return children;
	}

	public void setChildren(List<MenuEntity> children) {
		this.children = children;
	}

	public Integer getDefaultOpen() {
		return defaultOpen;
	}

	public void setDefaultOpen(Integer defaultOpen) {
		this.defaultOpen = defaultOpen;
	}

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

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
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

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	@Override
	public String toString() {
		return GsonUtil.toJson(this);
	}
}