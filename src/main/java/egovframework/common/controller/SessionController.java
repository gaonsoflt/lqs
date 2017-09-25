package egovframework.common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@SessionAttributes("current_menu") // Model.addAttribute();
public class SessionController {
	public static String CURRENT_MENU = "current_menu";
	
	Logger logger = LoggerFactory.getLogger(SessionController.class.getName());

	@RequestMapping(value = "/session/setCurrentMenu.do")
	public ModelAndView setMenuId(Model model, @RequestParam("current_menu") String currentMenu) throws Exception {
		logger.debug("set session: current menu=" + currentMenu);
		model.addAttribute("current_menu", currentMenu);
		return null;
	}

	@RequestMapping(value = "/redirect.do", method = RequestMethod.GET)
	public ModelAndView redirect(HttpSession session, HttpServletRequest request) throws Exception {
		logger.info("................................... redirecting");
		RedirectView redirectView = new RedirectView("sm/user/view.do");
		redirectView.setContextRelative(true);
		redirectView.setExposeModelAttributes(false);
		ModelAndView mav = new ModelAndView(redirectView);

		return mav;
	}
	
	@RequestMapping(value = "/error/denied.do")
	public ModelAndView denied(HttpSession session, HttpServletRequest request) throws Exception {
		logger.info("access denied.");
		ModelAndView mav = new ModelAndView("/com/accessDenied");
		return mav;
	}
}