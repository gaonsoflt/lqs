package egovframework.system.controller;

import java.io.File;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import egovframework.system.config.Config;
import egovframework.system.service.ConfigService;

@RequestMapping("/sm/config")
@Controller
public class ConfigController {
	Logger logger = LoggerFactory.getLogger(ConfigController.class.getName());

	@Resource(name = "configService")
	private ConfigService configService;

	@Autowired
	private Config config;

	// @RequestMapping(value = "/read.do")
	// public @ResponseBody JSONPObject read(@RequestParam("callback") String c,
	// @RequestParam("params") String params) {
	// logger.debug("params:" + params);
	// Map<String, Object> rtnMap = new HashMap<String, Object>();
	// Map<String, Object> result = new HashMap<>();
	// try {
	// result.put("title", Config.getConfigValue(ConfigID.TITLE));
	// result.put("logo", Config.getConfigValue(ConfigID.LOGO));
	// rtnMap.put("config", result);
	// } catch (Exception e) {
	// e.printStackTrace();
	// rtnMap.put("error", e.toString());
	// }
	// return new JSONPObject(c, rtnMap);
	// }

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/save.do", method = RequestMethod.POST)
	public ModelAndView save(HttpServletRequest request, @RequestParam(value = "logo", required = false) MultipartFile logoFile) throws Exception {
		try {
			Map<String, Object> params = request.getParameterMap();
			if(!logoFile.isEmpty()) {
				String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
				String attachPath = "resource/images/logo/";
				String fileName = logoFile.getOriginalFilename();
//				logoFile.transferTo(new File(contextRoot + attachPath + "logo" + fileName.substring(fileName.indexOf("."), fileName.length())));
				logoFile.transferTo(new File(contextRoot + attachPath + fileName));
				params.put("logo", "/" + attachPath + fileName);
			}
			configService.saveConfig(params);
			config.init();
			return new ModelAndView("redirect:/sm/config.do");
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("/egovframework/cmmn/bizError");
		}
	}
}