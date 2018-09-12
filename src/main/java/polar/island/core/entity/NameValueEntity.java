package polar.island.core.entity;

import java.io.Serializable;

public class NameValueEntity implements Serializable{

	private static final long serialVersionUID = -2526109888337059121L;
	private String name;
	private String value;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
}
