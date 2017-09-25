package egovframework.common.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.service.CommonService;
import egovframework.system.service.AuthService;
import egovframework.system.service.MenuService;
import egovframework.system.vo.MenuVO;

@RequestMapping("/common")
@Controller
public class CommonController {
	Logger logger = LoggerFactory.getLogger(CommonController.class.getName());

	@Resource(name = "commonService")
	private CommonService commonService;

	@RequestMapping(value = "/getSequence.do")
	public ModelAndView getSequence(@RequestParam Map<String, Object> paramMap) throws Exception {
		ModelAndView model = new ModelAndView();
		int seq = commonService.getSequence(paramMap.get("sequence").toString());
		model.addObject("Sequence", seq);
		model.setViewName("jsonView");
		return model;
	}

	/**
	 * 코드ID로 조회
	 * 
	 * @param c
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getCodeListByCdID.do")
	public @ResponseBody JSONPObject getCodeListByCdID(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		List<Map<String, Object>> rtnList = commonService.getCodeListByCdID(EgovWebUtil.parseJsonToMap(params));
		return new JSONPObject(c, rtnList);
	}

	@RequestMapping(value = "/getCodeListByCdIDModel.do")
	public ModelAndView getCodeListByCdIDModel(@RequestParam Map<String, Object> paramMap) throws Exception {
		String list = paramMap.get("list") != null ? paramMap.get("list").toString() : null;
		logger.debug("[BBAEK] params: " + list);
		List<Map<String, Object>> rtnList = new ArrayList<>();
		ModelAndView model = new ModelAndView();

		if (list != null) {
			String[] cdIdList = paramMap.get("list").toString().split(",");

			for (int i = 0; i < cdIdList.length; i++) {
				logger.debug("param: " + cdIdList[i]);
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("CD_ID", cdIdList[i]);

				List<Map<String, Object>> tempList = commonService.getCodeListByCdID(param);
				Iterator<Map<String, Object>> it = tempList.iterator();

				while (it.hasNext()) {
					Map<String, Object> map = it.next();
					rtnList.add(map);
				}
			} // for
		} else {
			rtnList = commonService.getCodeListByCdID(paramMap);
		}

		model.addObject("rtnList", rtnList);
		model.setViewName("jsonView");
		return model;
	}

	/**
	 * kendoAutoComplete 에서 사용함
	 * 
	 * @param c
	 * @param params
	 *            cf. TABLE: "TB_USER_INFO" COLUNM: "USER_NM"
	 * @return
	 * @throws Exception
	 */
//	@RequestMapping(value = "/getAutoComplete.do")
//	@RequestMapping(value = "/getAutoCompleteDatas.do")
//	public @ResponseBody JSONPObject getAutoComplete(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
//		List<Map<String, Object>> rtnList = commonService.getAutoComplete(EgovWebUtil.parseJsonToMap(params));
//		return new JSONPObject(c, rtnList);
//	}

	@RequestMapping(value = "/getTableDataList.do")
	public @ResponseBody JSONPObject getTableDataList(@RequestParam("callback") String c,
			@RequestParam("params") String params) throws Exception {
		List<Map<String, Object>> rtnList = commonService.getTableDataList(EgovWebUtil.parseJsonToMap(params));
		return new JSONPObject(c, rtnList);
	}

	@RequestMapping(value = "/getUsername.do")
	public @ResponseBody JSONPObject getUserAutoComplete(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		List<Map<String, Object>> rtnList = commonService.getUserDatasForAutoComplete();
		return new JSONPObject(c, rtnList);
	}
	
	@RequestMapping(value = "/getCodename.do")
	public @ResponseBody JSONPObject getCodeAutoComplete(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		Map<String, Object> param = EgovWebUtil.parseJsonToMap(params);
		List<Map<String, Object>> rtnList = commonService.getCodeDatas(param.get("CATGR").toString());
		return new JSONPObject(c, rtnList);
	}

	@RequestMapping(value = "/chkExistUser.do")
	public ModelAndView getDuplicateCount(@RequestParam Map<String, Object> params) throws Exception {
		ModelAndView model = new ModelAndView();
		model.addObject("isExisted", 
				commonService.isDuplicationData("SYS_USER_INFO", 
						new String[]{ "USER_ID" }, 
						new String[]{ params.get("id").toString() }
				)
		);
		model.setViewName("jsonView");
		return model;
	}
	
	@Resource(name="authService")
	AuthService authService;
	@Resource(name="menuService")
	MenuService menuService;
	
	@RequestMapping(value = "/getLoggedUserAuth.do", method = RequestMethod.GET)
	public ModelAndView getLoggedUserAuth(@RequestParam("current_menu") String currMenu) throws Exception {
		ModelAndView model = new ModelAndView();
		MenuVO menu = menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(currMenu));
		model.addObject("auth",	authService.getPageAuthByLogged(menu.getActiveMenuSeq()));
		model.setViewName("jsonView");
		return model;
	}
}
