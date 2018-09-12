package polar.island.core.entity;

import polar.island.core.json.GsonIgnore;

import java.io.Serializable;

/**
 * 基础实体类。
 * 
 * @author PolarLoves
 *
 */
public class BasicEntity implements Serializable {
	@GsonIgnore
	/** 当前页码 **/
	private Integer page = 1;
	/** 每页条目 **/
	@GsonIgnore
	private Integer rows = 10;
	/** 排序名称 **/
	@GsonIgnore
	private String sort;
	/** 排序名称 **/
	@GsonIgnore
	private String fieldName;
	/** 排序方式 **/
	@GsonIgnore
	private String order="ASC";

	// 获取MySql开始页码
	public Integer getPageStartNumber() {
		return (page - 1) * rows;
	}

	// 获取MySql偏移页面
	public Integer getPageOffsetNumber() {
		return rows;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	/**
	 * 如果字段名称和实体类中不一致，则需要重写此方法
	 * 
	 * @return 排序的字段名称
	 */
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		if(order!=null&&order.equalsIgnoreCase("desc")){
			this.order ="DESC";
			return;
		}
		this.order = "ASC";
	}

}
