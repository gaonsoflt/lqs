package egovframework.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.login.security.ReloadableFilterInvocationSecurityMetadataSource;
import egovframework.system.service.AuthService;
import egovframework.system.service.MenuService;
import egovframework.system.service.RoleService;

@RequestMapping("/sm/auth")
@Controller
public class AuthController {
	Logger logger = LoggerFactory.getLogger(AuthController.class.getName());
	
	@Resource(name = "authService")
	private AuthService authService;
	
	@Resource(name = "roleService")
	private RoleService roleService;
	
	@Resource(name = "menuService")
	private MenuService menuService;
	
	@RequestMapping({ "readAuth.do" })
	public @ResponseBody JSONPObject readRoleAuth(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/readAuth.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, authService.getRoleAuth(params));
	}
	
//	@RequestMapping(value = "/create.do")
//	public @ResponseBody JSONPObject create(@RequestParam("callback") String c, @RequestParam("models") String models) {
//		logger.debug("---------------->/create.do");
//		List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
//		logger.debug("params:" + params); 
//
//		try {
//			for(int i=0; i < params.size(); i++){
//				authService.insertAuth(params.get(i));
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			Map<String, Object> rtnMap = new HashMap<String, Object>();
//			rtnMap.put("error", e.toString());
//			return new JSONPObject(c, rtnMap);
//		}
//		return new JSONPObject(c, models);
//	}
	
//	@RequestMapping(value = "/update.do")
//	public @ResponseBody JSONPObject update(@RequestParam("callback") String c, @RequestParam("models") String models) {
//		logger.debug("---------------->/delete.do");
//		List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
//		logger.debug("params:" + params); 
//		
//		try {
//			for(int i=0; i < params.size(); i++){
//				authService.updateAuth(params.get(i));
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			Map<String, Object> rtnMap = new HashMap<String, Object>();
//			rtnMap.put("error", e.toString());
//			return new JSONPObject(c, rtnMap);
//		}
//		return new JSONPObject(c, models);
//	}
	
	@RequestMapping(value = "/save.do")
	public @ResponseBody JSONPObject save(@RequestParam("callback") String c, @RequestParam("models") String models, @RequestParam("params") String targetID) {
		logger.debug("---------------->/save.do");
		List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
		logger.debug("params:" + params); 
		
		try {
			for(int i=0; i < params.size(); i++){
				Map<String, Object> param = params.get(i);
				param.put("target_id", targetID);
				authService.saveAuth(param);
			}
			menuService.refreshCachedMenu();
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
//	@RequestMapping(value = "/delete.do")
//	public @ResponseBody JSONPObject delete(@RequestParam("callback") String c, @RequestParam("models") String models) {
//		logger.debug("---------------->/delete.do");
//		List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
//		logger.debug("params:" + params); 
//		
//		try {
//			for(int i=0; i < params.size(); i++){
//				authService.deleteAuth(params.get(i));
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			Map<String, Object> rtnMap = new HashMap<String, Object>();
//			rtnMap.put("error", e.toString());
//			return new JSONPObject(c, rtnMap);
//		}
//		return new JSONPObject(c, models);
//	}
	
	
	@RequestMapping({ "/role/read.do" })
	public @ResponseBody JSONPObject readRole(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/read.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, roleService.getRoles(EgovWebUtil.parseJsonToMap(params)).getRtnList());
	}
	
	@RequestMapping({ "/role/detail.do" })
	public @ResponseBody JSONPObject detailRole(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/detail.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, roleService.getRole(params));
	}
	
	@RequestMapping(value = "/role/create.do")
	public @ResponseBody JSONPObject createRole(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/create.do");
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				roleService.insertRole(paramMapList.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	@RequestMapping(value = "/role/update.do")
	public @ResponseBody JSONPObject updateRole(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/delete.do");
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList); 
		
		try {
			for(int i=0; i < paramMapList.size(); i++){
				roleService.updateRole(paramMapList.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	@RequestMapping(value = "/role/delete.do")
	public @ResponseBody JSONPObject deleteRole(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/delete.do");
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList); 
		
		try {
			for(int i=0; i < paramMapList.size(); i++){
				roleService.deleteRole(paramMapList.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	@RequestMapping(value = "/role/group/read.do")
	public @ResponseBody JSONPObject readRolesGroup(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("params: " + params);
		return new JSONPObject(c, authService.getRolesGroup(params));
	}
	
    @Autowired
    private ReloadableFilterInvocationSecurityMetadataSource metadataSource;
	
	@RequestMapping(value = "/role/group/save.do")
	public @ResponseBody JSONPObject saveRolesGroup(@RequestParam("callback") String c, @RequestParam("models") String models, @RequestParam("role_id") String roleID) {
		logger.debug("---------------->/save.do");
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList); 
		
		try {
			for(int i=0; i < paramMapList.size(); i++){
				Map<String, Object> param = paramMapList.get(i);
				param.put("role_id", roleID);
				authService.saveRolesGroup(param);
			}
			menuService.refreshCachedMenu();
			logger.debug("reload authorities");
	    	metadataSource.reload();
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	@RequestMapping(value = "/role/user/read.do")
	public @ResponseBody JSONPObject readRolesUser(@RequestParam("callback") String c, @RequestParam("role_id") String roleID, @RequestParam("group_id") String groupID) throws Exception {
		logger.debug("params: {}, {}", roleID, groupID);
		return new JSONPObject(c, authService.getRolesUserByGroup(roleID, groupID));
	}
	
	@RequestMapping(value = "/role/user/save.do")
	public @ResponseBody JSONPObject saveRolesUser(@RequestParam("callback") String c, @RequestParam("models") String models, @RequestParam("role_id") String roleID) {
		logger.debug("---------------->/save.do");
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList); 
		
		try {
			for(int i=0; i < paramMapList.size(); i++){
				Map<String, Object> param = paramMapList.get(i);
				param.put("role_id", roleID);
				authService.saveRolesUser(param);
			}
			menuService.refreshCachedMenu();
			logger.debug("reload authorities");
	    	metadataSource.reload();
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
}