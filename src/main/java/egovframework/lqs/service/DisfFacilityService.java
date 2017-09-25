package egovframework.lqs.service;

import java.util.Map;

import egovframework.com.vo.KendoResponseVO;

public interface DisfFacilityService {
	
	public KendoResponseVO getDisfFacilities(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> getDisfFacility(long seq) throws Exception;
	
	public int insertDisfFacility(Map<String, Object> map) throws Exception;	
	
	public int updateDisfFacility(Map<String, Object> map)  throws Exception;	
	
	public int deleteDisfFacility(Map<String, Object> map)  throws Exception;
}
