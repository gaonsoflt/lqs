package egovframework.system.service;

import java.util.Map;
import java.util.List;

public interface LoginHistoryService {

	public List<Map<String, Object>> getLoginHistory(Map<String, Object> map) throws Exception;
	
	public int getLoginHistoryCount(Map<String, Object> map) throws Exception;

	public int insertLoginHistory(Map<String, Object> map) throws Exception;
	
	/*
	public void updateSystemMngUserInfo(Map<String, Object> map) throws Exception;
	
	public void updateMngPassInfo(Map<String, Object> map) throws Exception;
	
	public void deleteSystemMngUserInfo(Map<String, Object> map) throws Exception;  
	*/
}
