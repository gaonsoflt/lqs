package egovframework.system.service.impl;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.system.service.ConfigService;
import egovframework.system.vo.ConfigVO;

@Service("configService")
public class ConfigServiceImpl implements ConfigService {
	Logger logger = LoggerFactory.getLogger(ConfigServiceImpl.class.getName());

	@Resource(name = "configMapper")
	private ConfigMapper configMapper;

	@Override
	public List<Map<String, Object>> retrieveConfig(Map<String, Object> map) throws Exception {
		return configMapper.retrieveConfig(map);
	}

	@Override
	public int retrieveConfigCount(Map<String, Object> map) throws Exception {
		return configMapper.retrieveConfigCount(map);
	}

	@Override
	public int createConfig(Map<String, Object> map) throws Exception {
		return configMapper.createConfig(map);
	}

	@Override
	public int updateConfig(Map<String, Object> map) throws Exception {
		return configMapper.updateConfig(map);
	}

	@Override
	public int deleteConfig(Map<String, Object> map) throws Exception {
		return configMapper.deleteConfig(map);
	}

	@Override
	public int saveConfig(Map<String, Object> map) throws Exception {
		int exeCnt = 0;
		Iterator<String> keys = map.keySet().iterator();
		while(keys.hasNext()) {
			String key = keys.next();
			Object value = null;
			if(map.get(key) instanceof String[]) {
				value = ((String[])map.get(key))[0];
			} else {
				value = map.get(key).toString();
			}
			
			if(value != null) {
				configMapper.saveConfig(new ConfigVO(key.toUpperCase(), value, "SYSTEM"));
			}
		}
		return exeCnt;
	}
}
