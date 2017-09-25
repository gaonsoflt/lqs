package egovframework.system.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("userAuthoritiesMapper")
public interface UserAuthoritiesMapper {
	
	public List<Map<String, Object>> retrieveRolesUser(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> retrieveAuthoritiesByUser(Map<String, Object> map) throws Exception;
	
	public int createAuthority(Map<String, Object> map) throws Exception;
	
	public int deleteAuthority(Map<String, Object> map) throws Exception;
	
	public int deleteAuthorityByUserID(Map<String, Object> map) throws Exception;
}
