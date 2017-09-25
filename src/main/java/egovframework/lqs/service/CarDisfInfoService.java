package egovframework.lqs.service;

import java.util.Map;

import egovframework.com.vo.KendoResponseVO;

public interface CarDisfInfoService {
	
	public KendoResponseVO getCarDisfInfo(Map<String, Object> map) throws Exception;
	
	public int insertCarDisfInfo(Map<String, Object> map) throws Exception;	
	
	public int updateCarDisfInfo(Map<String, Object> map) throws Exception;	
}
