package egovframework.system.config;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.system.service.impl.ConfigMapper;
import egovframework.system.vo.ConfigVO;

@Service
public class Config {
	Logger logger = LoggerFactory.getLogger(Config.class.getName());
	
	@Resource(name = "configMapper")
	private ConfigMapper configMapper;
	
	private static List<ConfigVO> config;
	
	@PostConstruct
	public void init() throws Exception {
		config = configMapper.retrieveUseConfig();
		logger.debug("init config");
	}

	public static List<ConfigVO> getConfig() {
		return config;
	}
	
	public static ConfigVO getConfig(String cfgID) {
		try {
			int idx = getConfig().indexOf(new ConfigVO(cfgID));
			return getConfig().get(idx);
		} catch (Exception e) {
			return null;
		}
	}
	
	public static Object getConfigValue(String cfgID) {
		ConfigVO vo = getConfig(cfgID);
		if(vo != null) {
			return vo.getCfg_value(); 
		}
		return null;
	}
	
	public static Object getConfigValue(ConfigID cfgID) {
		ConfigVO vo = getConfig(cfgID.name().toString());
		if(vo != null) {
			return vo.getCfg_value(); 
		}
		return null;
	}
	
	public static String getConfigName(String cfgID) {
		ConfigVO vo = getConfig(cfgID);
		if(vo != null) {
			return vo.getCfg_name(); 
		}
		return null;
	}
}
