package egovframework.lqs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.vo.KendoResponseVO;
import egovframework.common.controller.SessionController;
import egovframework.lqs.service.DisfFacilityService;
import egovframework.system.service.MenuService;

@RequestMapping("/facility")
@Controller
public class FacilityController {
	Logger logger = LoggerFactory.getLogger(FacilityController.class.getName());
	
	@Resource(name = "disfFacilityService")
	private DisfFacilityService facilityService;
	
	@Resource(name = "menuService")
	private MenuService menuService;

	/**
	 * 
	 * @param model
	 * @param seq(seq == null:create, seq != null:modify(exist), form(not exist))
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/form.do")
	public ModelAndView facilityFormView(Model model, HttpSession session, @RequestParam(value="seq", required=false) Long seq)  throws Exception {
		logger.debug("param: farm_seq={}", seq);
		ModelAndView mav = new ModelAndView("lqs/facility/facilityForm");
		/*
		 *  seq == null : create
		 *  seq
		 */
		if(seq != null) {
			if(facilityService.getDisfFacility(seq).get("cre_dt") != null) {
				mav.addObject("facility_seq", seq);
			} else {
				mav.setViewName("redirect:/facility.do");
			}
		} else {
			mav.addObject("facility_seq", 0);
		}
		mav.addObject("menu", menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString())));
		return mav;
	}
	
	@RequestMapping({ "/list.do" })
	public @ResponseBody JSONPObject list(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/list.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, facilityService.getDisfFacilities(EgovWebUtil.parseJsonToMap(params)));
	}
	
	@RequestMapping({ "/read.do" })
	public @ResponseBody JSONPObject read(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/read.do");
		logger.debug("params: " + params);
		try {
			return new JSONPObject(c, facilityService.getDisfFacilities(EgovWebUtil.parseJsonToMap(params)));
		} catch (Exception e) {
			return new JSONPObject(c, new KendoResponseVO(e.getMessage()));
		}
	}
	
	@RequestMapping(value = "/create.do")
	public @ResponseBody JSONPObject create(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/create.do");
		List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
		logger.debug("params:" + params); 
		
		try {
			for(int i=0; i < params.size(); i++){
				facilityService.insertDisfFacility(params.get(i));
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
				facilityService.updateDisfFacility(params.get(i));
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
				facilityService.deleteDisfFacility(params.get(i));
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