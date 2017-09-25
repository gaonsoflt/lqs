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
import egovframework.system.service.BBSService;

@RequestMapping("/sm/bbs")
@Controller
public class BBSController {
Logger logger = LoggerFactory.getLogger(BBSController.class.getName());
    
	@Resource(name = "bBSService")
	private BBSService bbsService;

	@RequestMapping(value = "/read.do")
	public @ResponseBody JSONPObject read(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("---------------->/read.do");
		try {
			return new JSONPObject(c, bbsService.getBBSList(EgovWebUtil.parseJsonToMap(params)));
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
	}
	
	@RequestMapping(value = "/readNotUse.do")
	public @ResponseBody JSONPObject readNotUse(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("---------------->/readNotUse.do");
		try {
			return new JSONPObject(c, bbsService.getNotMenuBBS());
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
	}
	
	@RequestMapping(value = "/create.do")
	public @ResponseBody JSONPObject create(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/create.do");
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
			int execute = bbsService.insertBBS(params);
			rtnMap.put("execute", execute);
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}
	
	@RequestMapping(value = "/update.do")
	public @ResponseBody JSONPObject updateMngUserInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/update.do");
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
			int execute = bbsService.updateBBS(params);
			rtnMap.put("execute", execute);
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}
	
	@RequestMapping(value = "/delete.do")
	public @ResponseBody JSONPObject deleteMngUserInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/delete.do");
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
			int execute = bbsService.deleteBBS(params);
			rtnMap.put("execute", execute);
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}
}