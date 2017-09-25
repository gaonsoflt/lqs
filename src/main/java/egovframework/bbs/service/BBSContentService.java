package egovframework.bbs.service;

import java.util.Map;
import java.util.List;

public interface BBSContentService {

	public List<Map<String, Object>> getContents(Map<String, Object> param) throws Exception;
	
	public Map<String, Object> getContent(Map<String, Object> param) throws Exception;
	
	public Map<String, Object> getContent(String uid, long seq) throws Exception;

	public int getContentCount(Map<String, Object> param) throws Exception;
	
	public int saveContent(Map<String, Object> param) throws Exception;

	public int deleteContent(Map<String, Object> param) throws Exception;  
}
