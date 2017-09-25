package egovframework.system.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.vo.KendoResponseVO;
import egovframework.system.service.SecuredResRoleService;

@Service("securedResRoleService")
public class SecuredResRoleServiceImpl implements SecuredResRoleService { 
	Logger logger = LoggerFactory.getLogger(SecuredResRoleServiceImpl.class);
	
	@Resource(name = "securedResRoleMapper")
	private SecuredResRoleMapper securedResRoleMapper;


	@Override
	public KendoResponseVO getSecuredResRole(Map<String, Object> map) throws Exception {
		KendoResponseVO result = null;
		try {
			List<Map<String, Object>> list = securedResRoleMapper.retrieveSecuredResRole(map);
			result = new KendoResponseVO(list, securedResRoleMapper.retrieveSecuredResRolesCount(map));
		} catch (Exception e) {
			e.printStackTrace();
			result = new KendoResponseVO(e.toString());
		}
		return result;
	}

	@Override
	public int saveSecuredResRole(Map<String, Object> map) throws Exception {
		boolean isAuth = (boolean) map.get("is_auth");
		if(isAuth) {
			return securedResRoleMapper.createSecuredResRole(map);
		}
		return securedResRoleMapper.deleteSecuredResRole(map);
	}

	@Override
	public int deleteSecuredResRole(Map<String, Object> map) throws Exception {
		return securedResRoleMapper.deleteSecuredResRole(map);
	}
}
