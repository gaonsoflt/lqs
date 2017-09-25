package egovframework.common.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.service.CommonService;


@Service("commonService")
public class CommonServiceImpl implements CommonService {
	
	@Resource(name = "commonMapper")
	private CommonMapper commonMapper;
	
	@Override
	public int getSequence(String sequenceName) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("SEQUENCE", sequenceName);
		return commonMapper.getSequence(param);
	}

	@Override
	public List<Map<String, Object>> getTableDataList(Map<String, Object> map) throws Exception {
		return commonMapper.retrieveTableDatas(map);  
	}
	
	@Override
	public List<Map<String, Object>> getTableDataList(String tableName, String textColumn, String valueColumn) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("TABLE", tableName);
		param.put("TEXT", textColumn);
		param.put("VALUE", valueColumn);
		return commonMapper.retrieveTableDatas(param);  
	}
	
	@Override
	public boolean isDuplicationData(String tableName, String[] column, String[] data) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("TABLE", tableName);
		for(int i = 0; i < column.length; i++) {
			param.put("COLUMN" + (i + 1), "DATA" + (i + 1));
		}
		if(commonMapper.getDuplicateCount(param) > 0) {
			return true;
		}
		return false;  
	}

	@Override
	public List<Map<String, Object>> getCodeListByCdID(Map<String, Object> map) throws Exception {
		return commonMapper.retrieveCodeListByCdID(map);
	}

	@Override
	public List<Map<String, Object>> getDatasForComboBox(Map<String, Object> map) throws Exception {
		return commonMapper.retrieveTableDatas(map);  
	}

	@Override
	public List<Map<String, Object>> getUserDatasForAutoComplete() throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("TABLE", "SYS_USER_INFO");
		param.put("TEXT", "USER_NAME");
		return commonMapper.retrieveTableDatas(param);
	}
	
	@Override
	public List<Map<String, Object>> getCodeDatas(String catgr) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("TABLE", "SYS_CODE_MASTER");
		param.put("TEXT", "cd_nm");
		param.put("VALUE", "cd_id");
		param.put("CATGR", catgr);
		return commonMapper.retrieveTableDatas(param);
	}
}