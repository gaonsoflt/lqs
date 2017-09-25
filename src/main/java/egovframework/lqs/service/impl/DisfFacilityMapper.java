package egovframework.lqs.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("disfFacilityMapper")
public interface DisfFacilityMapper {

	/**
	 * 소독시설정보 조회
	 * @param map facility_seq 키값이 있을 경우 필터가능 
	 * @return 조건에 맞는 농장정보
	 * @throws Exception
	 */
	public List<Map<String, Object>> retrieveDisfFacility(Map<String, Object> map) throws Exception;
	
	/**
	 * 소독시설정보 갯수
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int retrieveDisfFacilityCount(Map<String, Object> map) throws Exception;
	
	/**
	 * 소독시설정보 생성
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int createDisfFacility(Map<String, Object> map) throws Exception;
	
	/**
	 * 소독시설정보 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateDisfFacility(Map<String, Object> map) throws Exception;

	/**
	 * 소독시설정보 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int deleteDisfFacility(Map<String, Object> map) throws Exception;
}
