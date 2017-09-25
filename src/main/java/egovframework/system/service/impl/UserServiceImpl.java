package egovframework.system.service.impl;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import egovframework.com.login.service.CmmLoginUser;
import egovframework.common.util.PwdEncryptor;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.system.service.UserService;

@Service("userService")
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService {

	@Resource(name = "userMapper")
	private UserMapper userMapper;
	
	@Resource(name = "userAuthoritiesMapper")
	private UserAuthoritiesMapper userAuthoritiesMapper;

	@Override
	public CmmLoginUser getLoginUserInfo() {
		CmmLoginUser userDetails = (CmmLoginUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		return userDetails;
	}

	@Override
	public List<Map<String, Object>> getUsers(Map<String, Object> param) throws Exception {
		return userMapper.retrieveUsers(param);
	}

	@Override
	public int getUsersCount(Map<String, Object> param) throws Exception {
		return userMapper.retrieveUsersCount(param);

	}
	@Override
	public int insertUser(Map<String, Object> param) throws Exception {
		if (param.get("password") != null && !param.get("password").toString().trim().equals("")) {
			param.put("password", PwdEncryptor.getEncrypt(param.get("password").toString().trim()));
		}
		param.put("principle", UUID.randomUUID().toString());
		int exeCnt = 0;
		exeCnt = userMapper.createUser(param);
		if(exeCnt > 0) {
			// default role
			param.put("role_id", "ROLE_USER");
			userAuthoritiesMapper.createAuthority(param);
		}
		return exeCnt;
	}

	@Override
	public int updateUser(Map<String, Object> param) throws Exception {
		if (param.get("password") != null && !param.get("password").toString().trim().equals("")) {
			param.put("password", PwdEncryptor.getEncrypt(param.get("password").toString().trim()));
			userMapper.updatePassword(param);
		}
		return userMapper.updateUser(param);
	}

	@Override
	public int updatePassword(Map<String, Object> param) throws Exception {
		return userMapper.updatePassword(param);
	}

	@Override
	public int deleteUser(Map<String, Object> param) throws Exception {
		int exeCnt = 0;
		exeCnt = userMapper.deleteUser(param);
		if(exeCnt > 0) {
			// delete private role
			userAuthoritiesMapper.deleteAuthorityByUserID(param);
			// TODO: delete group role
			// TODO: delete group
		}
		return exeCnt;
	}
}