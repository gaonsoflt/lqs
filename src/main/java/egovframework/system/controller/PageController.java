package egovframework.system.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.bbs.service.BBSContentService;
import egovframework.common.annotation.InnerPage;
import egovframework.common.controller.SessionController;
import egovframework.lqs.service.FarmService;
import egovframework.system.config.Config;
import egovframework.system.config.ConfigID;
import egovframework.system.service.AuthService;
import egovframework.system.service.BBSService;
import egovframework.system.service.MenuService;
import egovframework.system.vo.MenuVO;

@Controller
public class PageController {
	Logger logger = LoggerFactory.getLogger(PageController.class.getName());
	
	@Resource(name = "menuService")
	private MenuService menuService;
	
	@Resource(name = "authService")
	private AuthService authService;
	

	@RequestMapping(value = "/main.do")
	public String login(Model model, HttpSession session) throws Exception {
		logger.debug("....................................................../main.do");
		// 24 = dashboard: menu_seq
		session.setAttribute(SessionController.CURRENT_MENU, "24");
		return "redirect:/dashboard.do";
	}

	@InnerPage(name = "대시보드", id = "dashboard")
	@RequestMapping(value = "/dashboard.do")
	public ModelAndView showDashboardView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("system/dashboard");
		MenuVO menu = menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString()));
		mav.addObject("menu", menu);
//		mav.addObject("auth", authService.getPageAuthByLogged(menu.getActiveMenuSeq()));
		return mav;
	}

	/*
	 * BBS
	 */
	@Resource(name = "bBSService")
	private BBSService bbsService;
	
	@Resource(name = "bBSBoardService")
	private BBSContentService bbsContentService;
	
	@RequestMapping(value = "/bbs/board.do")
	public ModelAndView bbsCommonView(Model model, HttpSession session, @RequestParam(value="bbs", required=true) String uid)  throws Exception {
		logger.debug("param: bbs=" + uid);
		ModelAndView mav = new ModelAndView("bbs/bbs");
		Map<String, Object> bbsInfo = bbsService.getBBS(uid);
		mav.addObject("bbsInfo", bbsInfo);
		MenuVO menu = menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString()));
		mav.addObject("menu", menu);
		return mav;
	}
	
	@RequestMapping(value = "/bbs/board/form.do")
	public ModelAndView bbsCommonView(Model model, HttpSession session, @RequestParam(value="bbs", required=true) String uid, @RequestParam(value="con", required=false) Long seq)  throws Exception {
		logger.debug("param: bbs_id=" + uid + ", content_seq=" + seq);
		ModelAndView mav = new ModelAndView("bbs/bbsForm");
		Map<String, Object> bbsInfo = bbsService.getBBS(uid);
		mav.addObject("bbsInfo", bbsInfo);
		if(seq != null) {
			mav.addObject("contentInfo", bbsContentService.getContent(uid, seq));
		}
		MenuVO menu = menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString()));
		mav.addObject("menu", menu);
		// TODO: this auth value for delete reply(if get a solution, remove under code)
		mav.addObject("auth", authService.getPageAuthByLogged(menu.getActiveMenuSeq()));
		return mav;
	}
	
	/*
	 * LQS
	 */
	@InnerPage(name = "농장정보", id = "farm")
	@RequestMapping(value = "/farm.do")
	public ModelAndView farmView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("lqs/farm/farm");
		mav.addObject("menu", menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString())));
		return mav;
	}
	
	@Resource(name = "farmService")
	private FarmService farmService;
	
	/**
	 * 
	 * @param model
	 * @param seq(seq == null:create, seq != null:modify(exist), form(not exist))
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/farm/form.do")
	public ModelAndView farmFormView(Model model, HttpSession session, @RequestParam(value="seq", required=false) Long seq)  throws Exception {
		logger.debug("param: farm_seq={}", seq);
		ModelAndView mav = new ModelAndView("lqs/farm/farmForm");
		/*
		 *  seq == null : create
		 *  seq
		 */
		if(seq != null) {
			if(farmService.getFarm(seq).get("cre_dt") != null) {
				mav.addObject("farm_seq", seq);
			} else {
				mav.setViewName("redirect:/farm.do");
			}
		} else {
			mav.addObject("farm_seq", 0);
		}
		MenuVO menu = menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString()));
		mav.addObject("menu", menu);
		return mav;
	}
	
	@InnerPage(name = "차량정보", id = "car")
	@RequestMapping(value = "/car.do")
	public ModelAndView carView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("lqs/car/car");
		mav.addObject("menu", menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString())));
		return mav;
	}
	
	@InnerPage(name = "차량소독정보", id = "carDisf")
	@RequestMapping(value = "/car/disf.do")
	public ModelAndView carDisfView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("lqs/car/disf");
		mav.addObject("menu", menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString())));
		return mav;
	}
	
	@InnerPage(name = "인식기정보", id = "lpr")
	@RequestMapping(value = "/lpr.do")
	public ModelAndView lprView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("lqs/facility/lpr");
		mav.addObject("menu", menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString())));
		return mav;
	}
	
	@InnerPage(name = "소독시설정보", id = "facility")
	@RequestMapping(value = "/facility.do")
	public ModelAndView facilityView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("lqs/facility/facility");
		mav.addObject("menu", menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString())));
		return mav;
	}
	
	
	/*
	 * Systemmgr
	 */
	@InnerPage(name = "공통코드", id = "systemCode")
	@RequestMapping(value = "/sm/code.do")
	public ModelAndView codeView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("system/commonCode");
		mav.addObject("menu", menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString())));
		return mav;
	}
	
	@InnerPage(name = "로그인히스토리", id = "systemHisLogin")
	@RequestMapping(value = "/sm/history/login.do")
	public ModelAndView loginHistoryView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("system/loginHis");
		mav.addObject("menu", menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString())));
		return mav;
	}

	@InnerPage(name = "메뉴정보", id = "systemMenu")
	@RequestMapping(value = "/sm/menu.do")
	public ModelAndView menuView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("system/menu");
		mav.addObject("menu", menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString())));
		return mav;
	}
	
	@InnerPage(name = "권한", id = "systemAuth")
	@RequestMapping(value = "/sm/auth.do")
	public ModelAndView userAuthView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("system/auth");
		MenuVO menu = menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString()));
		mav.addObject("menu", menu);
		// TODO: this auth value for kendo swith ui(if get a solution, remove under code)
		mav.addObject("auth", authService.getPageAuthByLogged(menu.getActiveMenuSeq()));

		return mav;
	}
	
	@InnerPage(name = "사용자그룹", id = "systemGroupUser")
	@RequestMapping(value = "/sm/groupuser.do")
	public ModelAndView userGroupView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("system/groupUser");
		mav.addObject("menu", menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString())));
		return mav;
	}
	
	@InnerPage(name = "권한리소스", id = "systemResource")
	@RequestMapping(value = "/sm/auth/resource.do")
	public ModelAndView resourceView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("system/securedRes");
		mav.addObject("menu", menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString())));
		return mav;
	}
	
	@InnerPage(name = "사용자", id = "systemUser")
	@RequestMapping(value = "/sm/user.do")
	public ModelAndView userView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("system/user");
		mav.addObject("menu", menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString())));
		return mav;
	}
	
	@InnerPage(name = "게시판관리", id = "systemBBS")
	@RequestMapping(value = "/sm/bbs.do")
	public ModelAndView bbsView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("system/bbs");
		mav.addObject("menu", menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString())));
		return mav;
	}
	
	@InnerPage(name = "환경설정", id = "systemConfig")
	@RequestMapping(value = "/sm/config.do")
	public ModelAndView configView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("system/config");
		mav.addObject("menu", menuService.getLoggedMenuVoByMenuSeq(Long.valueOf(session.getAttribute(SessionController.CURRENT_MENU).toString())));
		
		Map<String, Object> result = new HashMap<>();
		result.put("title", Config.getConfigValue(ConfigID.TITLE));
		result.put("logo", Config.getConfigValue(ConfigID.LOGO));
		mav.addObject("config", result);
		return mav;
	}
	
	
	
	/*
	 * test
	 */
	@InnerPage(name = "테스트페이지", id = "test")
	@RequestMapping(value = "/sm/test.do")
	public ModelAndView testView(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("system/test");
		return mav;
	}
}
