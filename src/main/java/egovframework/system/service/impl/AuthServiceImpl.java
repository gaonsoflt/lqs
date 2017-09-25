package egovframework.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.vo.KendoResponseVO;
import egovframework.system.service.AuthService;
import egovframework.system.service.UserService;
import egovframework.system.vo.AuthVO;
import egovframework.system.vo.AuthVO.TargetType;

@Service("authService")
public class AuthServiceImpl implements AuthService { 
	Logger logger = LoggerFactory.getLogger(AuthServiceImpl.class);
	
	@Resource(name = "authMapper")
	private AuthMapper authMapper;
	
	@Resource(name = "userService")
	private UserService userService;
	
	@Resource(name = "groupAuthoritiesMapper")
	private GroupAuthoritiesMapper groupAuthoritiesMapper;
	
	@Resource(name = "userAuthoritiesMapper")
	private UserAuthoritiesMapper userAuthoritiesMapper;

	@Override
	public KendoResponseVO getRoleAuth(String targetID) throws Exception {
		KendoResponseVO result = null;
		AuthVO param = new AuthVO();
		try {
			param.setTarget_id(targetID);
			param.setTarget_type(TargetType.ROLE);
			List<Map<String, Object>> list = authMapper.retrieveRoleAuth(param);
			result = new KendoResponseVO(list, list.size());
		} catch (Exception e) {
			e.printStackTrace();
			result = new KendoResponseVO(e.toString());
		}
		return result;
	}	
	
	@Override
	public Map<String, Object> getPageAuthByLogged(long menuSeq) throws Exception {
		Map<String, Object> param = new HashMap<>();
		try {
			param.put("menu_seq", menuSeq);
			param.put("user_id", userService.getLoginUserInfo().getUsername());
			return authMapper.retrievePageAuthByLogged(param);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}	
	
	@Override
	public int saveAuth(Map<String, Object> map) throws Exception {
		AuthVO param = new AuthVO(map);
		int exeCnt = authMapper.updateAuth(param);
		if(exeCnt > 0) {
			return exeCnt;
		}
		return authMapper.createAuth(param);
	}
	
	@Override
	public int insertAuth(Map<String, Object> map) throws Exception {
		return authMapper.createAuth(new AuthVO(map));
	}

	@Override
	public int updateAuth(Map<String, Object> map)  throws Exception {
		return authMapper.updateAuth(new AuthVO(map));
	}

	@Override
	public int deleteAuth(Map<String, Object> map)  throws Exception {
		return authMapper.deleteAuth(new AuthVO(map));
	}


	@Override
	public KendoResponseVO getRolesGroup(String roleID) throws Exception {
		KendoResponseVO result = null;
		try {
			Map<String, Object> param = new HashMap<>();
			param.put("role_id", roleID);
			List<Map<String, Object>> list = groupAuthoritiesMapper.retrieveRolesGroup(param);
			result = new KendoResponseVO(list, list.size());
		} catch (Exception e) {
			e.printStackTrace();
			result = new KendoResponseVO(e.toString());
		}
		return result;
	}


	@Override
	public KendoResponseVO getRolesUserByGroup(String roleID, String groupID) throws Exception {
		KendoResponseVO result = null;
		try {
			Map<String, Object> param = new HashMap<>();
			param.put("role_id", roleID);
			param.put("group_id", groupID);
			List<Map<String, Object>> list = userAuthoritiesMapper.retrieveRolesUser(param);
			result = new KendoResponseVO(list, list.size());
		} catch (Exception e) {
			e.printStackTrace();
			result = new KendoResponseVO(e.toString());
		}
		return result;
	}

	@Override
	public int saveRolesGroup(Map<String, Object> map) throws Exception {
		boolean isRole = (boolean) map.get("is_role");
		if(isRole) {
			return groupAuthoritiesMapper.createAuthority(map);
		}
		return groupAuthoritiesMapper.deleteAuthority(map);
	}

	@Override
	public int saveRolesUser(Map<String, Object> map) throws Exception {
		boolean isRole = (boolean) map.get("is_role");
		if(isRole) {
			return userAuthoritiesMapper.createAuthority(map);
		}
		return userAuthoritiesMapper.deleteAuthority(map);
	}
}
