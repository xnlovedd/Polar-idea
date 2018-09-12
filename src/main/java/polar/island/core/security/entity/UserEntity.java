package polar.island.core.security.entity;

import org.apache.ibatis.type.Alias;
import polar.island.core.entity.BasicEntity;
import polar.island.core.validator.TAG;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.io.Serializable;
import java.util.Date;

/**
 * 用户的实体类。 用户基本信息管理
 *
 * @author PolarLoves
 *
 */
@Alias(value = "userEntity")
public class UserEntity extends BasicEntity implements Serializable {
	private static final long serialVersionUID = -7480139832109967015L;
	/** 主键编号 **/
	@TAG(value = { "updateAllById", "updateField" })
	@NotNull(message = "编号不能为空")
	private Long id;
	/** 有效性字段，有效值：1，无效值：0。 **/
	private Integer state;
	/** 用户名 **/
	@TAG(value = { "add"})
	@NotNull(message = "用户名不能为空")
	private String userName;
	/** 密码 **/
	private String password;
	/** 登陆次数 **/
	private Long logCount;
	/** 头像 **/
	private String headUrl;
	/** 昵称 **/
	private String nickName;
	/** 最后一次登陆的IP **/
	private String logInIp;
	/** 创建日期 **/
	private Date createDate;
	private Date logInDate;
	/** 手机号 **/
	@Pattern(regexp = "/^1\\d{10}$/", message = "手机号格式不正确")
	private String phone;
	/** 邮箱 **/
	@Pattern(regexp = "/(^$)|^([a-zA-Z0-9_\\.\\-])+\\@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$/", message = "邮箱格式不正确")
	private String email;
	private String orgId;

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getLogInDate() {
		return logInDate;
	}

	public void setLogInDate(Date logInDate) {
		this.logInDate = logInDate;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Long getLogCount() {
		return logCount;
	}

	public void setLogCount(Long logCount) {
		this.logCount = logCount;
	}

	public String getHeadUrl() {
		return headUrl;
	}

	public void setHeadUrl(String headUrl) {
		this.headUrl = headUrl;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getLogInIp() {
		return logInIp;
	}

	public void setLogInIp(String logInIp) {
		this.logInIp = logInIp;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
}