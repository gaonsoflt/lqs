package egovframework.system.service.impl;

import java.util.Map;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("groupUserMapper")
public interface GroupUserMapper {

	public List<Map<String, Object>> retrieveNoGroupUsers(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> retrieveGroupUsers(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> retrieveUserGroups(Map<String, Object> map) throws Exception;
	
	public int createGroupUser(Map<String, Object> map) throws Exception;
	
	public int deleteGroupUser(Map<String, Object> map) throws Exception;
}
