package egovframework.system.service.impl;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.common.annotation.container.ContextContainer;
import egovframework.common.annotation.container.InnerPageVO;
import egovframework.system.service.MenuService;
import egovframework.system.service.UserService;
import egovframework.system.vo.MenuVO;

@Service("menuService")
public class MenuServiceImpl implements MenuService {
	Logger logger = LoggerFactory.getLogger(MenuServiceImpl.class.getName());

	@Resource(name = "menuMapper")
	private MenuMapper menuMapper;
	
//	@Resource(name = "systemMgrUserAuthMapper")
//	private SystemMgrUserAuthMapper authMapper;
	
	@Resource(name = "userService")
	private UserService userService;
	
	@Resource(name = "securedResMapper")
	private SecuredResMapper securedResMapper;
	
	private Map<String, List<MenuVO>> loggedMenuMap;
	
	@Autowired
	private ContextContainer contextContainer; 
	private List<InnerPageVO> innerPage;

	@PostConstruct
	public void init() throws Exception {
		logger.debug("init innerpage");
		innerPage = contextContainer.getInnerPage("egovframework");
	}
	
	@Override
	public List<InnerPageVO> getInnerPage() {
		return innerPage;
	}

	public void setMenu(String userID, List<MenuVO> menuVo) {
		if(loggedMenuMap == null) {
			loggedMenuMap = new HashMap<>();
		}
		loggedMenuMap.put(userID, menuVo);
	}
	
	public List<MenuVO> getMenu(String userID) {
		if(loggedMenuMap == null) {
			loggedMenuMap = new HashMap<>();
		}
		
		if(loggedMenuMap.containsKey(userID)) {
			return loggedMenuMap.get(userID);
		} else {
			try {
				refreshCachedMenu(userID);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return loggedMenuMap.get(userID);
		}
	}
	
	public List<MenuVO> getMenu() {
		return getMenu(userService.getLoginUserInfo().getUsername());
	}

	@Override
	public List<Map<String, Object>> getMenuInfoList(Long seq) throws Exception {
		Map<String, Object> param = new HashMap<>();
		if(seq != null) {
			param.put("menu_seq", seq);
		}
		return getMenuInfoList(param);
	}
	
	@Override
	public List<Map<String, Object>> getMenuInfoList(Map<String, Object> map) throws Exception {
		return menuMapper.selectMenus(map);
	}
	
	@Override
	public List<Map<String, Object>> getHierarchicalMenuInfo(Map<String, Object> map) throws Exception {
		LinkedList<Map<String, Object>> result = new LinkedList<>();
		if(map == null || map.get("menu_seq") == null) {
			map.put("menu_seq", 0);
			map.put("menu_name", "Root");
			map.put("spriteCssClass", "rootfolder");
			map.put("expanded", true);
			List<Map<String, Object>> child = menuMapper.selectChildMenus(map);
			if(child.size() > 0) {
				map.put("hasChildren", true);	
			} else {
				map.put("hasChildren", false);
			}
			map.put("addChildren", true);
			result.add(map);
		} else {
			List<Map<String, Object>> parents = menuMapper.selectChildMenus(map);
			for (Map<String, Object> parent : parents) {
				parent.put("expanded", true);
				List<Map<String, Object>> childs = menuMapper.selectChildMenus(parent);
				parent.put("addChildren", true);
				if(childs.size() > 0) {
					parent.put("hasChildren", true);
					parent.put("spriteCssClass", "folder");
				} else {
					parent.put("hasChildren", false);
					if(map.get("menu_seq").equals(0L)) {
						parent.put("spriteCssClass", "folder");
					} else {
						parent.put("addChildren", false);
						parent.put("spriteCssClass", "html");
					}
				}
				result.add(parent);
			}
		}
		return result;
	}
	
	@Override
	public List<Map<String, Object>> getParentMenuInfoList(Map<String, Object> map) throws Exception {
		return menuMapper.retrieveParentMenu(map);	
	}

	@Override
	public List<Map<String, Object>> getChildMenuInfoList(Long seq) throws Exception {
		Map<String, Object> param = new HashMap<>();
		if(seq != null) {
			param.put("menu_seq", seq);
		}
		return menuMapper.selectChildMenus(param);
	}

	@Override
	public void createMenuInfo(Map<String, Object> map) throws Exception {
		// create menu info 
		menuMapper.createMenu(map);

		// create secured resource info
		// mene resource = url type
		map.put("res_type", "url");
		String maxResID = securedResMapper.retrieveMaxResIDByType(map);
		if(maxResID == null || maxResID.isEmpty()) { 
			maxResID = "web-000000";	
		}
		
		int idx = Integer.parseInt(maxResID.substring(4, maxResID.length()));
		map.put("res_id", String.format("web-%06d", idx + 1));
		logger.debug("next secured resource id: " + map.get("res_id"));
		map.put("res_name", map.get("menu_name"));
		map.put("res_pattern", map.get("menu_url"));
		map.put("description", map.get("description"));
		map.put("sort_order", map.get("menu_order"));
		securedResMapper.createSecuredResource(map);
		
		// update cached menu info
    	refreshCachedMenu();
	}

	@Override
	public void updateMenuInfo(Map<String, Object> map) throws Exception {
		menuMapper.updateMenu(map);
		// update cached menu info
    	refreshCachedMenu();
	}

	@Override
	public void deleteMenuInfo(Map<String, Object> map) throws Exception {
//		authMapper.deleteUserAuthByMenuSeq(map);
		menuMapper.deleteMenu(map);
		
		// update cached menu info
    	refreshCachedMenu();
	}

	@Override
	public List<MenuVO> getMenuInfoByAuth(String userID) throws Exception {
		logger.debug("param: " + userID);
		return getMenu(userID);
//		List<MenuVO> menuInfo = getMenu(userID);
//		if(menuInfo == null) {
//			refreshCachedMenu(userID);
//		}
//		return menuInfo;
	}
	
	@Override
	public List<MenuVO> getLoggedMenuInfo() throws Exception {
		String userID = userService.getLoginUserInfo().getUsername();
		return getMenuInfoByAuth(userID);
	}

	@Override
	public MenuVO getLoggedMenuVoByMenuSeq(long seq) throws Exception {
		int idx = -1;
		List<MenuVO> menuInfo = getMenu(userService.getLoginUserInfo().getUsername());
		if(menuInfo != null) {
			idx = menuInfo.indexOf(new MenuVO(seq));
			if(idx < 0)
				return null;
			return menuInfo.get(idx);
		}
		return null;
	}
//	
//	@Override
//	public MenuVO getLoggedMenuVoByMenuID(String menuID) throws Exception {
//		int idx = -1;
//		List<MenuVO> menuInfo = getMenu(userService.getLoginUserInfo().getUsername());
//		if(menuInfo != null) {
//			idx = menuInfo.indexOf(new MenuVO(menuID));
//			if(idx < 0)
//				return null;
//			return menuInfo.get(idx);
//		}
//		return null;
//	}
//	
//	@Override
//	public MenuVO getLoggedMenuVoByBBS(String uid) throws Exception {
//		int idx = -1;
//		List<MenuVO> menuInfo = getMenu(userService.getLoginUserInfo().getUsername());
//		if(menuInfo != null) {
//			MenuVO vo = new MenuVO();
//			vo.setBbs_uid(uid);
//			idx = menuInfo.indexOf(vo);
//			if(idx < 0)
//				return null;
//			return menuInfo.get(idx);
//		}
//		return null;
//	}

	@Override
	public void refreshCachedMenu() throws Exception {
		refreshCachedMenu(userService.getLoginUserInfo().getUsername());
	}
	
	@Override
//	public void refreshCachedMenu(Map<String, Object> map) throws Exception {
	public void refreshCachedMenu(String userID) throws Exception {
		logger.debug("refresh cached menu data: {}", userID);
//		logger.debug("refresh before: " + getMenu(userID));
		Map<String, Object> map = new HashMap<>();
		map.put("user_id", userID);
		setMenu(userID, menuMapper.selectMenusByAuth(map));
//		logger.debug("refresh after: " + getMenu(userID));
	}

	@Override
	public void removeCachedMenu(String userID) throws Exception {
		loggedMenuMap.remove(userID);
	}
}
