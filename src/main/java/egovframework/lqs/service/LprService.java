package egovframework.lqs.service;

import java.util.Map;

import egovframework.com.vo.KendoResponseVO;

public interface LprService {
	
	public KendoResponseVO getLprs(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> getLpr(long seq) throws Exception;
	
	public int saveLpr(Map<String, Object> map) throws Exception;	
	
	public int insertLpr(Map<String, Object> map) throws Exception;	
	
	public int updateLpr(Map<String, Object> map) throws Exception;	
	
	public int updateLprLocation(Map<String, Object> map) throws Exception;	
	
	public int updateLprBeacon(long seq, boolean isAlive) throws Exception;
	
	public int deleteLpr(Map<String, Object> map) throws Exception;
}
