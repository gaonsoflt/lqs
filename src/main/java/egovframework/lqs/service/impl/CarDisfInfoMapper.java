package egovframework.lqs.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("carDisfInfoMapper")
public interface CarDisfInfoMapper {

	/**
	 * 차량소독정보 조회
	 * @param map facility_seq 키값이 있을 경우 필터가능 
	 * @return 조건에 맞는 농장정보
	 * @throws Exception
	 */
	public List<Map<String, Object>> retrieveCarDisfInfo(Map<String, Object> map) throws Exception;
	
	/**
	 * 차량소독정보 갯수
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int retrieveCarDisfInfoCount(Map<String, Object> map) throws Exception;
	
	/**
	 * 차량소독정보 생성
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int createCarDisfInfo(Map<String, Object> map) throws Exception;
	
	/**
	 * 차량소독정보 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateCarDisfInfo(Map<String, Object> map) throws Exception;
}
