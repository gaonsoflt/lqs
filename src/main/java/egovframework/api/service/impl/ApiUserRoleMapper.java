package egovframework.api.service.impl;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("apiUserRoleMapper")
public interface ApiUserRoleMapper {

	/**
	 * api 인증 유저 role정보 생성
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int createApiUserRole(Map<String, Object> map) throws Exception;
	
	/**
	 * api 인증 유저 role정보 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int deleteApiUserRole(Map<String, Object> map) throws Exception;
}
