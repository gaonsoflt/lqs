package egovframework.system.service;

import java.util.Map;

import egovframework.common.annotation.container.InnerPageVO;
import egovframework.system.vo.MenuVO;

import java.util.List;

public interface MenuService {

	public List<Map<String, Object>> getMenuInfoList(Long seq) throws Exception;
	
	public List<Map<String, Object>> getMenuInfoList(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getHierarchicalMenuInfo(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getParentMenuInfoList(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getChildMenuInfoList(Long seq) throws Exception;
	
//	public List<MenuVO> getMenuInfoByAuth(Map<String, Object> map) throws Exception;
	public List<MenuVO> getMenuInfoByAuth(String userID) throws Exception;
	
	public List<MenuVO> getLoggedMenuInfo() throws Exception;
	
	public void createMenuInfo(Map<String, Object> map) throws Exception;
	
	public void updateMenuInfo(Map<String, Object> map) throws Exception;
	
	public void deleteMenuInfo(Map<String, Object> map) throws Exception;
	
	
	// cache innerpage
	public List<InnerPageVO> getInnerPage();
	
	// cache menu info
	public MenuVO getLoggedMenuVoByMenuSeq(long seq) throws Exception;
//	public MenuVO getLoggedMenuVoByMenuID(String menuID) throws Exception;
//	public MenuVO getLoggedMenuVoByBBS(String uid) throws Exception;
	public void removeCachedMenu(String userID) throws Exception;
	public void refreshCachedMenu(String userID) throws Exception;
//	public void refreshCachedMenu(Map<String, Object> param) throws Exception;
	public void refreshCachedMenu() throws Exception;
}
