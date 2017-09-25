package egovframework.system.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.vo.KendoResponseVO;
import egovframework.system.service.RoleService;

@Service("roleService")
public class RoleServiceImpl implements RoleService {
	Logger logger = LoggerFactory.getLogger(RoleServiceImpl.class);
	
	@Resource(name = "roleMapper")
	private RoleMapper roleMapper;
	
	@Override
	public KendoResponseVO getRoles(Map<String, Object> map) throws Exception {
		KendoResponseVO result;
		try {
			result = new KendoResponseVO(roleMapper.retrieveRoles(map), roleMapper.retrieveRolesCount(map));
		} catch (Exception e) {
			e.printStackTrace();
			result = new KendoResponseVO(e.toString());
		}
		return result;
	}
	
	@Override
	public KendoResponseVO getRole(String roleID) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("role_id", roleID);
		KendoResponseVO result;
		try {
			result = new KendoResponseVO(roleMapper.retrieveRole(param), 1);
		} catch (Exception e) {
			e.printStackTrace();
			result = new KendoResponseVO(e.toString());
		}
		return result;
	}

	@Override
	public int getRolesCount(Map<String, Object> map) throws Exception {
		return roleMapper.retrieveRolesCount(map);
	}

	@Override
	public int insertRole(Map<String, Object> map) throws Exception {
		return roleMapper.createRole(map);
	}

	@Override
	public int updateRole(Map<String, Object> map) throws Exception {
		return roleMapper.updateRole(map);
	}

	@Override
	public int deleteRole(Map<String, Object> map) throws Exception {
		return roleMapper.deleteRole(map);
	}	
}
