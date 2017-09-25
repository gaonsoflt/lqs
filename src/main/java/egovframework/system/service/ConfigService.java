package egovframework.system.service;

import java.util.Map;
import java.util.List;

public interface ConfigService {
	public List<Map<String, Object>> retrieveConfig(Map<String, Object> map) throws Exception;
	
	public int retrieveConfigCount(Map<String, Object> map) throws Exception;
	
	public int saveConfig(Map<String, Object> map) throws Exception;
	
	public int createConfig(Map<String, Object> map) throws Exception;
	
	public int updateConfig(Map<String, Object> map) throws Exception;
	
	public int deleteConfig(Map<String, Object> map) throws Exception;
}
