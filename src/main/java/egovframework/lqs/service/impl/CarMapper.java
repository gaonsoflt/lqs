package egovframework.lqs.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("carMapper")
public interface CarMapper {

	/**
	 * 차량정보 조회
	 * @param map car_no 키값이 있을 경우 필터가능 
	 * @return 조건에 맞는 농장정보
	 * @throws Exception
	 */
	public List<Map<String, Object>> retrieveCars(Map<String, Object> map) throws Exception;
	
	/**
	 * 차량정보 갯수
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int retrieveCarsCount(Map<String, Object> map) throws Exception;
	
	/**
	 * 차량 정보 생성
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int createCar(Map<String, Object> map) throws Exception;
	
	/**
	 * 차량정보 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateCar(Map<String, Object> map) throws Exception;
	
	/**
	 * 차량정보 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int deleteCar(Map<String, Object> map) throws Exception;
}
