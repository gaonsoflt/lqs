package egovframework.system.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.system.vo.AuthVO;


@Mapper("authMapper")
public interface AuthMapper {
	
	public List<Map<String, Object>> retrieveGroupAuth(AuthVO param) throws Exception;
	
	public List<Map<String, Object>> retrieveRoleAuth(AuthVO param) throws Exception;
	
	/**
	 * 해당 페이지별 C,R,U,D,P에 대한 권한을 체크
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> retrievePageAuthByLogged(Map<String, Object> params) throws Exception;
	
	public int retrieveAuthsCount(Map<String, Object> params) throws Exception;
	
	public int createAuth(AuthVO param) throws Exception;
	
	public int updateAuth(AuthVO param) throws Exception;
	
	public int deleteAuth(AuthVO param) throws Exception; 
}
