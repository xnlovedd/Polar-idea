package ${code.packageName}.${code.moduleName}.entity;
import javax.validation.constraints.*;
import org.apache.ibatis.type.Alias;
import polar.island.core.config.Constants;
import polar.island.core.entity.BasicEntity;
import polar.island.core.validator.TAG;
import java.util.List;
import polar.island.core.entity.AttachmentEntity;
import polar.island.core.json.GsonIgnore;
import org.hibernate.validator.constraints.Length;
<#assign sql=false/>
<#list columns as mData>
		<#if mData.type==4>
		<#assign sql=true/>
		</#if>
</#list>
<#if sql>import java.util.Date;</#if>
/**
 *  ${code.tableRemark}的实体类,${parent.code.tableRemark}的子表
 *
 * @author  ${code.author}
 *
 */
@Alias(value = "${code.entityAlias}")
public class ${code.entityName} extends BasicEntity {
	@GsonIgnore
	private AttachmentEntity attachment;
	/** 主键编号	**/
	@TAG(value = { "updateAllById" , "updateField" })
	@NotNull(message = "编号不能为空")
	private <#if code.idType==0>Long<#else>String</#if> ${code.idField};
	<#if code.deleteMode!=1>
	/** 有效性字段，有效值：${code.effectivenessValue}，无效值：${code.unEffectivenessValue}。 **/
	private <#if code.effectivenessType==1>Integer<#else>String</#if> ${code.effectivenessField};
	</#if>
<#list columns as mData>
    <#if mData.required==1>
	@TAG(value = { "updateAllById", "add" })
	@NotNull(message = "${mData.remark}不能为空")
    </#if>
    <#if mData.type==10||mData.type==12>
	private List<String> ${mData.javaName};
    </#if>
</#list>
	<#list columns as mData>
	<#if mData.type!=10&&mData.type!=12&&mData.type!=13&&mData.type!=14>
	/** ${mData.commont} **/
	<#assign has=false/>
	<#if mData.required==1||mData.phone==1||mData.email==1||mData.identity==1||mData.group.maxLength??||mData.group.minLength??><#assign has=true/></#if>
	<#if has>@TAG(value = { "updateAllById", "add" })
	<#if mData.required==1>@NotNull(message = "${mData.remark}不能为空")</#if><#if mData.email==1>@Pattern(message = "${mData.remark}必须为邮箱格式",regexp = Constants.REG_EMAIL)</#if><#if mData.phone==1>@Pattern(message = "${mData.remark}必须为手机号",regexp = Constants.REG_PHONE)</#if><#if mData.identity==1>@Pattern(message = "${mData.remark}格式必须为身份证号",regexp = Constants.REG_IDCARD)</#if><#if mData.group.minLength??||mData.group.maxLength??>@Length(message = "${mData.remark}长度不正确"<#if mData.group.minLength??>,min=${mData.group.minLength}</#if><#if mData.group.maxLength??>,max=${mData.group.maxLength}</#if>)</#if>
	</#if>
	<#if mData.type==2>
	private Integer ${mData.javaName};
	<#elseif mData.type==3>
	private Double ${mData.javaName};
	<#elseif mData.type==4>
	private Date ${mData.javaName};
	<#elseif mData.type==9>
	private Long ${mData.javaName};
	<#else>
	private String ${mData.javaName};
	</#if>
        </#if>
	</#list>
	
	public <#if code.idType==0>Long<#else>String</#if> get${code.idField?cap_first}(){
		return ${code.idField};
	}
	
	public void set${code.idField?cap_first}(<#if code.idType==0>Long<#else>String</#if> ${code.idField}){
		this.${code.idField} = ${code.idField};
	}
	<#if code.deleteMode!=1>
	
	public <#if code.effectivenessType==1>Integer<#else>String</#if> get${code.effectivenessField?cap_first}(){
		return ${code.effectivenessField};
	}
	
	public void set${code.effectivenessField?cap_first}(<#if code.effectivenessType==1>Integer<#else>String</#if> ${code.effectivenessField}){
		this.${code.effectivenessField} = ${code.effectivenessField};
	}
	</#if>
	<#list columns as mData>
        <#if mData.type!=10&&mData.type!=12>
	<#if mData.type==2>
	
	public Integer get${mData.javaName?cap_first}(){
		return ${mData.javaName};
	}
	
	public void set${mData.javaName?cap_first}(Integer ${mData.javaName}){
		this.${mData.javaName} = ${mData.javaName};
	}
	<#elseif mData.type==3>
	
	public Double get${mData.javaName?cap_first}(){
		return ${mData.javaName};
	}
	
	public void set${mData.javaName?cap_first}(Double ${mData.javaName}){
		this.${mData.javaName} = ${mData.javaName};
	}
	<#elseif mData.type==4>
	
	public Date get${mData.javaName?cap_first}(){
		return ${mData.javaName};
	}
	
	public void set${mData.javaName?cap_first}(Date ${mData.javaName}){
		this.${mData.javaName} = ${mData.javaName};
	}
	<#elseif mData.type==9>
	
	public Long get${mData.javaName?cap_first}(){
		return ${mData.javaName};
	}
	
	public void set${mData.javaName?cap_first}(Long ${mData.javaName}){
		this.${mData.javaName} = ${mData.javaName};
	}
	<#else>
	
	public String get${mData.javaName?cap_first}(){
		return ${mData.javaName};
	}
	
	public void set${mData.javaName?cap_first}(String ${mData.javaName}){
		this.${mData.javaName} = ${mData.javaName};
	}
	</#if>
        </#if>
	</#list>
	public AttachmentEntity getAttachment(){
		return this.attachment;
	}

	public void setAttachment(AttachmentEntity attachment){
		this.attachment = attachment;
	}
<#list columns as mData>
    <#if mData.type==10||mData.type==12>
	public void set${mData.javaName?cap_first}(List<String> ${mData.javaName}){
		this.${mData.javaName} = ${mData.javaName};
	}

	public List<String> get${mData.javaName?cap_first}(){
		return this.${mData.javaName};
	}
    </#if>
</#list>
}