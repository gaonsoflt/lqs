package egovframework.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.system.service.RoleService;

@RequestMapping("/sm/role")
@Controller
public class RoleController {
	Logger logger = LoggerFactory.getLogger(RoleController.class.getName());
	
	@Resource(name = "roleService")
	private RoleService roleService;
	
	@RequestMapping({ "/read.do" })
	public @ResponseBody JSONPObject read(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/read.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, roleService.getRoles(EgovWebUtil.parseJsonToMap(params)).getRtnList());
	}
	
	@RequestMapping({ "/detail.do" })
	public @ResponseBody JSONPObject detail(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/detail.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, roleService.getRole(params));
	}
	
	@RequestMapping(value = "/create.do")
	public @ResponseBody JSONPObject create(@RequestParam("callback") String c, @RequestParam("models") String models) {
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
	
	@RequestMapping(value = "/update.do")
	public @ResponseBody JSONPObject update(@RequestParam("callback") String c, @RequestParam("models") String models) {
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
	
	@RequestMapping(value = "/delete.do")
	public @ResponseBody JSONPObject delete(@RequestParam("callback") String c, @RequestParam("models") String models) {
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
}