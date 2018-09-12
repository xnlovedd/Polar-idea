package polar.island.security.realm;

import polar.island.core.security.entity.UserEntity;

import java.io.Serializable;


public class ShiroPrincipal  implements Serializable {

	private static final long serialVersionUID = -1369535562186178652L;
	private UserEntity user;

	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

	public ShiroPrincipal(UserEntity user) {
		super();
		this.user = user;
	}
}
