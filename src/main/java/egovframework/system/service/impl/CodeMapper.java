package egovframework.system.service.impl;

import java.util.Map;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("codeMapper")
public interface CodeMapper {
	
	public List<Map<String, Object>> retrieveParentCodes(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> retrieveChildCodes(Map<String, Object> map) throws Exception;
	
	public int retrieveCodeCount(Map<String, Object> map) throws Exception;
	
	public int createCode(Map<String, Object> map) throws Exception;
	
	public int updateCode(Map<String, Object> map) throws Exception;
	
	public int deleteCode(Map<String, Object> map) throws Exception;
}
