package egovframework.system.service.impl;

import java.util.Map;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("loginHistoryMapper")
public interface LoginHistoryMapper {

	public List<Map<String, Object>> retrieveLoginHistory(Map<String, Object> map) throws Exception;
	
	public int retrieveLoginHistoryCount(Map<String, Object> map) throws Exception;
	
	public int insertLoginHistory(Map<String, Object> map) throws Exception;
	/*
	public void updateSystemMngUserInfo(Map<String, Object> map) throws Exception;
	
	public void updateMngPassInfo(Map<String, Object> map) throws Exception;
	
	public void deleteSystemMngUserInfo(Map<String, Object> map) throws Exception; 
	*/
}
