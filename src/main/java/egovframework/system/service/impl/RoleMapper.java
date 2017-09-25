package egovframework.system.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("roleMapper")
public interface RoleMapper {
	
	public List<Map<String, Object>> retrieveRoles(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> retrieveRole(Map<String, Object> map) throws Exception;
	
	public int retrieveRolesCount(Map<String, Object> map) throws Exception;
	
	public int createRole(Map<String, Object> map) throws Exception;
	
	public int updateRole(Map<String, Object> map) throws Exception;
	
	public int deleteRole(Map<String, Object> map) throws Exception; 
}
