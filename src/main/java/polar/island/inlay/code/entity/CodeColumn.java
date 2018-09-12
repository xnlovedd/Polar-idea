package polar.island.inlay.code.entity;

import org.apache.ibatis.type.Alias;
import polar.island.core.entity.BasicEntity;

import javax.validation.constraints.NotNull;

@Alias(value = "CodeColumn")
public class CodeColumn extends BasicEntity {
	private static final long serialVersionUID = -6947473226590764871L;
	private Long id;
	/** 字段名称 **/
	@NotNull(message = "字段名称不能为空")
	private String name;
	/** 字段类型，0-单行文本，1-文本域，2-整数，3-浮点数，4-日期，5-富文本编辑器，6-下拉列表，7-树形结构,8-隐藏,9-大整数，10-图片,11-省市区选择,12-文件 **/
	@NotNull(message = "字段类型不能为空")
	/** 0:=,1:like,2:<,3:>4:<=,5:>=**/
	private Integer type;
	@NotNull(message = "匹配方式不能为空")
	private Integer matchStyle;
	/** 组名，下拉或者树形菜单时有效。 **/
	@NotNull(message = "扩展参数不能为空")
	private String groupName;
	/** 注释,在实体类中写入 **/
	@NotNull(message = "注释不能为空")
	private String commont;
	/** java列名称 **/
	@NotNull(message = "java列名称不能为空")
	private String javaName;
	/** 备注 **/
	@NotNull(message = "字段中文名不能为空")
	private String remark;
	/** 是否作为查询条件，0-否，1-是 **/
	@NotNull(message = "是否作为查询条件不能为空")
	private Integer search;
	/** 是否列表显示，0-否，1-是 **/
	@NotNull(message = "是否列表返回不能为空")
	private Integer listReturn;
	/** 是否列表显示，0-否，1-是 **/
	@NotNull(message = "是否列表显示不能为空")
	private Integer listShown;
	/** 是否表内编辑，0-否，1-是 **/
	@NotNull(message = "是否表内编辑不能为空")
	private Integer innerEdit;
	// 以下为校验条件
	/** 是否可为空，0-否，1-是 **/
	@NotNull(message = "是否可为空不能为空")
	private Integer required;
	/** 表编号 **/
	private Long tableId;

	/** 是否可排序，0-否，1-是 **/
	@NotNull(message = "是否可排序不能为空")
	private Integer orderBy;
	/** 是否为手机号，0-否，1-是 **/
	@NotNull(message = "是否为手机号不能为空")
	private Integer phone;
	/** 是否为邮箱，0-否，1-是 **/
	@NotNull(message = "是否为邮箱不能为空")
	private Integer email;
	/** 是否为身份证号，0-否，1-是 **/
	@NotNull(message = "是否为身份证号不能为空")
	private Integer identity;
	/** 排序编号 **/
	private Integer orderNum;


	public Integer getListReturn() {
		return listReturn;
	}

	public void setListReturn(Integer listReturn) {
		this.listReturn = listReturn;
	}

	public Integer getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}

	public String getCommont() {
		return commont;
	}

	public void setCommont(String commont) {
		this.commont = commont;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getTableId() {
		return tableId;
	}

	public void setTableId(Long tableId) {
		this.tableId = tableId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getJavaName() {
		return javaName;
	}

	public void setJavaName(String javaName) {
		this.javaName = javaName;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getSearch() {
		return search;
	}

	public void setSearch(Integer search) {
		this.search = search;
	}

	public Integer getListShown() {
		return listShown;
	}

	public void setListShown(Integer listShown) {
		this.listShown = listShown;
	}

	public Integer getInnerEdit() {
		return innerEdit;
	}

	public void setInnerEdit(Integer innerEdit) {
		this.innerEdit = innerEdit;
	}

	public Integer getRequired() {
		return required;
	}

	public void setRequired(Integer required) {
		this.required = required;
	}

	public Integer getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(Integer orderBy) {
		this.orderBy = orderBy;
	}

	public Integer getPhone() {
		return phone;
	}

	public void setPhone(Integer phone) {
		this.phone = phone;
	}

	public Integer getEmail() {
		return email;
	}

	public void setEmail(Integer email) {
		this.email = email;
	}

	public Integer getIdentity() {
		return identity;
	}

	public void setIdentity(Integer identity) {
		this.identity = identity;
	}


	public Integer getMatchStyle() {
		return matchStyle;
	}

	public void setMatchStyle(Integer matchStyle) {
		this.matchStyle = matchStyle;
	}
}
