package egovframework.lqs.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.vo.KendoResponseVO;
import egovframework.lqs.service.CarDisfInfoService;

@Service("carDisfInfoService")
public class CarDisfInfoServiceImpl implements CarDisfInfoService { 
	Logger logger = LoggerFactory.getLogger(CarDisfInfoServiceImpl.class);
	
	@Resource(name = "carDisfInfoMapper")
	private CarDisfInfoMapper carDisfInfoMapper;

	@Override
	public KendoResponseVO getCarDisfInfo(Map<String, Object> map) throws Exception {
		KendoResponseVO result = null;
		try {
			List<Map<String, Object>> list = carDisfInfoMapper.retrieveCarDisfInfo(map);
			result = new KendoResponseVO(list, carDisfInfoMapper.retrieveCarDisfInfoCount(map));
		} catch (Exception e) {
			e.printStackTrace();
			result = new KendoResponseVO(e.toString());
		}
		return result;
	}

	int DISF_ALLOW_TIME = 5;
	@Override
	public int insertCarDisfInfo(Map<String, Object> map) throws Exception {
		Calendar cal = Calendar.getInstance(); // creates calendar
	    cal.setTime(new Date()); // sets calendar time/date
		map.put("disf_dt", cal.getTime());
		cal.add(Calendar.HOUR_OF_DAY, DISF_ALLOW_TIME); // adds one hour
		map.put("admit_dt", cal.getTime());
		return carDisfInfoMapper.createCarDisfInfo(map);
	}

	@Override
	public int updateCarDisfInfo(Map<String, Object> map) throws Exception {
		return carDisfInfoMapper.updateCarDisfInfo(map);
	}
}
