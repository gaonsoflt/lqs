package egovframework.system.service.impl;

import java.util.Map;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("signupMapper")
public interface SignupMapper {
	
	public List<Map<String, Object>> retrieveSignup(Map<String, Object> map) throws Exception;
	
	public int retrieveSignupCount(Map<String, Object> map) throws Exception;
	
	public int existUserID(Map<String, Object> map) throws Exception;
	
	public int createSignupUser(Map<String, Object> map) throws Exception;
	
	public int deleteSignupUser(Map<String, Object> map) throws Exception;
	
	public int confirmEmail(Map<String, Object> map) throws Exception;
}
