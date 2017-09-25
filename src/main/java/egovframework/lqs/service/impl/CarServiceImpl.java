package egovframework.lqs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.vo.KendoResponseVO;
import egovframework.lqs.service.CarService;

@Service("carService")
public class CarServiceImpl implements CarService { 
	Logger logger = LoggerFactory.getLogger(CarServiceImpl.class);
	
	@Resource(name = "carMapper")
	private CarMapper carMapper;

	@Override
	public KendoResponseVO getCars(Map<String, Object> map) throws Exception {
		KendoResponseVO result = null;
		try {
			List<Map<String, Object>> list = carMapper.retrieveCars(map);
			result = new KendoResponseVO(list, carMapper.retrieveCarsCount(map));
		} catch (Exception e) {
			e.printStackTrace();
			result = new KendoResponseVO(e.toString());
		}
		return result;
	}

	@Override
	public Map<String, Object> getCar(String no) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("car_no", no);
		List<Map<String, Object>> result = carMapper.retrieveCars(param);
		if(result.size() > 0) {
			return result.get(0);
		}
		return param;

	}
	
	@Override
	public int saveCar(Map<String, Object> map) throws Exception {
		int exeCnt = 0;
		if(map.get("car_no") != null && !(map.get("car_no").toString().isEmpty())) {
			map.put("car_no", map.get("car_no").toString().trim().replaceAll(" ", ""));
			map.put("since_year", map.get("since_year").toString().replace("-", ""));
			
			exeCnt = carMapper.updateCar(map);
			logger.debug("execute update car info: {}", exeCnt);
			if(exeCnt <= 0) {
				exeCnt = carMapper.createCar(map);
				logger.debug("execute insert car info: {}", exeCnt);
			}
		} else {
			throw new Exception("car_no is null");
		}
		return exeCnt;
	}

	@Override
	public int insertCar(Map<String, Object> map) throws Exception {
		return carMapper.createCar(map);
	}

	@Override
	public int updateCar(Map<String, Object> map) throws Exception {
		return carMapper.updateCar(map);
	}

	@Override
	public int deleteCar(Map<String, Object> map) throws Exception {
		return carMapper.deleteCar(map);
	}
}
