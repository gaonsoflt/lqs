package egovframework.lqs.service;

import java.util.Map;

import egovframework.com.vo.KendoResponseVO;

public interface CarService {
	
	public KendoResponseVO getCars(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> getCar(String no) throws Exception;
	
	public int saveCar(Map<String, Object> map) throws Exception;	
	
	public int insertCar(Map<String, Object> map) throws Exception;	
	
	public int updateCar(Map<String, Object> map)  throws Exception;	
	
	public int deleteCar(Map<String, Object> map)  throws Exception;
}
