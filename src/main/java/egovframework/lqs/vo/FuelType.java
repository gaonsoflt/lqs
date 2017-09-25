package egovframework.lqs.vo;

public enum FuelType {
	G("휘발유"),
	D("경유"),
	L("가스"),
	E("전기");
	
	String code;
			
	FuelType(String type) {
		this.code = type;
	}
	
	public String getCode() {
		return this.code;
	}
}


