package polar.island.security.filter;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.PathMatchingFilter;
import org.springframework.util.StringUtils;
import polar.island.core.exception.NoPermissionException;
import polar.island.core.exception.NotLoginException;
import polar.island.core.security.service.ResourceService;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


public class DatabaseResouceFilter extends PathMatchingFilter {
	@Resource(name = "resourceService")
	private ResourceService resourceService;
	private Map<String, List<String>> sourcePermissions;

	public void loadDataBasePermissions() {
		// 从数据库读取资源权限列表
		sourcePermissions = resourceService.resourcePermissions();
	}

	private  boolean argsMatches(String argStr,ServletRequest request){
		boolean matches=true;
		if(!StringUtils.isEmpty(argStr)){
			String args[]=argStr.split("&");
			if(args!=null&&args.length>0){
				for(String arg:args){
					String key=null;
					String value=null;
					if(arg.contains("=")){
						key=arg.substring(0,arg.indexOf("="));
						value=arg.substring(arg.indexOf("=")+1);
					}
					if(!StringUtils.isEmpty(key)&&!StringUtils.isEmpty(value)){
						String requestValue=request.getParameter(key);
						if(!value.equals(requestValue)){
							matches=false;
							break;
						}
					}
				}
			}
		}
		return matches;
	}
	private List<String> findRequiredPermissions(ServletRequest request) {
		List<String> result = new ArrayList<>();
		Map<String, List<String>> sourcePermissions=this.sourcePermissions;
		if (sourcePermissions != null && sourcePermissions.size() > 0) {
			for (String path : sourcePermissions.keySet()) {
				if(path.contains("?")){
					String tempPath=path.substring(0,path.indexOf("?"));
					if (pathsMatch(tempPath, request)) {
						//判断参数是否匹配
						String argStr=path.substring(path.indexOf("?")+1);
						boolean matches=argsMatches(argStr,request);
						if(matches){
							result.addAll(sourcePermissions.get(path));
						}
					}
				}else{
					if (pathsMatch(path, request)) {
						result.addAll(sourcePermissions.get(path));
					}
				}
			}
		}
		return result;
	}

	@Override
	protected boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue)
			throws Exception {
		SecurityUtils.getSubject().getSession().touch();
		Subject currentUser = SecurityUtils.getSubject();
		if (currentUser != null) {
			if (sourcePermissions != null && sourcePermissions.size() > 0) {
				List<String> requiredPermissions = findRequiredPermissions(request);
				// 开始验证权限
				boolean flag = false;
				for (String permission : requiredPermissions) {
					if (!currentUser.isPermitted(permission)) {
						flag = true;
					}
				}
				if (flag) {
					// 没有权限访问
					request.setAttribute("exception", new NoPermissionException(null, null));
				}
				return true;
			}
		} else {
			// 用户未登录
			request.setAttribute("exception", new NotLoginException(null, null));
			return true;
		}

		return super.onPreHandle(request, response, mappedValue);
	}
}