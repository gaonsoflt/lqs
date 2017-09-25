package egovframework.system.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.system.vo.ConfigVO;


@Mapper("configMapper")
public interface ConfigMapper {
	
	public List<Map<String, Object>> retrieveConfig(Map<String, Object> map) throws Exception;
	
	public int retrieveConfigCount(Map<String, Object> map) throws Exception;
	
	public List<ConfigVO> retrieveUseConfig() throws Exception;
	
	public int createConfig(Map<String, Object> map) throws Exception;
	
	public int saveConfig(ConfigVO param) throws Exception;
	
	public int updateConfig(Map<String, Object> map) throws Exception;
	
	public int deleteConfig(Map<String, Object> map) throws Exception; 
}
