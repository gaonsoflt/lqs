package egovframework.system.vo;

public class MenuVO {
	
	private long menu_seq;
	private long parent_seq;
	private String menu_id;
	private String menu_name;
	private String menu_url;
	private String menu_icon;
	private String description;
	private long main_seq;
	private long main_order;
	private String main_name;
	private String main_id;
	private String main_icon;
	private String main_url;
	private String main_description;
	private String bbs_uid;
	
	public MenuVO() {
		
	}
	
	public MenuVO(long seq) {
		this.menu_seq = seq;
	}
	
	public long getActiveMenuSeq() {
		return (getMenu_seq() > 0) ? getMenu_seq() : getMain_seq();
	}
	
	public String getActiveMenuId() {
		return (getMenu_seq() > 0) ? getMenu_id() : getMain_id();
	}
	
	public long getMenu_seq() {
		return menu_seq;
	}

	public void setMenu_seq(long menu_seq) {
		this.menu_seq = menu_seq;
	}

	public long getParent_seq() {
		return parent_seq;
	}

	public void setParent_seq(long parent_seq) {
		this.parent_seq = parent_seq;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public String getMenu_id() {
		return menu_id;
	}

	public void setMenu_id(String menu_id) {
		this.menu_id = menu_id;
	}

	public String getMenu_url() {
		return menu_url;
	}

	public void setMenu_url(String menu_url) {
		this.menu_url = menu_url;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public long getMain_seq() {
		return main_seq;
	}

	public void setMain_seq(long main_seq) {
		this.main_seq = main_seq;
	}

	public long getMain_order() {
		return main_order;
	}

	public void setMain_order(long main_order) {
		this.main_order = main_order;
	}

	public String getMain_name() {
		return main_name;
	}

	public void setMain_name(String main_name) {
		this.main_name = main_name;
	}

	public String getMain_id() {
		return main_id;
	}

	public void setMain_id(String main_id) {
		this.main_id = main_id;
	}

	public String getMenu_icon() {
		return menu_icon;
	}

	public void setMenu_icon(String menu_icon) {
		this.menu_icon = menu_icon;
	}

	public String getMain_icon() {
		return main_icon;
	}

	public void setMain_icon(String main_icon) {
		this.main_icon = main_icon;
	}
	
	public String getMain_url() {
		return main_url;
	}

	public void setMain_url(String main_url) {
		this.main_url = main_url;
	}
	
	public String getBbs_uid() {
		return bbs_uid;
	}

	public void setBbs_uid(String bbs_uid) {
		this.bbs_uid = bbs_uid;
	}
	
	public String getMain_description() {
		return main_description;
	}

	public void setMain_description(String main_description) {
		this.main_description = main_description;
	}

	@Override
	public String toString() {
		return "MenuVO [menu_seq=" + menu_seq + ", parent_seq=" + parent_seq + ", menu_id=" + menu_id + ", menu_name="
				+ menu_name + ", menu_url=" + menu_url + ", menu_icon=" + menu_icon + ", description=" + description
				+ ", main_seq=" + main_seq + ", main_order=" + main_order + ", main_name=" + main_name + ", main_id="
				+ main_id + ", main_icon=" + main_icon + ", main_url=" + main_url + ", main_description="
				+ main_description + ", bbs_uid=" + bbs_uid + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (menu_seq ^ (menu_seq >>> 32));
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MenuVO other = (MenuVO) obj;
		if (menu_seq != other.menu_seq)
			return false;
		return true;
	}

}
