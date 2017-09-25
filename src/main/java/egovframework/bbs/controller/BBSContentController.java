package egovframework.bbs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.bbs.service.BBSContentService;
import egovframework.bbs.service.BBSReplyService;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.system.service.BBSService;

@RequestMapping("/bbs/board")
@Controller
public class BBSContentController {
Logger logger = LoggerFactory.getLogger(BBSContentController.class.getName());
    
	@Resource(name = "bBSBoardService")
	private BBSContentService bbsContentService;
	
	@Resource(name = "bBSService")
	private BBSService bbsService;
	

	@RequestMapping(value = "/readList.do")
	public @ResponseBody JSONPObject readList(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("params:" + params); 
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			Map<String, Object> param = EgovWebUtil.parseJsonToMap(params);
			List<Map<String, Object>> rtnList = bbsContentService.getContents(param);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", bbsContentService.getContentCount(param));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}
	
	@RequestMapping(value = "/read.do")
	public @ResponseBody JSONPObject read(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("params:" + params); 
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			Map<String, Object> param = EgovWebUtil.parseJsonToMap(params);
			rtnMap = bbsContentService.getContent(param);
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}

	@RequestMapping(value = "/save.do", method = RequestMethod.POST)
	public ModelAndView save(HttpServletRequest request, @RequestParam String action, @RequestParam(value="file", required=false)MultipartFile file) throws Exception {
		HashMap<String, Object> param = new HashMap<String, Object>();
		logger.debug("[BBAEK] action: " + action);
		try {
			param.put("content_seq", request.getParameter("seq"));
			param.put("bbs_uid", request.getParameter("bbs"));
			if(action.equals("save")) {
				param.put("title", request.getParameter("title"));
				param.put("content", request.getParameter("bbs-content"));
				bbsContentService.saveContent(param);
			} else if(action.equals("delete")) {
				bbsContentService.deleteContent(param);
			}
			return new ModelAndView("redirect:/bbs/board.do?bbs=" + param.get("bbs_uid").toString());
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("/egovframework/cmmn/bizError");
		}
		
//		String answerType = request.getParameter("answer_type");
//		if(answerType.equals("file")) {
//			param.put("answer", FileUtil.readFile(file));
//		} else {
//			param.put("answer", request.getParameter("submit_editor"));
//		}
//		// insert answer history
//		if(questionAnswerService.saveAnswer(param)) {
//			param.put("user_seq", userService.getLoginUserInfo().getUserseq());
//			executeService.execute(param);
////			ESPAExecuteVO result = executeService.execute(param);
////			result.setCode("");
////			result.setGrading(null);
////			mav.addObject("result", result);
//		}
	}
	
	@RequestMapping(value = "/delete.do")
	public @ResponseBody JSONPObject delete(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/delete.do");
		logger.debug("models:" + models); 
		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
		try {
			for(int i = 0; i < paramMapList.size(); i++){
				bbsContentService.deleteContent(paramMapList.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	
	@Resource(name = "bBSReplyService")
	private BBSReplyService replyService;
	
	@RequestMapping(value = "/reply/read.do")
	public @ResponseBody JSONPObject readReply(@RequestParam("callback") String c, @RequestParam("params") String params) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			Map<String, Object> param = EgovWebUtil.parseJsonToMap(params);
			rtnMap.put("rtnList", replyService.getRepliesByContent(param));
			rtnMap.put("total", replyService.getRepliesCountByContent(param));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c, rtnMap);
	}
	
//	@RequestMapping(value = "/reply/create.do")
//	public ModelAndView create(HttpServletRequest request) {
//		logger.debug("---------------->/create.do");
//		HashMap<String, Object> param = new HashMap<String, Object>();
//		param.put("reply", request.getParameter("text"));
//		param.put("bbs_uid", request.getParameter("uid"));
//		param.put("content_seq", request.getParameter("con"));
//		param.put("parent_seq", request.getParameter("pSeq"));
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("jsonView");
//		try {
//			if(replyService.createBBSReply(param) > 0) {
//				mav.addObject("success", true);
//			} else {
//				mav.addObject("success", false);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			mav.addObject("success", false);
//		}
//		return mav;
//	}
	
	
//	@RequestMapping(value = "/reply/delete.do")
//	public @ResponseBody JSONPObject deleteReply(@RequestParam("callback") String c, @RequestParam("models") String models) {
//		logger.debug("---------------->/delete.do");
//		logger.debug("models:" + models); 
//		List<Map<String, Object>> paramMapList = EgovWebUtil.parseJsonToList(models);
//		try {
//			for(int i = 0; i < paramMapList.size(); i++){
//				replyService.deleteBBSReply(paramMapList.get(i));
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			Map<String, Object> rtnMap = new HashMap<String, Object>();
//			rtnMap.put("error", e.toString());
//			return new JSONPObject(c, rtnMap);
//		}
//		return new JSONPObject(c, models);
//	}
	
//	@RequestMapping(value = "/reply/read.do", method = RequestMethod.GET)
//	public @ResponseBody Map<String, Object> read(@RequestParam("bbs") String uid, @RequestParam("con") long seq) {
////		public @ResponseBody List<Map<String, Object>> readList(@RequestParam("con") long seq) {
////		logger.debug("params:" + params); 
//		Map<String, Object> rtnMap = new HashMap<String, Object>();
//		try {
////			Map<String, Object> param = EgovWebUtil.parseJsonToMap(params);
//			Map<String, Object> param = new HashMap<>();
//			param.put("content_seq", seq);
//			param.put("bbs_uid", uid);
//			rtnMap.put("rtnList", replyService.getRepliesByContent(param));
//			rtnMap.put("total", replyService.getRepliesCountByContent(param));
//		} catch (Exception e) {
//			e.printStackTrace();
//			rtnMap.put("error", e.toString());
//		}
//		return rtnMap;
//	}
//	
	@RequestMapping(value = "/reply/create.do", method = RequestMethod.POST)
	public ModelAndView createReply(HttpServletRequest request) {
		logger.debug("---------------->/create.do");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("reply", request.getParameter("text"));
		param.put("bbs_uid", request.getParameter("uid"));
		param.put("content_seq", request.getParameter("con"));
		param.put("parent_seq", request.getParameter("pSeq"));
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		try {
			if(replyService.createBBSReply(param) > 0) {
				mav.addObject("success", true);
			} else {
				mav.addObject("success", false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("success", false);
		}
		return mav;
	}
//	
//	
	@RequestMapping(value = "/reply/delete.do")
	public ModelAndView delete(@RequestParam("seq") int seq) {
		logger.debug("---------------->/delete.do");
		Map<String, Object> param = new HashMap<>();
		param.put("reply_seq", seq);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		try {
			if(replyService.deleteBBSReply(param) > 0) {
				mav.addObject("success", true);
			} else {
				mav.addObject("success", false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("success", false);
		}
		return mav;
	}
}