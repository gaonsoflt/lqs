package egovframework.lqs.controller;

import java.util.ArrayList;
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
import egovframework.common.service.CommonService;
import egovframework.lqs.service.LprService;

@RequestMapping("/lpr")
@Controller
public class LprController {
	Logger logger = LoggerFactory.getLogger(LprController.class.getName());
	
	@Resource(name = "lprService")
	private LprService lprService;
	
	@Resource(name = "commonService")
	private CommonService commonService;

	@RequestMapping({ "/list.do" })
	public @ResponseBody JSONPObject list(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/list.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, lprService.getLprs(EgovWebUtil.parseJsonToMap(params)));
	}
	
	@RequestMapping({ "/read.do" })
	public @ResponseBody JSONPObject read(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/read.do");
		logger.debug("params: " + params);
		try {
			return new JSONPObject(c, lprService.getLprs(EgovWebUtil.parseJsonToMap(params)));
		} catch (Exception e) {
			return new JSONPObject(c, new KendoResponseVO(e.getMessage()));
		}
	}

	@RequestMapping(value = "/getLocList.do")
	public @ResponseBody JSONPObject getLocList(@RequestParam("callback") String c, @RequestParam("loc_type") String locType) throws Exception {
		String table = "";
		String textCol = "";
		String valueCol = "";
//		String locType = EgovWebUtil.parseJsonToMap(params).get("loc_type").toString();
		
		if(!locType.isEmpty() && locType != null) {
			if(locType.equals("L")) {
				table = "LQS_DISF_FACILITY";
				textCol = "FACILITY_NAME";
				valueCol = "FACILITY_SEQ";
			} else if(locType.equals("F")) {
				table = "LQS_FARM_INFO";
				textCol = "FARM_NAME";
				valueCol = "FARM_SEQ";
			} 
			return new JSONPObject(c, commonService.getTableDataList(table, textCol, valueCol));
		} else {
			return new JSONPObject(c, new ArrayList<>());
		}
	}

	@RequestMapping(value = "/save.do")
	public @ResponseBody JSONPObject save(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/create.do");
		List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
		logger.debug("params:" + params); 
		
		try {
			for(int i=0; i < params.size(); i++){
				lprService.saveLpr(params.get(i));
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
				lprService.deleteLpr(params.get(i));
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