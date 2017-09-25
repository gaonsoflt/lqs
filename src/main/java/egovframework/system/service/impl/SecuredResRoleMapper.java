package egovframework.system.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("securedResRoleMapper")
public interface SecuredResRoleMapper {

	public List<Map<String, Object>> retrieveSecuredResRole(Map<String, Object> map) throws Exception;
	
	public int retrieveSecuredResRolesCount(Map<String, Object> map) throws Exception;
	
	public int createSecuredResRole(Map<String, Object> map) throws Exception;
	
	public int deleteSecuredResRole(Map<String, Object> map) throws Exception;
}
