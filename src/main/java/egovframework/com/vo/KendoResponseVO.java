package egovframework.com.vo;

import java.util.List;
import java.util.Map;

public class KendoResponseVO {
	
	private List<Map<String, Object>> rtnList;
	private long total;
	private String error;
	
	public KendoResponseVO() {
		
	}
	
	public KendoResponseVO(String error) {
		this.error = error;
	}
	
	public KendoResponseVO(List<Map<String, Object>> result, long total) {
		this.rtnList = result;
		this.total = total;
	}

	public List<Map<String, Object>> getRtnList() {
		return rtnList;
	}

	public void setRtnList(List<Map<String, Object>> rtnList) {
		this.rtnList = rtnList;
	}

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	@Override
	public String toString() {
		return "KendoResponseVO [rtnList=" + rtnList + ", total=" + total + ", error=" + error + "]";
	}
}
