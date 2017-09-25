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
import egovframework.system.service.CodeService;

@RequestMapping("/sm/code")
@Controller
public class CodeController {
	Logger logger = LoggerFactory.getLogger(CodeController.class.getName());

	@Resource(name = "codeService")
	private CodeService codeService;

	/**
	 * 공통코드의 마스터 정보를 조회함
	 * 
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/readParent.do")
	public @ResponseBody JSONPObject readParent(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("params:" + params);
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<Map<String, Object>> rtnList = codeService.getParentCode(EgovWebUtil.parseJsonToMap(params));
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}

	/**
	 * 공통코드의 디테일 정보를 조회함
	 * 
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/readChild.do")
	public @ResponseBody JSONPObject readChild(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("params:" + params);
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			Map<String, Object> param = EgovWebUtil.parseJsonToMap(params);
			rtnMap.put("rtnList", codeService.getChildCode(param));
			rtnMap.put("total", codeService.getCodeCount(param));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}

	/**
	 * 공통코드 정보를 저장함
	 * 
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/create.do")
	public @ResponseBody JSONPObject insertMngCodeInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("----------------> /create.do");
		logger.debug("models:" + models);
		try {
			List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
			
			for (int i = 0; i < params.size(); i++) {
				codeService.insertCode(params.get(i));
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
	 * 공통코드 정보를 수정함
	 * 
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/update.do")
	public @ResponseBody JSONPObject updateMngCodeInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("----------------> /update.do");
		logger.debug("models:" + models);
		try {
			List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
			
			for (int i = 0; i < params.size(); i++) {
				codeService.updateCode(params.get(i));
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
	 * 공통코드 정보를 삭제함
	 * 
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/delete.do")
	public @ResponseBody JSONPObject deleteMngCodeInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("----------------> /delete.do");
		logger.debug("models:" + models);
		try {
			List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
			
			for (int i = 0; i < params.size(); i++) {
				codeService.deleteCode(params.get(i));
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