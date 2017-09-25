package egovframework.system.controller;

import java.util.HashMap;
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
import egovframework.system.service.LoginHistoryService;

@RequestMapping("/sm/history/login")
@Controller
public class HistoryLoginController {
	Logger logger = LoggerFactory.getLogger(HistoryLoginController.class.getName());

	@Resource(name = "loginHistoryService")
	private LoginHistoryService loginHistoryService;

	/**
	 * 사용자 정보를 조회함
	 * 
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/read.do")
	public @ResponseBody JSONPObject selectMngLoginLogJsonp(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("params:" + params);
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			Map<String, Object> param = EgovWebUtil.parseJsonToMap(params);
			rtnMap.put("rtnList", loginHistoryService.getLoginHistory(param));
			rtnMap.put("total", loginHistoryService.getLoginHistoryCount(param));

		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}
}