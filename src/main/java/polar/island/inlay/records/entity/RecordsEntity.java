package polar.island.inlay.records.entity;

import org.apache.ibatis.type.Alias;
import polar.island.core.entity.BasicEntity;

import java.util.Date;

/**
 * 访问记录的实体类。 访问记录
 *
 * @author PolarLoves
 *
 */
@Alias(value = "RecordsEntity")
public class RecordsEntity extends BasicEntity {
	private static final long serialVersionUID = -6833557153208268881L;
	/** 主键编号 **/
	private Long id;
	/** 页面名称 **/
	private String pageName;
	/** 访问路径 **/
	private String vistUrl;
	/** 访问平台 **/
	private Integer vistPlatform;
	/** 访问时间 **/
	private Date vistDate;
	/** 访问人 **/
	private String vistPeople;
	/** 访问Ip **/
	private String vistIp;
	private String vistSearchDate;

	public String getVistSearchDate() {
		return vistSearchDate;
	}

	public void setVistSearchDate(String vistSearchDate) {
		this.vistSearchDate = vistSearchDate;
	}

	public String getVistIp() {
		return vistIp;
	}

	public void setVistIp(String vistIp) {
		this.vistIp = vistIp;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getPageName() {
		return pageName;
	}

	public void setPageName(String pageName) {
		this.pageName = pageName;
	}

	public String getVistUrl() {
		return vistUrl;
	}

	public void setVistUrl(String vistUrl) {
		this.vistUrl = vistUrl;
	}

	public Integer getVistPlatform() {
		return vistPlatform;
	}

	public void setVistPlatform(Integer vistPlatform) {
		this.vistPlatform = vistPlatform;
	}

	public Date getVistDate() {
		return vistDate;
	}

	public void setVistDate(Date vistDate) {
		this.vistDate = vistDate;
	}

	public String getVistPeople() {
		return vistPeople;
	}

	public void setVistPeople(String vistPeople) {
		this.vistPeople = vistPeople;
	}
}