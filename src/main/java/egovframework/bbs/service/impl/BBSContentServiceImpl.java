package egovframework.bbs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.bbs.service.BBSContentService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.system.service.UserService;
import egovframework.system.service.impl.BBSMapper;


@Service("bBSBoardService")
public class BBSContentServiceImpl extends EgovAbstractServiceImpl implements BBSContentService {
	Logger logger = LoggerFactory.getLogger(BBSContentServiceImpl.class.getName()); 
	
	@Resource(name = "userService")
	private UserService userService;
	
	@Resource(name = "bBSMapper")
	private BBSMapper bbsRefMapper;
	
	@Resource(name = "bBSContentMapper")
	private BBSContentMapper bbsContentMapper;
	
	@Resource(name = "bBSReplyMapper")
	private BBSReplyMapper replyMapper;
	
	@Override
	public List<Map<String, Object>> getContents(Map<String, Object> param) throws Exception {
		logger.debug("param: " + param);
		return bbsContentMapper.readContents(param); 
	}

	@Override
	public Map<String, Object> getContent(Map<String, Object> param) throws Exception {
		logger.debug("param: " + param);
		return bbsContentMapper.readContent(param);
	}
	
	@Override
	public Map<String, Object> getContent(String uid, long seq) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("bbs_uid", uid);
		param.put("content_seq", seq);
		logger.debug("param: " + param);
		return bbsContentMapper.readContent(param);
	}

	@Override
	public int getContentCount(Map<String, Object> param) throws Exception {
		logger.debug("param: " + param);
 		return bbsContentMapper.readContentCount(param);
 	}
	
	@Override
	public int saveContent(Map<String, Object> param) throws Exception {
		param.put("mod_usr", userService.getLoginUserInfo().getUsername());
		int exeCnt = 0;
		logger.debug("param: " + param);
		exeCnt = bbsContentMapper.updateContent(param);
		logger.debug("update: " + exeCnt);
		if(exeCnt <= 0) {
//			param.put("board_id", UUID.randomUUID().toString());
			param.put("cre_usr", userService.getLoginUserInfo().getUsername());
			param.put("mod_usr", userService.getLoginUserInfo().getUsername());
			logger.debug("param: " + param);
			exeCnt = bbsContentMapper.createContent(param);
			logger.debug("insert: " + exeCnt);
		}
		return exeCnt;
	}

	@Override
	public int deleteContent(Map<String, Object> param) throws Exception {
		logger.debug("param: " + param);
		int exeCnt = 0;
		exeCnt = bbsContentMapper.deleteContent(param);
		if(exeCnt > 0) {
			replyMapper.deleteReplyByContent(param);
		}
		return exeCnt;
	}
}