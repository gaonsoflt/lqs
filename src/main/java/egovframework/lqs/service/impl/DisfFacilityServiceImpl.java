package egovframework.lqs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.vo.KendoResponseVO;
import egovframework.lqs.service.DisfFacilityService;
import egovframework.system.service.impl.AddressMapper;

@Service("disfFacilityService")
public class DisfFacilityServiceImpl implements DisfFacilityService { 
	Logger logger = LoggerFactory.getLogger(DisfFacilityServiceImpl.class);
	
	@Resource(name = "disfFacilityMapper")
	private DisfFacilityMapper disfFacilityMapper;
	
	@Resource(name = "addressMapper")
	private AddressMapper addressMapper;
	
	@Override
	public KendoResponseVO getDisfFacilities(Map<String, Object> map) throws Exception {
		KendoResponseVO result = null;
		try {
			result = new KendoResponseVO(disfFacilityMapper.retrieveDisfFacility(map), disfFacilityMapper.retrieveDisfFacilityCount(map));
		} catch (Exception e) {
			e.printStackTrace();
			result = new KendoResponseVO(e.toString());
		}
		return result;
	}
	
	@Override
	public Map<String, Object> getDisfFacility(long seq) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("facility_seq", seq);
		List<Map<String, Object>> result = disfFacilityMapper.retrieveDisfFacility(param);
		if(result.size() > 0) {
			return result.get(0);
		}
		return param;
	}

	@Override
	public int insertDisfFacility(Map<String, Object> map) throws Exception {
		int exeCnt = 0;
		// 주소 저장
		exeCnt = addressMapper.createAddress(map);
		if(exeCnt > 0) {
			// 농장정보 저장
			return disfFacilityMapper.createDisfFacility(map);
		} else {
			throw new Exception("can not create disf facility info(failed create address)");
		}
	}

	@Override
	public int updateDisfFacility(Map<String, Object> map) throws Exception {
		logger.debug("update farm info");
		int exeCnt = 0;
		// 주소 수정
		exeCnt = addressMapper.updateAddress(map);
		if(exeCnt > 0) {
			// 농장정보 수정
			return disfFacilityMapper.updateDisfFacility(map);
		} else {
			throw new Exception("can not update disf facility info(failed update address)");		
		}
	}
	
	@Override
	public int deleteDisfFacility(Map<String, Object> map) throws Exception {
		addressMapper.deleteAddress(map);
		return disfFacilityMapper.deleteDisfFacility(map);
	}
}
