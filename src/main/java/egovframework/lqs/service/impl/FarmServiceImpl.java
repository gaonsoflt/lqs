package egovframework.lqs.service.impl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.vo.KendoResponseVO;
import egovframework.common.util.PwdEncryptor;
import egovframework.lqs.service.FarmService;
import egovframework.system.service.impl.AddressMapper;

@Service("farmService")
public class FarmServiceImpl implements FarmService { 
	Logger logger = LoggerFactory.getLogger(FarmServiceImpl.class);
	
	@Resource(name = "farmMapper")
	private FarmMapper farmMapper;
	
	@Resource(name = "addressMapper")
	private AddressMapper addressMapper;
	
	@Resource(name = "livestockMapper")
	private LivestockMapper livestockMapper;

	@Override
	public KendoResponseVO getFarms(Map<String, Object> map) throws Exception {
		KendoResponseVO result = null;
		try {
			List<Map<String, Object>> list = farmMapper.retrieveFarms(map);
			for (Map<String, Object> farm : list) {
				farm.put("livestocks", livestockMapper.retrieveLivestocks(farm));
			}
			result = new KendoResponseVO(list, farmMapper.retrieveFarmsCount(map));
		} catch (Exception e) {
			e.printStackTrace();
			result = new KendoResponseVO(e.toString());
		}
		return result;
	}
	
	@Override
	public Map<String, Object> getFarm(long seq) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("farm_seq", seq);
		List<Map<String, Object>> result = farmMapper.retrieveFarms(param);
		if(result.size() > 0) {
			Map<String, Object> tmp = result.get(0);
			tmp.put("livestocks", livestockMapper.retrieveLivestocks(param));
			return tmp;
		}
		return param;
	}

	@Override
	public KendoResponseVO getLivestocksByFarm(long seq) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("farm_seq", seq);
		List<Map<String, Object>> list = livestockMapper.retrieveLivestocks(param);
		return new KendoResponseVO(list, list.size());
	}
	
	/**
	 * 농장 seq 발급(최대값 + 1)
	 * 현재 연도에 뒤에 숫자 4자리 총 8자리로 구성
	 * @return
	 * @throws Exception
	 */
	private long getNextFarmSeq() throws Exception {
		long maxSeq = farmMapper.retrieveMaxSeq();
		int thisYear = (Calendar.getInstance()).get(Calendar.YEAR);
		
		if((maxSeq / 10000) == thisYear) {
			return maxSeq + 1;
		} else {
			return (thisYear * 10000) + 1;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public int insertFarm(Map<String, Object> map) throws Exception {
		int exeCnt = 0;
		// 주소 저장
		exeCnt = addressMapper.createAddress(map);
		if(exeCnt > 0) {
			// farm_seq 최대값을 가져와서 farm_seq 번호 발급
			long farmSeq = getNextFarmSeq();
			map.put("farm_seq", farmSeq);
			
			// remove phone hyphen 
			map.put("phone", map.get("phone").toString().replace("-", ""));
			// remove reg_number hyphen
			if(map.get("reg_number") != null) {
				map.put("reg_number", map.get("reg_number").toString().replace("-", ""));
			}
			
			// password 암호화
			if (map.get("password") != null && !map.get("password").toString().trim().equals("")) {
				map.put("password", PwdEncryptor.getEncrypt(map.get("password").toString().trim()));
			}
			
			// 가축저장
			List<Map<String, Object>> livestocks = (List<Map<String, Object>>) map.get("livestocks");
			for (Map<String, Object> ls : livestocks) {
				ls.put("farm_seq", farmSeq);
				livestockMapper.createLivestock(ls);
			}
			// 농장정보 저장
			return farmMapper.createFarm(map);
		} else {
			throw new Exception("can not create address");
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public int updateFarm(Map<String, Object> map) throws Exception {
		logger.debug("update farm info");
		// 농장정보 수정
		int exeCnt = farmMapper.updateFarm(map);
		if(exeCnt > 0) {
			// 주소 수정
			addressMapper.updateAddress(map);
			if (map.get("password") != null && !map.get("password").toString().trim().equals("")) {
				logger.debug("update password");
				map.put("password", PwdEncryptor.getEncrypt(map.get("password").toString().trim()));
				// 패스워드 수정
				farmMapper.updatePassword(map);
			}
			// 기존 가축 삭제 후 다시 저장
			if(livestockMapper.deleteLivestock(map) > 0) {
				List<Map<String, Object>> livestocks = (List<Map<String, Object>>) map.get("livestocks");
				for (Map<String, Object> ls : livestocks) {
					ls.put("farm_seq", map.get("farm_seq"));
					livestockMapper.createLivestock(ls);
				}
			}
			return exeCnt;
		} else {
			throw new Exception("can not update farm info");
		}
	}
	
	@Override
	public int updateAppPassword(Map<String, Object> map) throws Exception {
		// password 암호화
		if (map.get("password") != null && !map.get("password").toString().trim().equals("")) {
			map.put("password", PwdEncryptor.getEncrypt(map.get("password").toString().trim()));
			return farmMapper.updatePassword(map);
		} else {
			throw new Exception("can not update password(password is null or wrong value)");
		}
	}

	@Override
	public int deleteFarm(Map<String, Object> map) throws Exception {
		addressMapper.deleteAddress(map);
		livestockMapper.deleteLivestock(map);
		return farmMapper.deleteFarm(map);
	}
}
