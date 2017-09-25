package egovframework.system.vo;

public class AddressVO {
	
	private long address_seq;
	private String zonecode;
	private String jibun_address;
	private String road_address;
	private String detail_address;
	private String sido;
	private String sigungu;
	private String sigungu_code;
	private String roadname_code;
	private String roadname;
	private String building_code;
	private String building_name;
	private String bcode;
	private String bname;
	private String bname1;
	
	public AddressVO() {
		
	}

	public long getAddress_seq() {
		return address_seq;
	}

	public void setAddress_seq(long address_seq) {
		this.address_seq = address_seq;
	}

	public String getZonecode() {
		return zonecode;
	}

	public void setZonecode(String zonecode) {
		this.zonecode = zonecode;
	}

	public String getJibun_address() {
		return jibun_address;
	}

	public void setJibun_address(String jibun_address) {
		this.jibun_address = jibun_address;
	}

	public String getRoad_address() {
		return road_address;
	}

	public void setRoad_address(String road_address) {
		this.road_address = road_address;
	}

	public String getDetail_address() {
		return detail_address;
	}

	public void setDetail_address(String detail_address) {
		this.detail_address = detail_address;
	}

	public String getSido() {
		return sido;
	}

	public void setSido(String sido) {
		this.sido = sido;
	}

	public String getSigungu() {
		return sigungu;
	}

	public void setSigungu(String sigungu) {
		this.sigungu = sigungu;
	}

	public String getSigungu_code() {
		return sigungu_code;
	}

	public void setSigungu_code(String sigungu_code) {
		this.sigungu_code = sigungu_code;
	}

	public String getRoadname_code() {
		return roadname_code;
	}

	public void setRoadname_code(String roadname_code) {
		this.roadname_code = roadname_code;
	}

	public String getRoadname() {
		return roadname;
	}

	public void setRoadname(String roadname) {
		this.roadname = roadname;
	}

	public String getBuilding_code() {
		return building_code;
	}

	public void setBuilding_code(String building_code) {
		this.building_code = building_code;
	}

	public String getBuilding_name() {
		return building_name;
	}

	public void setBuilding_name(String building_name) {
		this.building_name = building_name;
	}

	public String getBcode() {
		return bcode;
	}

	public void setBcode(String bcode) {
		this.bcode = bcode;
	}

	public String getBname() {
		return bname;
	}

	public void setBname(String bname) {
		this.bname = bname;
	}

	public String getBname1() {
		return bname1;
	}

	public void setBname1(String bname1) {
		this.bname1 = bname1;
	}

	@Override
	public String toString() {
		return "AddressVO [address_seq=" + address_seq + ", zonecode=" + zonecode + ", jibun_address=" + jibun_address
				+ ", road_address=" + road_address + ", detail_address=" + detail_address + ", sido=" + sido
				+ ", sigungu=" + sigungu + ", sigungu_code=" + sigungu_code + ", roadname_code=" + roadname_code
				+ ", roadname=" + roadname + ", building_code=" + building_code + ", building_name=" + building_name
				+ ", bcode=" + bcode + ", bname=" + bname + ", bname1=" + bname1 + "]";
	}
}
