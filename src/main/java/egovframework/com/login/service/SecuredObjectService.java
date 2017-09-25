package egovframework.com.login.service;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.util.matcher.RequestMatcher;

public interface SecuredObjectService {
	/**
	 * get URL mapping info into role
	 * @return
	 * @throws Exception
	 */
	public LinkedHashMap<RequestMatcher, List<ConfigAttribute>> getRolesAndUrl() throws Exception;

	/**
	 * get method mapping info into role
	 * @return
	 * @throws Exception
	 */
	public LinkedHashMap<String, List<ConfigAttribute>> getRolesAndMethod() throws Exception;

	/**
	 * get AOP pointcut mapping info into role
	 * @return
	 * @throws Exception
	 */
	public LinkedHashMap<String, List<ConfigAttribute>> getRolesAndPointcut() throws Exception;

	/**
	 * get best mapping info into role
	 * @param url
	 * @return
	 * @throws Exception
	 */
	public List<ConfigAttribute> getMatchedRequestMapping(String url) throws Exception;

	/**
	 * get hierarchical
	 * @return
	 * @throws Exception
	 */
	public String getHierarchicalRoles() throws Exception;
}
