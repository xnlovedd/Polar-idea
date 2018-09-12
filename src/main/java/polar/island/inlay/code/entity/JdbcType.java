package polar.island.inlay.code.entity;

/**
 * 数据库类型
 * 
 * @author PolarLoves
 *
 */
public class JdbcType {
	/** 字段名称 **/
	private String name;
	/** 字段注释 **/
	private String commonts;
	/** 是否必填 **/
	private Integer required;
	/** 字段类型 **/
	private String type;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCommonts() {
		return commonts;
	}

	public void setCommonts(String commonts) {
		this.commonts = commonts;
	}

	public Integer getRequired() {
		return required;
	}

	public void setRequired(Integer required) {
		this.required = required;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
