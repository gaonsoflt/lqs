package egovframework.lqs.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("farmMapper")
public interface FarmMapper {

	/**
	 * 농장정보 조회
	 * @param map farm_seq 키값이 있을 경우 필터가능 
	 * @return 조건에 맞는 농장정보
	 * @throws Exception
	 */
	public List<Map<String, Object>> retrieveFarms(Map<String, Object> map) throws Exception;
	
	/**
	 * 농장정보 갯수
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int retrieveFarmsCount(Map<String, Object> map) throws Exception;
	
	/**
	 * 농장 farm_seq 최대 값 
	 * @return
	 * @throws Exception
	 */
	public long retrieveMaxSeq() throws Exception;
	
	/**
	 * 농장 정보 생성
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int createFarm(Map<String, Object> map) throws Exception;
	
	/**
	 * 농장정보 수정(패스워드, 주소는 제외)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateFarm(Map<String, Object> map) throws Exception;
	
	/**
	 * 패스워드(앱패스워드) 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updatePassword(Map<String, Object> map) throws Exception;
	
	/**
	 * 농장정보 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int deleteFarm(Map<String, Object> map) throws Exception;
}
