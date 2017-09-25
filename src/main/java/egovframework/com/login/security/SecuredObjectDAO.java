package egovframework.com.login.security;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

public class SecuredObjectDAO {
	Logger logger = LoggerFactory.getLogger(SecuredObjectDAO.class.getName());
	
	/*
	 * URL type resource - default query select role mapping info
	 */
	public static final String DEF_ROLES_AND_URL_QUERY =
			"SELECT A.RES_PATTERN AS URL, B.role_id AS AUTHORITY "
					+ "FROM SYS_SECURED_RES A, SYS_SECURED_RES_ROLE B "
					+ "WHERE A.RES_ID = B.RES_ID "
					+ "AND A.RES_TYPE = 'url' "
					+ "ORDER BY A.SORT_ORDER ";
	
	/*
	 * method type resource - default query select role mapping info
	 */
	public static final String DEF_ROLES_AND_METHOD_QUERY = 
			"SELECT A.RES_PATTERN AS URL, B.role_id AS AUTHORITY "
					+ "FROM SYS_SECURED_RES A, SYS_SECURED_RES_ROLE B "
					+ "WHERE A.RES_ID = B.RES_ID "
					+ "AND A.RES_TYPE = 'method' "
					+ "ORDER BY A.SORT_ORDER ";
	
	/*
	 * pointcut type resource - default query select role mapping info
	 */
	public static final String DEF_ROLES_AND_POINTCUT_QUERY =
			"SELECT A.RES_PATTERN AS URL, B.role_id AS AUTHORITY "
					+ "FROM SYS_SECURED_RES A, SYS_SECURED_RES_ROLE B "
					+ "WHERE A.RES_ID = B.RES_ID "
					+ "AND A.RES_TYPE = 'pointcut' "
					+ "ORDER BY A.SORT_ORDER ";
	
	/*
	 * best matching url type resource, when every request - default query select role mapping info
	 */
	public static final String DEF_REGEX_MATCHED_REQUEST_MAPPING_QUERY_ORACLE10G = 
			"SELECT a.res_pattern uri, b.role_id authority "
			+ "FROM sys_secured_res a, sys_secured_res_role b "
			+ "WHERE a.res_id = b.res_id "
			+ "AND a.res_id = "
			+ " ( SELECT res_id FROM "
			+ "    ( SELECT res_id, ROW_NUMBER() OVER (ORDER BY sort_order) resource_order FROM sys_secured_res c "
			+ "      WHERE REGEXP_LIKE ( :url, c.res_pattern ) "
			+ "      AND c.res_type = 'url' "
			+ "      ORDER BY c.sort_order ) "
			+ "   WHERE resource_order = 1 ) ";
	
	/*
	 * default query select hierarchy of role info
	 */
	public static final String DEF_HIERARCHICAL_ROLES_QUERY = 
			"SELECT a.child_role child, a.parent_role parent "
			+ "FROM SYS_ROLE_HIERARCHY a LEFT JOIN SYS_ROLE_HIERARCHY b on (a.child_role = b.parent_role) ";
	
	private String sqlRolesAndUrl;
	private String sqlRolesAndMethod;
	private String sqlRolesAndPointcut;
	private String sqlRegexMatchedRequestMapping;
	private String sqlHierarchicalRoles;
	
	public SecuredObjectDAO() {
		this.sqlRolesAndUrl = DEF_ROLES_AND_URL_QUERY;
		this.sqlRolesAndMethod = DEF_ROLES_AND_METHOD_QUERY;
		this.sqlRolesAndPointcut = DEF_ROLES_AND_POINTCUT_QUERY;
		this.sqlRegexMatchedRequestMapping = DEF_REGEX_MATCHED_REQUEST_MAPPING_QUERY_ORACLE10G;
		this.sqlHierarchicalRoles = DEF_HIERARCHICAL_ROLES_QUERY;
	}
	
	private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
	
	public void setDataSource(DataSource dataSource) {
		this.namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
	}

	public String getSqlRolesAndUrl() {
		return sqlRolesAndUrl;
	}

	public void setSqlRolesAndUrl(String sqlRolesAndUrl) {
		this.sqlRolesAndUrl = sqlRolesAndUrl;
	}

	public String getSqlRolesAndMethod() {
		return sqlRolesAndMethod;
	}

	public void setSqlRolesAndMethod(String sqlRolesAndMethod) {
		this.sqlRolesAndMethod = sqlRolesAndMethod;
	}

	public String getSqlRolesAndPointcut() {
		return sqlRolesAndPointcut;
	}

	public void setSqlRolesAndPointcut(String sqlRolesAndPointcut) {
		this.sqlRolesAndPointcut = sqlRolesAndPointcut;
	}

	public String getSqlRegexMatchedRequestMapping() {
		return sqlRegexMatchedRequestMapping;
	}

	public void setSqlRegexMatchedRequestMapping(String sqlRegexMatchedRequestMapping) {
		this.sqlRegexMatchedRequestMapping = sqlRegexMatchedRequestMapping;
	}

	public String getSqlHierarchicalRoles() {
		return sqlHierarchicalRoles;
	}

	public void setSqlHierarchicalRoles(String sqlHierarchicalRoles) {
		this.sqlHierarchicalRoles = sqlHierarchicalRoles;
	}
	
	public LinkedHashMap<Object, List<ConfigAttribute>> getRoleseAndResources(String resourceType) throws Exception {
		LinkedHashMap<Object, List<ConfigAttribute>> resourcesMap = new LinkedHashMap<>();
		
		String sqlRolesAndResource;
		boolean isResourcesUrl = true;
		
		if("method".equals(resourceType)) {
			sqlRolesAndResource = getSqlRolesAndMethod();
			isResourcesUrl = false;
		} else if("pointcut".equals(resourceType)) {
			sqlRolesAndResource = getSqlRolesAndPointcut();
			isResourcesUrl = false;
		} else {
			sqlRolesAndResource = getSqlRolesAndUrl();
			isResourcesUrl = false;
		}
		
		List<Map<String, Object>> resultList = this.namedParameterJdbcTemplate.queryForList(sqlRolesAndResource, new HashMap<String, String>());
		
		Iterator<Map<String, Object>> itr = resultList.iterator();
		Map<String, Object> tempMap;
		String preResource = null;
		String presentResourceStr;
		Object presentResource;
		
		while(itr.hasNext()) {
			tempMap = itr.next();
			presentResourceStr = (String) tempMap.get(resourceType);
			
			// if type is URL, Map has to include RequestKey in key
			presentResource = isResourcesUrl ? new AntPathRequestMatcher(presentResourceStr) : presentResourceStr;
			List<ConfigAttribute> configList = new LinkedList<>();
			
			if(preResource != null && presentResourceStr.equals(preResource)) {
				List<ConfigAttribute> preAuthList = resourcesMap.get(presentResource);
				Iterator<ConfigAttribute> preAuthItr = preAuthList.iterator();
				while(preAuthItr.hasNext()) {
					SecurityConfig tempConfig = (SecurityConfig) preAuthItr.next();
					configList.add(tempConfig);
				}
			}
			
			configList.add(new SecurityConfig((String) tempMap.get("authority")));
			
			resourcesMap.put(presentResource, configList);
			
			// save temp data for compare old data
			preResource = presentResourceStr;
		}
		
		return resourcesMap;
	}
	
	public LinkedHashMap<Object, List<ConfigAttribute>> getRolesAndUrl() throws Exception {
		return getRoleseAndResources("url");
	}
	
	public LinkedHashMap<Object, List<ConfigAttribute>> getRolesAndMethod() throws Exception {
		return getRoleseAndResources("method");
	}
	
	public LinkedHashMap<Object, List<ConfigAttribute>> getRolesAndPointcut() throws Exception {
		return getRoleseAndResources("pointcut");
	}
	
	public List<ConfigAttribute> getRegexMatchedRequestMapping(String url) throws Exception {
		Map<String, String> paramMap = new HashMap<>();
		paramMap.put("url", url);
		List<Map<String, Object>> resultList = this.namedParameterJdbcTemplate.queryForList(getSqlRegexMatchedRequestMapping(), paramMap);
		
		Iterator<Map<String, Object>> itr = resultList.iterator();
		Map<String, Object> tempMap;
		List<ConfigAttribute> configList = new LinkedList<>();
		
		// role mapping into same URi
		while(itr.hasNext()) {
			tempMap = itr.next();
			configList.add(new SecurityConfig((String) tempMap.get("authority")));
		}
		
		if(configList.size() > 0) {
			logger.debug("Request Uri : {}, matched Uri : {}, mapping Roles : {}", url, resultList.get(0).get("uri"), configList);
		}
		
		return configList;
	}
	
	public String getHierarchicalRoles() throws Exception {
		List<Map<String, Object>> resultList = this.namedParameterJdbcTemplate.queryForList(getSqlHierarchicalRoles(), new HashMap<String, String>());
		
		Iterator<Map<String, Object>> itr = resultList.iterator();
		StringBuffer concatedRoles = new StringBuffer();
		Map<String, Object> tempMap;
		
		while(itr.hasNext()) {
			tempMap = itr.next();
			concatedRoles.append(tempMap.get("child"));
			concatedRoles.append(" > ");
			concatedRoles.append(tempMap.get("parent"));
			concatedRoles.append("\n");
		}
		
		return concatedRoles.toString();
	}
}
