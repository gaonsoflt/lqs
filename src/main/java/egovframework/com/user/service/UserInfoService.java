package egovframework.com.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface UserInfoService {

    public List<UserInfoVo> retrieveUser(UserInfoVo userInfoVo) throws Exception;
    
    public HashMap<String, Object> retrieveUserInfo(HashMap<String, Object> map) throws Exception;
    
    public List<Map<String, Object>> loadUserAuthorities(String userID) throws Exception;
	
	public List<Map<String, Object>> loadGroupAuthorities(String groupID) throws Exception;

	public void insertUserLoginLog(HashMap<String, Object> map) throws Exception;
}
