package egovframework.api.service.impl;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("apiUserMapper")
public interface ApiUserMapper {

	/**
	 * api 인증 유저정보 생성
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int createApiUser(Map<String, Object> map) throws Exception;
	
	/**
	 * api 인증 유저정보 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updateApiUser(Map<String, Object> map) throws Exception;
	
	/**
	 * api 인증 유저정보 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int deleteApiUser(Map<String, Object> map) throws Exception;
}
