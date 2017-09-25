package egovframework.system.service;

import java.util.Map;

import egovframework.com.vo.KendoResponseVO;

public interface AuthService {
	
	public KendoResponseVO getRoleAuth(String targetID) throws Exception;
	
	/**
	 * 해당 페이지별 C,R,U,D,P에 대한 권한을 체크
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getPageAuthByLogged(long menuSeq) throws Exception;

	public int saveAuth(Map<String, Object> map) throws Exception;	
	
	public int insertAuth(Map<String, Object> map) throws Exception;	
	
	public int updateAuth(Map<String, Object> map)  throws Exception;	
	
	public int deleteAuth(Map<String, Object> map)  throws Exception;
	
	public KendoResponseVO getRolesGroup(String roleID) throws Exception;
	
	public int saveRolesGroup(Map<String, Object> map) throws Exception;	
	
	public KendoResponseVO getRolesUserByGroup(String roleID, String groupID) throws Exception;
	
	public int saveRolesUser(Map<String, Object> map) throws Exception;	
}
