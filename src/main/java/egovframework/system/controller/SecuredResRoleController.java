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
import egovframework.system.service.SecuredResRoleService;

@RequestMapping("/sm/resource/role")
@Controller
public class SecuredResRoleController {
	Logger logger = LoggerFactory.getLogger(SecuredResRoleController.class.getName());
	
	@Resource(name = "securedResRoleService")
	private SecuredResRoleService securedResRoleService;

	@RequestMapping({ "/read.do" })
	public @ResponseBody JSONPObject readRoleSecuredResRole(@RequestParam("callback") String c, @RequestParam("params") String params) throws Exception {
		logger.debug("---------------->/read.do");
		logger.debug("params: " + params);
		return new JSONPObject(c, securedResRoleService.getSecuredResRole(EgovWebUtil.parseJsonToMap(params)));
	}
	
	@RequestMapping(value = "/save.do")
	public @ResponseBody JSONPObject save(@RequestParam("callback") String c, @RequestParam("models") String models, @RequestParam("role_id") String roleID) {
		logger.debug("---------------->/delete.do");
		List<Map<String, Object>> params = EgovWebUtil.parseJsonToList(models);
		logger.debug("params:" + params); 
		
		try {
			for(int i=0; i < params.size(); i++){
				Map<String, Object> param = params.get(i);
				param.put("role_id", roleID);
				securedResRoleService.saveSecuredResRole(param);
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