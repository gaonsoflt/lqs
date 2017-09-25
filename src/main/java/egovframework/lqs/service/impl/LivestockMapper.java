package egovframework.lqs.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("livestockMapper")
public interface LivestockMapper {

	/**
	 * 농장 가축 정보 조회
	 * @param map 
	 * @return 농장 가축정보
	 * @throws Exception
	 */
	public List<Map<String, Object>> retrieveLivestocks(Map<String, Object> map) throws Exception;
	
	/**
	 * 농장 가축 정보 생성
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int createLivestock(Map<String, Object> map) throws Exception;
	
	/**
	 * 농장 가축정보 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateLivestock(Map<String, Object> map) throws Exception;
	
	/**
	 * 농장 가축정보 삭제
	 * @param map(farm_seq)
	 * @return
	 * @throws Exception
	 */
	public int deleteLivestock(Map<String, Object> map) throws Exception;
}
