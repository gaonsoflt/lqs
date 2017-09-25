package egovframework.system.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.system.vo.MenuVO;

@Mapper("menuMapper")
public interface MenuMapper {

	public List<Map<String, Object>> selectMenus(Map<String, Object> map) throws Exception;
	
//	public List<Map<String, Object>> selectParentMenus(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> retrieveParentMenu(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> selectChildMenus(Map<String, Object> map) throws Exception;
	
	public List<MenuVO> selectMenusByAuth(Map<String, Object> map) throws Exception;
	
	public int createMenu(Map<String, Object> map) throws Exception;
	
	public int updateMenu(Map<String, Object> map) throws Exception;
	
	public int deleteMenu(Map<String, Object> map) throws Exception;
}
