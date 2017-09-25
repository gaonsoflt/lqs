package egovframework.lqs.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("lprMapper")
public interface LprMapper {

	/**
	 * 인식기정보 다건조회
	 * @param map farm_seq 키값이 있을 경우 필터가능 
	 * @return 조건에 맞는 농장정보
	 * @throws Exception
	 */
	public List<Map<String, Object>> retrieveLprs(Map<String, Object> map) throws Exception;
	
	/**
	 * 인식기정보 갯수
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int retrieveLprsCount(Map<String, Object> map) throws Exception;
	
	/**
	 * 인식기정보 생성
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int createLpr(Map<String, Object> map) throws Exception;
	
	/**
	 * 인식기정보 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateLpr(Map<String, Object> map) throws Exception;
	
	/**
	 * 인식기위치 수정 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateLprLocation(Map<String, Object> map) throws Exception;
	
	/**
	 * 인식기 비콘(연결상태)여부 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateLprAliveStatus(Map<String, Object> map) throws Exception;
	
	/**
	 * 인식기 정보 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int deleteLpr(Map<String, Object> map) throws Exception;
}
