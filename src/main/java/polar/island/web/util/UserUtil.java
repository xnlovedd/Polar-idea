package polar.island.web.util;

import org.apache.shiro.SecurityUtils;
import polar.island.core.security.entity.UserEntity;
import polar.island.security.realm.ShiroPrincipal;

public class UserUtil {
	public static UserEntity getCurrentUser() {
		ShiroPrincipal shiroPrincipal = (ShiroPrincipal) SecurityUtils.getSubject().getPrincipal();
		if (shiroPrincipal != null) {
			return shiroPrincipal.getUser();
		}
		return null;
	}

	public static String getUserId() {
		ShiroPrincipal shiroPrincipal = (ShiroPrincipal) SecurityUtils.getSubject().getPrincipal();
		if (shiroPrincipal != null) {
			return shiroPrincipal.getUser().getId() + "";
		}
		return null;
	}

	public static String getUserName() {
		ShiroPrincipal shiroPrincipal = (ShiroPrincipal) SecurityUtils.getSubject().getPrincipal();
		if (shiroPrincipal != null) {
			return shiroPrincipal.getUser().getUserName();
		}
		return null;
	}
}
