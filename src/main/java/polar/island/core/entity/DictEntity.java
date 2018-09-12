package polar.island.core.entity;

import java.io.Serializable;

/**
 * 字典通用的实体类
 * 
 * @author PolarLoves
 *
 */
public class DictEntity implements Serializable {
	private static final long serialVersionUID = -3522206470889609762L;
	/** 文本内容 **/
	private String text;
	/** 具体的值 **/
	private String value;

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

	public DictEntity(String text, String value) {
		super();
		this.text = text;
		this.value = value;
	}

	public DictEntity() {
		super();
	}

}
