package egovframework.system.controller;

import java.util.HashMap;

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
import egovframework.system.service.GroupUserService;

@RequestMapping("/sm/groupuser")
@Controller
public class GroupUserController {
	Logger logger = LoggerFactory.getLogger(GroupUserController.class.getName());
	
	@Resource(name = "groupUserService")
	private GroupUserService groupUserService;
	
	@RequestMapping({ "readNoGroupUsers.do" })
	public @ResponseBody JSONPObject readNoGroupUsers(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/readNoGroupUsers.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, groupUserService.getNoGroupUsers(EgovWebUtil.parseJsonToMap(params)));
	}
	
	@RequestMapping({ "readGroupUsers.do" })
	public @ResponseBody JSONPObject readGroupUsers(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/readGroupUsers.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, groupUserService.getGroupUsers(EgovWebUtil.parseJsonToMap(params)));
	}
	
	@RequestMapping({ "readLoginUserGroup.do" })
	public @ResponseBody JSONPObject readLoginUserGroup(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/readLoginUserGroup.do");
		return new JSONPObject(c, groupUserService.getGroupsByLoginUser());
	}
	
	@RequestMapping(value = "/update.do")
	public ModelAndView updateGroupUser(@RequestParam HashMap<String, Object> paramMap) throws Exception {
		logger.debug("---------------->/updateGroupUser.do");
		logger.debug("===============================params: " + paramMap);
		ModelAndView model = new ModelAndView();
		int executeCnt = 0;
		try {
			executeCnt = groupUserService.saveGroupUser(paramMap);
			logger.debug("executeCnt: " + executeCnt);
			model.addObject("result", executeCnt);
		} catch (Exception e) {
			e.printStackTrace();
			model.addObject("error", e.toString());
		}
		model.setViewName("jsonView");
		return model;
	}
}