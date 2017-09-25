package egovframework.bbs.service;

import java.util.Map;
import java.util.List;

public interface BBSReplyService {

	public List<Map<String, Object>> getRepliesByContent(Map<String, Object> param) throws Exception;
	
	public int getRepliesCountByContent(Map<String, Object> param) throws Exception;
	
	public int createBBSReply(Map<String, Object> param) throws Exception;
	
	public int deleteBBSReply(Map<String, Object> param) throws Exception;  
}
