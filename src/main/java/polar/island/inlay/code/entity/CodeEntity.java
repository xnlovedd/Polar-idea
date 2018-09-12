package polar.island.inlay.code.entity;

import org.apache.ibatis.type.Alias;
import polar.island.core.entity.BasicEntity;
import polar.island.core.validator.TAG;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 表单的实体类。
 * 
 * @author N
 *
 */
@Alias(value = "CodeEntity")
public class CodeEntity extends BasicEntity {
	private static final long serialVersionUID = -351209622062839412L;
	@TAG(value = { "updateAllById", "updateField" })
	@NotNull(message = "数据编号不能为空")
	private Long id;
	/** 表名 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "表名不能为空")
	private String tableName;
	/** 表中文名 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "表中文名不能为空")
	private String tableRemark;
	/** 删除模式，0-全部，1-仅物理删除，2-仅逻辑删除。 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "删除模式不能为空")
	private Integer deleteMode;
	/** 主键名称 **/
	@NotNull(message = "主键名称不能为空")
	@TAG(value = { "updateAllById" })
	private String idField;
	/** 主键类型，0-long,1-UUID **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "主键类型不能为空")
	private Integer idType;
	/** 有效性字段名称 **/
	private String effectivenessField;
	/** 有效值 **/
	private String effectivenessValue;
	/** 无效值 **/
	private String unEffectivenessValue;
	/** 有效性字段名称(0-字符串，1-数值) **/
	private Integer effectivenessType;
	/** 包名 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "包名不能为空")
	private String packageName;
	/** 模块名称 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "模块名称不能为空")
	private String moduleName;



	/** 模块中文名称 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "模块注释不能为空")
	private String moduleRemark;
	/** 作者 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "作者不能为空")
	private String author;
	/** 校验方式,0-layui,1-bootstrapTable **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "校验方式不能为空")
	private Integer validateType;
	/** 模板方式,0-全使用Map,1-全使用实体类,2-列表实体，详情/单个Map,3-列表Map，详情/单个实体 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "模板类型不能为空")
	private Integer moduleType;

	/** 表单类型,0-单表，1-树结构，2-父表，3-子表 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "表单类型不能为空")
	private Integer tableType;

	/** 树结构中父编号字段 **/
	private String parentField;
	/**  树结构中子编号字段 **/
	private String childField;
	/**  树结构中表中，名称字段 **/
	private String nameField;
	/**  树结构中表中，值字段 **/
	private String valueField;

	/**  父子表中，子表指向的表 **/
	private String parentTableId;
	/**  父子表中，子表中保存父表外键的字段 **/
	private String childTableField;


	// 以下为controller配置

	/** 访问的路径 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "web端访问路径不能为空")
	private String controllerWebPath;
	/** 访问的路径 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "json端访问路径不能为空")
	private String controllerJsonPath;
	/** 网页的类名 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "web端控制器类名不能为空")
	private String controllerWebName;
	/** 网页的标签 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "web端控制器标签不能为空")
	private String controllerWebTag;
	/** Json格式的标签，默认为空 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "json端控制器标签不能为空")
	private String controllerJsonTag;
	/** Json格式的类名 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "json端控制器类名不能为空")
	private String controllerJsonName;

	// 以下为Service配置
	/** 服务实现类名称 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "服务端实现类类名不能为空")
	private String serviceImplName;
	/** 服务类名称 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "服务端类名不能为空")
	private String serviceName;
	/** 服务类标签 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "服务端标签不能为空")
	private String serviceTag;

	// 以下为Dao配置
	/** dao的名称 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "dao层类名不能为空")
	private String daoName;
	/** dao的标签 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "dao层标签不能为空")
	private String daoTag;
	/** 文件夹名称 **/
	private String mapperFloderName;
	/** mapper文件名称 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "mapper文件名不能为空")
	private String mapperFileName;
	@TAG(value = { "updateAllById" })
	@NotNull(message = "实体类别名不能为空")
	private String entityAlias;
	@TAG(value = { "updateAllById" })
	@NotNull(message = "实体类名不能为空")
	private String entityName;
	/** JSP页面列表名称 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "列表页名称不能为空")
	private String jspListName;
	/** JSP页面编辑页面名称 **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "编辑页名称不能为空")
	private String jspEditName;
	/** 列表模板类型：0-layui-table,1-bootstrap-table **/
	@TAG(value = { "updateAllById" })
	@NotNull(message = "列表模板不能为空")
	private Integer listModule;
	/** 创建时间 **/
	private Date createDate;
	/** 修改时间 **/
	private Date updateDate;

	public Integer getListModule() {
		return listModule;
	}

	public void setListModule(Integer listModule) {
		this.listModule = listModule;
	}

	public Integer getValidateType() {
		return validateType;
	}

	public void setValidateType(Integer validateType) {
		this.validateType = validateType;
	}

	public Integer getModuleType() {
		return moduleType;
	}

	public void setModuleType(Integer moduleType) {
		this.moduleType = moduleType;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public Integer getEffectivenessType() {
		return effectivenessType;
	}

	public void setEffectivenessType(Integer effectivenessType) {
		this.effectivenessType = effectivenessType;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Integer getIdType() {
		return idType;
	}

	public void setIdType(Integer idType) {
		this.idType = idType;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getMapperFloderName() {
		return mapperFloderName;
	}

	public void setMapperFloderName(String mapperFloderName) {
		this.mapperFloderName = mapperFloderName;
	}

	public String getMapperFileName() {
		return mapperFileName;
	}

	public void setMapperFileName(String mapperFileName) {
		this.mapperFileName = mapperFileName;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getTableRemark() {
		return tableRemark;
	}

	public void setTableRemark(String tableRemark) {
		this.tableRemark = tableRemark;
	}

	public Integer getDeleteMode() {
		return deleteMode;
	}

	public void setDeleteMode(Integer deleteMode) {
		this.deleteMode = deleteMode;
	}

	public String getIdField() {
		return idField;
	}

	public void setIdField(String idField) {
		this.idField = idField;
	}

	public String getEffectivenessField() {
		return effectivenessField;
	}

	public void setEffectivenessField(String effectivenessField) {
		this.effectivenessField = effectivenessField;
	}

	public String getEffectivenessValue() {
		return effectivenessValue;
	}

	public void setEffectivenessValue(String effectivenessValue) {
		this.effectivenessValue = effectivenessValue;
	}

	public String getUnEffectivenessValue() {
		return unEffectivenessValue;
	}

	public void setUnEffectivenessValue(String unEffectivenessValue) {
		this.unEffectivenessValue = unEffectivenessValue;
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public String getModuleName() {
		return moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}

	public String getModuleRemark() {
		return moduleRemark;
	}

	public void setModuleRemark(String moduleRemark) {
		this.moduleRemark = moduleRemark;
	}

	public String getControllerWebName() {
		return controllerWebName;
	}

	public void setControllerWebName(String controllerWebName) {
		this.controllerWebName = controllerWebName;
	}

	public String getControllerWebTag() {
		return controllerWebTag;
	}

	public void setControllerWebTag(String controllerWebTag) {
		this.controllerWebTag = controllerWebTag;
	}

	public String getControllerJsonTag() {
		return controllerJsonTag;
	}

	public void setControllerJsonTag(String controllerJsonTag) {
		this.controllerJsonTag = controllerJsonTag;
	}

	public String getControllerJsonName() {
		return controllerJsonName;
	}

	public void setControllerJsonName(String controllerJsonName) {
		this.controllerJsonName = controllerJsonName;
	}

	public String getServiceImplName() {
		return serviceImplName;
	}

	public void setServiceImplName(String serviceImplName) {
		this.serviceImplName = serviceImplName;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public String getServiceTag() {
		return serviceTag;
	}

	public void setServiceTag(String serviceTag) {
		this.serviceTag = serviceTag;
	}

	public String getDaoName() {
		return daoName;
	}

	public void setDaoName(String daoName) {
		this.daoName = daoName;
	}

	public String getDaoTag() {
		return daoTag;
	}

	public void setDaoTag(String daoTag) {
		this.daoTag = daoTag;
	}

	public String getJspListName() {
		return jspListName;
	}

	public void setJspListName(String jspListName) {
		this.jspListName = jspListName;
	}

	public String getJspEditName() {
		return jspEditName;
	}

	public void setJspEditName(String jspEditName) {
		this.jspEditName = jspEditName;
	}

	public String getControllerWebPath() {
		return controllerWebPath;
	}

	public void setControllerWebPath(String controllerWebPath) {
		this.controllerWebPath = controllerWebPath;
	}

	public String getControllerJsonPath() {
		return controllerJsonPath;
	}

	public void setControllerJsonPath(String controllerJsonPath) {
		this.controllerJsonPath = controllerJsonPath;
	}

	public String getEntityAlias() {
		return entityAlias;
	}

	public void setEntityAlias(String entityAlias) {
		this.entityAlias = entityAlias;
	}

	public String getEntityName() {
		return entityName;
	}

	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}

	public Integer getTableType() {
		return tableType;
	}

	public String getParentField() {
		return parentField;
	}

	public void setParentField(String parentField) {
		this.parentField = parentField;
	}

	public String getChildField() {
		return childField;
	}

	public void setChildField(String childField) {
		this.childField = childField;
	}

	public String getNameField() {
		return nameField;
	}

	public void setNameField(String nameField) {
		this.nameField = nameField;
	}

	public String getValueField() {
		return valueField;
	}

	public void setValueField(String valueField) {
		this.valueField = valueField;
	}

	public void setTableType(Integer tableType) {
		this.tableType = tableType;
	}

	public String getParentTableId() {
		return parentTableId;
	}

	public void setParentTableId(String parentTableId) {
		this.parentTableId = parentTableId;
	}

	public String getChildTableField() {
		return childTableField;
	}

	public void setChildTableField(String childTableField) {
		this.childTableField = childTableField;
	}

	@Override
	public String toString() {
		return "CodeEntity [id=" + id + ", tableName=" + tableName + ", tableRemark=" + tableRemark + ", deleteMode="
				+ deleteMode + ", idField=" + idField + ", idType=" + idType + ", effectivenessField="
				+ effectivenessField + ", effectivenessValue=" + effectivenessValue + ", unEffectivenessValue="
				+ unEffectivenessValue + ", effectivenessType=" + effectivenessType + ", packageName=" + packageName
				+ ", moduleName=" + moduleName + ", moduleRemark=" + moduleRemark + ", author=" + author
				+ ", validateType=" + validateType + ", moduleType=" + moduleType + ", controllerWebPath="
				+ controllerWebPath + ", controllerJsonPath=" + controllerJsonPath + ", controllerWebName="
				+ controllerWebName + ", controllerWebTag=" + controllerWebTag + ", controllerJsonTag="
				+ controllerJsonTag + ", controllerJsonName=" + controllerJsonName + ", serviceImplName="
				+ serviceImplName + ", serviceName=" + serviceName + ", serviceTag=" + serviceTag + ", daoName="
				+ daoName + ", daoTag=" + daoTag + ", mapperFloderName=" + mapperFloderName + ", mapperFileName="
				+ mapperFileName + ", entityAlias=" + entityAlias + ", entityName=" + entityName + ", jspListName="
				+ jspListName + ", jspEditName=" + jspEditName + ", listModule=" + listModule + ", createDate="
				+ createDate + ", updateDate=" + updateDate + "]";
	}

}
