package egovframework.com.user.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.user.service.UserInfoService;
import egovframework.com.user.service.UserInfoVo;
import egovframework.system.service.impl.GroupAuthoritiesMapper;
import egovframework.system.service.impl.UserAuthoritiesMapper;
import egovframework.system.service.impl.UserMapper;

@Service("userInfoService")
public class UserInfoServiceImpl implements UserInfoService {
	
	@Resource(name = "userMapper")
	private UserMapper userMapper;
	
	@Resource(name = "userAuthoritiesMapper")
	private UserAuthoritiesMapper userAuthoritiesMapper;
	
	@Resource(name = "groupAuthoritiesMapper")
	private GroupAuthoritiesMapper groupAuthoritiesMapper;
	
	@SuppressWarnings("unchecked")
	public List<UserInfoVo> retrieveUser(UserInfoVo userInfoVo) throws Exception {
		return (List<UserInfoVo>) userMapper.retrieveUser(userInfoVo);
	}
	
	public HashMap<String, Object> retrieveUserInfo(HashMap<String, Object> map) throws Exception{
		return userMapper.retrieveUserInfo(map);
	}
	
	public List<Map<String, Object>> loadUserAuthorities(String userID) throws Exception{
		Map<String, Object> param = new HashMap<>();
		param.put("user_id", userID);
		return userAuthoritiesMapper.retrieveAuthoritiesByUser(param);
	}
	
	public List<Map<String, Object>> loadGroupAuthorities(String userID) throws Exception{
		Map<String, Object> param = new HashMap<>();
		param.put("user_id", userID);
		return groupAuthoritiesMapper.retrieveAuthoritiesByUser(param);
	}

	public void insertUserLoginLog(HashMap<String, Object> map) throws Exception{
//		userMapper.insertUserLoginLog(map);
	}
	
}
