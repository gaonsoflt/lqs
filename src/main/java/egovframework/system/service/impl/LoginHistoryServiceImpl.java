package egovframework.system.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.system.service.LoginHistoryService;


@Service("loginHistoryService")
public class LoginHistoryServiceImpl implements LoginHistoryService { 
	
	@Resource(name = "loginHistoryMapper")
	private LoginHistoryMapper loginLogMapper;
	/*
	public void updateSystemMngUserInfo(HashMap<String, Object> map) throws Exception{
		systemMngUserMapper.updateSystemMngUserInfo(map);
	}
	
	public void updateMngPassInfo(HashMap<String, Object> map) throws Exception{
		systemMngUserMapper.updateMngPassInfo(map);
	}
	
	public void deleteSystemMngUserInfo(HashMap<String, Object> map) throws Exception{
		systemMngUserMapper.deleteSystemMngUserInfo(map);
	}
	*/

	@Override
	public List<Map<String, Object>> getLoginHistory(Map<String, Object> map) throws Exception {
		return loginLogMapper.retrieveLoginHistory(map);
	}

	@Override
	public int getLoginHistoryCount(Map<String, Object> map) throws Exception {
		return loginLogMapper.retrieveLoginHistoryCount(map);
	}

	@Override
	public int insertLoginHistory(Map<String, Object> map) throws Exception {
		return loginLogMapper.insertLoginHistory(map);
	}
}