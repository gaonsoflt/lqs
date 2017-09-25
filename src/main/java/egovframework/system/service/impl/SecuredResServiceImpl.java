package egovframework.system.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.vo.KendoResponseVO;
import egovframework.system.service.SecuredResService;

@Service("securedResService")
public class SecuredResServiceImpl implements SecuredResService { 
	Logger logger = LoggerFactory.getLogger(SecuredResServiceImpl.class);
	
	@Resource(name = "securedResMapper")
	private SecuredResMapper securedResMapper;

	@Override
	public KendoResponseVO getSecuredResources(Map<String, Object> map) throws Exception {
		KendoResponseVO result = null;
		try {
			List<Map<String, Object>> list = securedResMapper.retrieveSecuredResources(map);
			result = new KendoResponseVO(list, securedResMapper.retrieveSecuredResourcesCount(map));
		} catch (Exception e) {
			e.printStackTrace();
			result = new KendoResponseVO(e.toString());
		}
		return result;
	}


	@Override
	public int insertSecuredResource(Map<String, Object> map) throws Exception {
		if(map.get("res_type").equals("method")) {
			String maxResID = securedResMapper.retrieveMaxResIDByType(map);
			if(maxResID == null || maxResID.isEmpty()) { 
				maxResID = "mtd-000000";	
			}
			
			int idx = Integer.parseInt(maxResID.substring(4, maxResID.length()));
			map.put("res_id", String.format("mtd-%06d", idx + 1));
		}
		else if(map.get("res_type").equals("pointcut")) {
			String maxResID = securedResMapper.retrieveMaxResIDByType(map);
			if(maxResID == null || maxResID.isEmpty()) { 
				maxResID = "cut-000000";	
			}
			
			int idx = Integer.parseInt(maxResID.substring(4, maxResID.length()));
			map.put("res_id", String.format("cut-%06d", idx + 1));
		} else {
			String maxResID = securedResMapper.retrieveMaxResIDByType(map);
			if(maxResID == null || maxResID.isEmpty()) { 
				maxResID = "web-000000";	
			}
			
			int idx = Integer.parseInt(maxResID.substring(4, maxResID.length()));
			map.put("res_id", String.format("web-%06d", idx + 1));
		}
		
		logger.debug("next secured resource id: " + map.get("res_id"));
		return securedResMapper.createSecuredResource(map);
	}


	@Override
	public int updateSecuredResource(Map<String, Object> map) throws Exception {
		return securedResMapper.updateSecuredResource(map);
	}


	@Override
	public int deleteSecuredResource(Map<String, Object> map) throws Exception {
		return securedResMapper.deleteSecuredResource(map);
	}
}
