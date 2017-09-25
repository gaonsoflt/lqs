package egovframework.system.service;

import java.util.Map;

import egovframework.com.vo.KendoResponseVO;

public interface SecuredResRoleService {
	
	public KendoResponseVO getSecuredResRole(Map<String, Object> map) throws Exception;

	public int saveSecuredResRole(Map<String, Object> map) throws Exception;	
	
	public int deleteSecuredResRole(Map<String, Object> map)  throws Exception;
}
