package egovframework.lqs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.vo.KendoResponseVO;
import egovframework.lqs.service.LprService;

@Service("lprService")
public class LprServiceImpl implements LprService { 
	Logger logger = LoggerFactory.getLogger(LprServiceImpl.class);
	
	@Resource(name = "lprMapper")
	private LprMapper lprMapper;

	@Override
	public KendoResponseVO getLprs(Map<String, Object> map) throws Exception {
		KendoResponseVO result = null;
		try {
			List<Map<String, Object>> list = lprMapper.retrieveLprs(map);
			result = new KendoResponseVO(list, lprMapper.retrieveLprsCount(map));
		} catch (Exception e) {
			e.printStackTrace();
			result = new KendoResponseVO(e.toString());
		}
		return result;
	}

	@Override
	public Map<String, Object> getLpr(long seq) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("lpr_seq", seq);
		List<Map<String, Object>> list = lprMapper.retrieveLprs(param);
		if(list.size() > 0) {
			return list.get(0);
		}
		return param;
	}

	@Override
	public int saveLpr(Map<String, Object> map) throws Exception {
		int exeCnt = 0;
		if(map.get("lpr_seq") != null && !(map.get("lpr_seq").toString().isEmpty())) {
			exeCnt = lprMapper.updateLpr(map);
			logger.debug("execute update lpr info: {}", exeCnt);
		} else {
			exeCnt = lprMapper.createLpr(map);
			logger.debug("execute insert lpr info: {}", exeCnt);
		}
		return exeCnt;
	}
	
	@Override
	public int insertLpr(Map<String, Object> map) throws Exception {
		return lprMapper.createLpr(map);
	}

	@Override
	public int updateLpr(Map<String, Object> map) throws Exception {
		return lprMapper.updateLpr(map);
	}

	@Override
	public int updateLprLocation(Map<String, Object> map) throws Exception {
		return lprMapper.updateLprLocation(map);
	}

	@Override
	public int updateLprBeacon(long seq, boolean isAlive) throws Exception {
		if(isAlive) {
			Map<String, Object> param = new HashMap<>();
			param.put("lpr_seq", seq);
			param.put("is_alive", isAlive);
			return lprMapper.updateLprAliveStatus(param);
		}
		return 0;
	}

	@Override
	public int deleteLpr(Map<String, Object> map) throws Exception {
		return lprMapper.deleteLpr(map);
	}
}
