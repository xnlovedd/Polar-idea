package polar.island.core.entity;

import java.io.Serializable;
import java.util.List;

public class TreeEntity implements Serializable {

	private static final long serialVersionUID = 2622248783118979948L;
	private String id;
	private String parentId;
	private String text;
	private String value;
	private List<TreeEntity> children;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
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

	public List<TreeEntity> getChildren() {
		return children;
	}

	public void setChildren(List<TreeEntity> children) {
		this.children = children;
	}
}
