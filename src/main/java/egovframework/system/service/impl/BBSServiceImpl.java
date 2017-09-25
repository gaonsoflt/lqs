package egovframework.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.bbs.service.impl.BBSContentMapper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.system.service.BBSService;
import egovframework.system.service.MenuService;

@Service("bBSService")
public class BBSServiceImpl extends EgovAbstractServiceImpl implements BBSService {
	Logger logger = LoggerFactory.getLogger(this.getClass().getName());

	@Resource(name = "bBSMapper")
	private BBSMapper bbsMapper;
	
	@Resource(name = "bBSContentMapper")
	private BBSContentMapper bbsContentMapper;
	
	@Resource(name = "menuMapper")
	private MenuMapper menuMapper;
	
	@Resource(name = "systemMgrUserAuthMapper")
	private SystemMgrUserAuthMapper authMapper;
	
	@Resource(name = "menuService")
	private MenuService menuService;

	@Override
	public Map<String, Object> getBBSList(Map<String, Object> param) throws Exception {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		logger.debug("param: " + param);
		rtnMap.put("rtnList", bbsMapper.selectBBSList(param));
		rtnMap.put("total", bbsMapper.selectBBSListCount(param));
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> getBBS(String uid) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("bbs_uid", uid);
		return bbsMapper.selectBBS(param);
	}

	@Override
	public int insertBBS(List<Map<String, Object>> params) throws Exception {
		logger.debug("params:" + params);
		int execute = 0;
		for (int i = 0; i < params.size(); i++) {
			Map<String, Object> param = params.get(i);
			logger.debug("insert bbs reference");
			param.put("bbs_uid", UUID.randomUUID().toString());
			bbsMapper.createBBS(param);
			execute++;
		}
		logger.debug("execute:" + execute);
		return execute;
	}

	@Override
	public int updateBBS(List<Map<String, Object>> params) throws Exception {
		logger.debug("params:" + params);
		int execute = 0;
		for (int i = 0; i < params.size(); i++) {
			Map<String, Object> param = params.get(i);
			logger.debug("update bbs reference");
			execute += bbsMapper.updateBBS(param);
		}
		logger.debug("execute:" + execute);
		return execute;
	}

	@Override
	public int deleteBBS(List<Map<String, Object>> params) throws Exception {
		logger.debug("params:" + params);
		int execute = 0;
		for (int i = 0; i < params.size(); i++) {
			Map<String, Object> param = params.get(i);
			param = bbsMapper.selectBBS(param);
			logger.debug("delete bbs reference");
			bbsMapper.deleteBBS(param);
			execute++;			
		}
		menuService.refreshCachedMenu();
		logger.debug("execute:" + execute);
		return execute;
	}

	@Override
	public Map<String, Object> getNotMenuBBS() throws Exception {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("rtnList", bbsMapper.retrieveNotMenuBBS());
		return rtnMap;
	}
}