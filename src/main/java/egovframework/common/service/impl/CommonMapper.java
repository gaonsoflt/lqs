package egovframework.common.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("commonMapper")
public interface CommonMapper {
	
	public int getSequence(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> retrieveTableDatas(Map<String, Object> map) throws Exception;
	
	public int getDuplicateCount(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> retrieveCodeListByCdID(Map<String, Object> map) throws Exception;
}
