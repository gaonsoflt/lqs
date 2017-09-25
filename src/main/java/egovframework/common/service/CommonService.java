package egovframework.common.service;

import java.util.List;
import java.util.Map;

public interface CommonService {
	
	public int getSequence(String sequenceName) throws Exception;
	
	public List<Map<String, Object>> getTableDataList(Map<String, Object> map) throws Exception;
	
	/**
	 * 
	 * @param tableName
	 * @param textColumn
	 * @param valueColumn
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getTableDataList(String tableName, String textColumn, String valueColumn) throws Exception;
	
	/**
	 * 
	 * @param tableName
	 * @param column
	 * @param data
	 * @return
	 * @throws Exception
	 */
	public boolean isDuplicationData(String tableName, String[] column, String[] data) throws Exception;
	
	public List<Map<String, Object>> getCodeListByCdID(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getDatasForComboBox(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> getUserDatasForAutoComplete() throws Exception;
	
	public List<Map<String, Object>> getCodeDatas(String catgr) throws Exception;
}
