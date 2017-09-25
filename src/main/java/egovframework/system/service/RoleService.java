package egovframework.system.service;

import java.util.Map;

import egovframework.com.vo.KendoResponseVO;

public interface RoleService {
	public KendoResponseVO getRoles(Map<String, Object> map) throws Exception;
	
	public KendoResponseVO getRole(String roleID) throws Exception;
	
	public int getRolesCount(Map<String, Object> map) throws Exception;
	
	public int insertRole(Map<String, Object> map) throws Exception;	
	
	public int updateRole(Map<String, Object> map) throws Exception;	
	
	public int deleteRole(Map<String, Object> map)  throws Exception;
}
