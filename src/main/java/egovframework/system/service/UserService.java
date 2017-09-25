package egovframework.system.service;

import java.util.Map;
import java.util.List;

import egovframework.com.login.service.CmmLoginUser;

public interface UserService {

	public CmmLoginUser getLoginUserInfo();
	
	public List<Map<String, Object>> getUsers(Map<String, Object> param) throws Exception;
	
	public int getUsersCount(Map<String, Object> param) throws Exception;
	
	public int insertUser(Map<String, Object> param) throws Exception;
	
	public int updateUser(Map<String, Object> param) throws Exception;
	
	public int updatePassword(Map<String, Object> param) throws Exception;
	
	public int deleteUser(Map<String, Object> param) throws Exception;  
}
