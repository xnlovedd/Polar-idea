package polar.island.inlay.menuModel.entity;

import org.apache.ibatis.type.Alias;
import polar.island.core.entity.BasicEntity;
import polar.island.core.validator.TAG;

import javax.validation.constraints.NotNull;

/**
 * 菜单模板的实体类
 *
 * @author PolarLoves
 *
 */
@Alias(value = "MenuModelEntity")
public class MenuModelEntity extends BasicEntity {
	private static final long serialVersionUID = 5097036240058573177L;
	/** 主键编号 **/
	@TAG(value = { "updateAllById", "updateField" })
	@NotNull(message = "编号不能为空")
	private Long id;
	/** 模板名称 **/
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "模板名称不能为空")
	private String name;
	/** 模板描述 **/
	private String info;
	/** 默认模板（0-否，1-是） **/
	private Long defaultMenu;

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

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public Long getDefaultMenu() {
		return defaultMenu;
	}

	public void setDefaultMenu(Long defaultMenu) {
		this.defaultMenu = defaultMenu;
	}
}