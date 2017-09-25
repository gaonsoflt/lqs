package egovframework.system.service;

import java.util.List;
import java.util.Map;

public interface BBSService {

	public Map<String, Object> getBBSList(Map<String, Object> param) throws Exception;
	
	public Map<String, Object> getBBS(String uid) throws Exception;
	
	public Map<String, Object> getNotMenuBBS() throws Exception;
	
	public int insertBBS(List<Map<String, Object>> params) throws Exception;
	
	public int updateBBS(List<Map<String, Object>> params) throws Exception;
	
	public int deleteBBS(List<Map<String, Object>> params) throws Exception;
}
