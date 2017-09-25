package egovframework.bbs.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.bbs.service.BBSReplyService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.system.service.UserService;


@Service("bBSReplyService")
public class BBSReplyServiceImpl extends EgovAbstractServiceImpl implements BBSReplyService {
	Logger logger = LoggerFactory.getLogger(BBSReplyServiceImpl.class.getName()); 
	
	@Resource(name = "bBSReplyMapper")
	private BBSReplyMapper replyMapper;
	
	@Resource(name = "userService")
	private UserService userService;
	
	@Override
	public List<Map<String, Object>> getRepliesByContent(Map<String, Object> param) throws Exception {
		logger.debug("param: " + param);
		return replyMapper.readRepliesByContent(param);
	}

	@Override
	public int getRepliesCountByContent(Map<String, Object> param) throws Exception {
		logger.debug("param: " + param);
		return replyMapper.readRepliesCountByContent(param);
	}

	@Override
	public int createBBSReply(Map<String, Object> param) throws Exception {
		param.put("cre_usr", userService.getLoginUserInfo().getUsername());
		logger.debug("param: " + param);
		return replyMapper.createReply(param);
	}

	@Override
	public int deleteBBSReply(Map<String, Object> param) throws Exception {
		logger.debug("param: " + param);
		return replyMapper.deleteReply(param);
	}
}