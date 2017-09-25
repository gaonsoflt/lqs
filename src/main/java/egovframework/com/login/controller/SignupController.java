package egovframework.com.login.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.system.config.Config;
import egovframework.system.config.ConfigID;
import egovframework.system.service.SignupService;

@Controller
public class SignupController {
	Logger logger = LoggerFactory.getLogger(SignupController.class.getName());

    @Resource(name = "signupService")
    private SignupService signupService;
    
	@RequestMapping(value = "/signup.do")
	public ModelAndView signup(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("com/signup/signup");
		mav.addObject("title", Config.getConfigValue(ConfigID.TITLE));
		mav.addObject("logo", Config.getConfigValue(ConfigID.LOGO));
		return mav;
	}
	
	@RequestMapping(value = "/signup/register.do", method = RequestMethod.POST)
	public ModelAndView register(HttpServletRequest request, RedirectAttributes redirectAttr) throws Exception {
		HashMap<String, Object> param = new HashMap<String, Object>();
		try {
			param.put("user_id", request.getParameter("user_id"));
			param.put("user_name", request.getParameter("username"));
			param.put("password", request.getParameter("password"));
			param.put("phone", request.getParameter("phone"));
			param.put("birthday", request.getParameter("birthday"));
			param.put("email", request.getParameter("email"));
			signupService.registerSignupUser(param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttr.addAttribute("email", param.get("email")); 
		ModelAndView mav = new ModelAndView("redirect:/signup/complete.do");
		return mav;
	}
	
	@RequestMapping(value = "/signup/complete.do")
	public ModelAndView signupComplete(@RequestParam(value="email", required=false) String email) throws Exception {
		ModelAndView mav = new ModelAndView("com/signup/complete");
		mav.addObject("email", email);
		return mav;
	}
	
	@RequestMapping(value = "/signup/confirm.do", method = RequestMethod.GET)
	public ModelAndView confirmEmail(HttpServletRequest request, @RequestParam(value="uid", required=true) String uuid) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/signup/unconfirmed.do");
		try {
			if(signupService.confirmEmail(uuid)) {
				// TODO: approve Signup
//				signupService.approveSignupUser(uuid);
				mav = new ModelAndView("redirect:/signup/confirmed.do");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value = "/signup/confirmed.do")
	public ModelAndView confirmed(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("com/signup/confirmed");
		mav.addObject("confirmed", true);
		return mav;
	}
	
	@RequestMapping(value = "/signup/unconfirmed.do")
	public ModelAndView unconfirmed(Model model) throws Exception {
		ModelAndView mav = new ModelAndView("com/signup/confirmed");
		mav.addObject("confirmed", false);
		return mav;
	}
}

