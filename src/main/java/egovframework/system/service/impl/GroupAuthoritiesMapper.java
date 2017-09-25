package egovframework.system.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("groupAuthoritiesMapper")
public interface GroupAuthoritiesMapper {
	
	public List<Map<String, Object>> retrieveRolesGroup(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> retrieveAuthoritiesByUser(Map<String, Object> map) throws Exception;
	
	public int createAuthority(Map<String, Object> map) throws Exception;
	
	public int deleteAuthority(Map<String, Object> map) throws Exception;
	
	public int deleteAuthorityByGroupID(Map<String, Object> map) throws Exception;
}
