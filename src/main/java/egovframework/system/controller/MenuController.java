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
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.service.CommonService;
import egovframework.system.service.MenuService;
import egovframework.system.vo.MenuVO;

@RequestMapping("/sm/menu")
@Controller
public class MenuController {
Logger logger = LoggerFactory.getLogger(MenuController.class.getName());

	@Resource(name = "menuService")
	private MenuService menuService;
	

	/**
	 * 조회
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/readHierarchy.do")
	public @ResponseBody JSONPObject hierarchyList(
			@RequestParam(value="menu_seq", required=false) Long menuSeq, 
			@RequestParam(value="callback", required=false) String c, 
			@RequestParam(value="params", required=false) String params) throws Exception {
		logger.debug("----------------> /readHierarchy.do");
		logger.debug("params: " + params); 
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		Map<String, Object> param = new HashMap<>(); 
		try {
			if(params != null) {
				param = EgovWebUtil.parseJsonToMap(params);
			} else {
				param.put("menu_seq", menuSeq);
			}
			List<Map<String, Object>> rtnList = menuService.getHierarchicalMenuInfo(param);
			System.out.println(rtnList);
			rtnMap.put("rtnList", rtnList);
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}
	
	@RequestMapping(value = "/read.do")
	public @ResponseBody JSONPObject list(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("----------------> /read.do");
		logger.debug("params: " + params); 
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<Map<String, Object>> rtnList = menuService.getMenuInfoList(EgovWebUtil.parseJsonToMap(params));
			System.out.println(rtnList);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}
	
	
	/**
	 * 의료상담 접수 정보를 저장함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/create.do")
	public @ResponseBody JSONPObject createMenuInfo(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("----------------> /create.do");
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList: " + paramMapList); 
		try {
			for(int i=0; i < paramMapList.size(); i++){
				Map<String, Object> paramMap = paramMapList.get(i);
				System.out.println("paramMap: " + paramMap);
				// insert call
				menuService.createMenuInfo(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}

	/**
	 * 의료상담 접수  정보 수정함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/update.do")
	public @ResponseBody JSONPObject updateMenuInfo(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("----------------> /update.do");
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList: " + paramMapList); 
		try {
			for(int i=0; i < paramMapList.size(); i++){
				Map<String, Object> paramMap = paramMapList.get(i);
				System.out.println("paramMap: " + paramMap);
				menuService.updateMenuInfo(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	
	/**
	 * 의료상담 접수 정보를 삭제함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/delete.do")
	public @ResponseBody JSONPObject deleteMenuInfo(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("----------------> /delete.do");
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList: " + paramMapList); 
		try {
			for(int i=0; i < paramMapList.size(); i++){
				Map<String, Object> paramMap = paramMapList.get(i);
				System.out.println("paramMap: " + paramMap);
				// delete call
				menuService.deleteMenuInfo(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	/**
	 * 사이트에 메뉴를 그리기 위해서 호출하는 함수
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/readMenusByAuth.do")
	public ModelAndView getMenuInfoByUserAuth(@RequestParam Map<String,Object> paramMap) throws Exception {
		ModelAndView model = new ModelAndView();
		List<MenuVO> rtnList = menuService.getLoggedMenuInfo();
		logger.debug("rtnList: " + rtnList);
		model.addObject("rtnList", rtnList);
		model.setViewName("jsonView");
		return model; 
	}
	
	
	@RequestMapping(value = "/getInnerPageList.do")
	public @ResponseBody JSONPObject getInnerPageList(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		return new JSONPObject(c, menuService.getInnerPage());
	}
	
	@RequestMapping(value = "/getParentMenuList.do")
	public @ResponseBody JSONPObject getParentMenuList(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		return new JSONPObject(c, menuService.getParentMenuInfoList(null));
	}
	
	@Resource(name = "commonService")
	private CommonService commonService;
	
	@RequestMapping(value = "/getBBSList.do")
	public @ResponseBody JSONPObject getBBSList(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		List<Map<String, Object>> rtnList = commonService.getTableDataList("sys_bbs_info", "bbs_name", "bbs_uid");
		return new JSONPObject(c, rtnList);
	}
	
//	@RequestMapping(value = "/notify.do")
//	public void refreshConfig() {
//		try {
//	    	CmmLoginUser userDetails = (CmmLoginUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//	    	HashMap<String,Object> paramMap = new HashMap<>(); 
//	    	paramMap.put("USER_NO", userDetails.getUserseq());
//			logger.debug("[BBAEK] refresh before: " + menuService.getMenuVo());
//			menuService.refreshMenu(paramMap);
//			logger.debug("[BBAEK] refresh after: " + menuService.getMenuVo());
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
}