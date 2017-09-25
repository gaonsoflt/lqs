package egovframework.system.service;

import java.util.Map;

public interface GroupUserService {
	// group
	public Map<String, Object> getGroups(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> getGroup(int groupID) throws Exception;	
	
	public int insertGroup(Map<String, Object> map) throws Exception;	
	
	public int updateGroup(Map<String, Object> map) throws Exception;	
	
	public int deleteGroup(Map<String, Object> map)  throws Exception;
	
	// group users
	public Map<String, Object> getNoGroupUsers(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> getGroupUsers(Map<String, Object> map) throws Exception;

	public Map<String, Object> getGroupsByUser(String userID) throws Exception;
	
	public Map<String, Object> getGroupsByLoginUser() throws Exception;
	
	public int saveGroupUser(Map<String, Object> map) throws Exception;	
	
	public int deleteGroupUser(Map<String, Object> map) throws Exception;	
}
