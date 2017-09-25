package egovframework.system.service;

import java.util.Map;
import java.util.List;

public interface CodeService {
	public List<Map<String, Object>> getParentCode(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getChildCode(Map<String, Object> map) throws Exception;
	
	public int getCodeCount(Map<String, Object> map) throws Exception;
	
	public int insertCode(Map<String, Object> map) throws Exception;
	
	public int updateCode(Map<String, Object> map) throws Exception;
	
	public int deleteCode(Map<String, Object> map) throws Exception;
}	
