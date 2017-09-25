package egovframework.system.service.impl;

import java.util.Map;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("groupMapper")
public interface GroupMapper {

	public int retrieveGroupsCount(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> retrieveGroups(Map<String, Object> map) throws Exception;
	
	public int createGroup(Map<String, Object> map) throws Exception;
	
	public int updateGroup(Map<String, Object> map) throws Exception;
	
	public int deleteGroup(Map<String, Object> map) throws Exception;
}
