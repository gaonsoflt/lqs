package egovframework.bbs.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("bBSReplyMapper")
public interface BBSReplyMapper {
	
	public List<Map<String, Object>> readRepliesByContent(Map<String, Object> map) throws Exception;
	
	public int readRepliesCountByContent(Map<String, Object> map) throws Exception;
	
	public int createReply(Map<String, Object> map) throws Exception;
	
	public int updateReply(Map<String, Object> map) throws Exception;
	
	public int deleteReply(Map<String, Object> map) throws Exception;
	
	public int deleteReplyByContent(Map<String, Object> map) throws Exception;
}
