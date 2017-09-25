package egovframework.lqs.controller;

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
import egovframework.com.vo.KendoResponseVO;
import egovframework.lqs.service.FarmService;

@RequestMapping("/farm")
@Controller
public class FarmController {
	Logger logger = LoggerFactory.getLogger(FarmController.class.getName());
	
	@Resource(name = "farmService")
	private FarmService farmService;

	@RequestMapping({ "/list.do" })
	public @ResponseBody JSONPObject list(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/list.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, farmService.getFarms(EgovWebUtil.parseJsonToMap(params)));
	}
	
	@RequestMapping({ "/read.do" })
	public @ResponseBody JSONPObject read(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/read.do");
		logger.debug("params: " + params);
		try {
			return new JSONPObject(c, farmService.getFarms(EgovWebUtil.parseJsonToMap(params)));
		} catch (Exception e) {
			return new JSONPObject(c, new KendoResponseVO(e.getMessage()));
		}
	}
	

	@RequestMapping({ "/livestock/list.do" })
	public @ResponseBody JSONPObject listLivestock(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/livestock/list.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, farmService.getLivestocksByFarm(Long.valueOf(params)));
	}
	
	
	@RequestMapping(value = "/create.do")
	public @ResponseBody JSONPObject create(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/create.do");
		List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
		logger.debug("params:" + params); 
		
		try {
			for(int i=0; i < params.size(); i++){
				farmService.insertFarm(params.get(i));
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
		List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
		logger.debug("params:" + params); 
		
		try {
			for(int i=0; i < params.size(); i++){
				farmService.updateFarm(params.get(i));
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
		List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
		logger.debug("params:" + params); 
		
		try {
			for(int i=0; i < params.size(); i++){
				farmService.deleteFarm(params.get(i));
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