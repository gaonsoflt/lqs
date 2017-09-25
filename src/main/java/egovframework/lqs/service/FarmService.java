package egovframework.lqs.service;

import java.util.Map;

import egovframework.com.vo.KendoResponseVO;

public interface FarmService {
	
	public KendoResponseVO getFarms(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> getFarm(long seq) throws Exception;
	
	public KendoResponseVO getLivestocksByFarm(long seq) throws Exception;

	public int insertFarm(Map<String, Object> map) throws Exception;	
	
	public int updateFarm(Map<String, Object> map)  throws Exception;	
	
	public int updateAppPassword(Map<String, Object> map)  throws Exception;	
	
	public int deleteFarm(Map<String, Object> map)  throws Exception;
}
