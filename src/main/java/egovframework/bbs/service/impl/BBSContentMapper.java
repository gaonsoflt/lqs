package egovframework.bbs.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("bBSContentMapper")
public interface BBSContentMapper {
	
	public List<Map<String, Object>> readContents(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> readContent(Map<String, Object> map) throws Exception;
	
	public int readContentCount(Map<String, Object> map) throws Exception;
	
	public int createContent(Map<String, Object> map) throws Exception;
	
	public int updateContent(Map<String, Object> map) throws Exception;
	
	public int deleteContent(Map<String, Object> map) throws Exception;
	
	public int deleteBoard(Map<String, Object> map) throws Exception; 
}
