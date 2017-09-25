package egovframework.system.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("securedResMapper")
public interface SecuredResMapper {

	public List<Map<String, Object>> retrieveSecuredResources(Map<String, Object> map) throws Exception;
	
	public int retrieveSecuredResourcesCount(Map<String, Object> map) throws Exception;
	
	public String retrieveMaxResIDByType(Map<String, Object> map) throws Exception;
	
	public int createSecuredResource(Map<String, Object> map) throws Exception;
	
	public int updateSecuredResource(Map<String, Object> map) throws Exception;
	
	public int deleteSecuredResource(Map<String, Object> map) throws Exception;
}
