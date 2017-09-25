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
import egovframework.system.service.UserService;

@RequestMapping("/sm/user")
@Controller
public class UserController {
Logger logger = LoggerFactory.getLogger(UserController.class.getName());
    
	@Resource(name = "userService")
	private UserService userService;


	/**
	 * 사용자 정보를 조회함
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/read.do")
	public @ResponseBody JSONPObject read(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("params:" + params); 
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		Map<String, Object> param = EgovWebUtil.parseJsonToMap(params);
		try {
			rtnMap.put("rtnList", userService.getUsers(param));
			rtnMap.put("total", userService.getUsersCount(param));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}
	

	/**
	 * 사용자 정보를 저장함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/create.do")
	public @ResponseBody JSONPObject create(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/create.do");
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				userService.insertUser(paramMapList.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	/**
	 * 사용자 정보를 수정함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/update.do")
	public @ResponseBody JSONPObject update(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/update.do");
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				userService.updateUser(paramMapList.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	
	/**
	 * 사용자 정보를 삭제함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/delete.do")
	public @ResponseBody JSONPObject delete(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/delete.do");
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:" + paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				userService.deleteUser(paramMapList.get(i));
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