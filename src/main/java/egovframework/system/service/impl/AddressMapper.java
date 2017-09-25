package egovframework.system.service.impl;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("addressMapper")
public interface AddressMapper {

	public Map<String, Object> retrieveAddress(Map<String, Object> map) throws Exception;
	
	public int createAddress(Map<String, Object> map) throws Exception;
	
	public int updateAddress(Map<String, Object> map) throws Exception;
	
	public int deleteAddress(Map<String, Object> map) throws Exception;
}
