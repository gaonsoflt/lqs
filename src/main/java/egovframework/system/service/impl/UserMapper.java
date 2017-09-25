package egovframework.system.service.impl;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

import egovframework.com.user.service.UserInfoVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("userMapper")
public interface UserMapper {
	
	public UserInfoVo retrieveUser(UserInfoVo userInfoVo) throws Exception;
	
	public HashMap<String, Object> retrieveUserInfo(HashMap<String, Object> map) throws Exception;
	
	
	public List<Map<String, Object>> retrieveUsers(Map<String, Object> map) throws Exception;
	
	public int retrieveUsersCount(Map<String, Object> map) throws Exception;
	
	public int createUser(Map<String, Object> map) throws Exception;
	
	public int updateUser(Map<String, Object> map) throws Exception;
	
	public int updatePassword(Map<String, Object> map) throws Exception;
	
	public int deleteUser(Map<String, Object> map) throws Exception; 
}
