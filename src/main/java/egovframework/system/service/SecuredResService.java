package egovframework.system.service;

import java.util.Map;

import egovframework.com.vo.KendoResponseVO;

public interface SecuredResService {
	
	public KendoResponseVO getSecuredResources(Map<String, Object> map) throws Exception;

	public int insertSecuredResource(Map<String, Object> map) throws Exception;	
	
	public int updateSecuredResource(Map<String, Object> map)  throws Exception;	
	
	public int deleteSecuredResource(Map<String, Object> map)  throws Exception;
}
