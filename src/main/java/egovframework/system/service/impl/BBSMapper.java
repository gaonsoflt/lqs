package egovframework.system.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("bBSMapper")
public interface BBSMapper {
	
	public int createTable(Map<String, Object> map) throws Exception;
	
	public int dropTable(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> selectBBSList(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> selectBBS(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> retrieveNotMenuBBS() throws Exception;
	
	public int selectBBSListCount(Map<String, Object> map) throws Exception;
	
	public int createBBS(Map<String, Object> map) throws Exception;
	
	public int updateBBS(Map<String, Object> map) throws Exception;
	
	public int deleteBBS(Map<String, Object> map) throws Exception; 
}
