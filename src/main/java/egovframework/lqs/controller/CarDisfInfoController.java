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
import egovframework.lqs.service.CarDisfInfoService;

@RequestMapping("/car/disf")
@Controller
public class CarDisfInfoController {
	Logger logger = LoggerFactory.getLogger(CarDisfInfoController.class.getName());
	
	@Resource(name = "carDisfInfoService")
	private CarDisfInfoService carDisfInfoService;

	@RequestMapping({ "/list.do" })
	public @ResponseBody JSONPObject list(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/list.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, carDisfInfoService.getCarDisfInfo(EgovWebUtil.parseJsonToMap(params)));
	}
	
	@RequestMapping(value = "/create.do")
	public @ResponseBody JSONPObject create(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/create.do");
		List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
		logger.debug("params:" + params); 
		
		try {
			for(int i=0; i < params.size(); i++){
				carDisfInfoService.insertCarDisfInfo(params.get(i));
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
				carDisfInfoService.updateCarDisfInfo(params.get(i));
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