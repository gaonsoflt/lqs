package egovframework.system.vo;

public class ConfigVO {
	private String cfg_group;
	private String cfg_id;
	private String cfg_name;
	private Object cfg_value;
	
	public ConfigVO() {
	}
	
	public ConfigVO(String cfg_id) {
		this.cfg_id = cfg_id;
	}
	
	public ConfigVO(String cfg_id, Object cfg_value, String cfg_group) {
		this.cfg_id = cfg_id;
		this.cfg_group = cfg_group;
		this.cfg_value = cfg_value;
	}
	
	public String getCfg_group() {
		return cfg_group;
	}

	public void setCfg_group(String cfg_group) {
		this.cfg_group = cfg_group;
	}

	public String getCfg_id() {
		return cfg_id;
	}
	
	public void setCfg_id(String cfg_id) {
		this.cfg_id = cfg_id;
	}
	
	public String getCfg_name() {
		return cfg_name;
	}
	
	public void setCfg_name(String cfg_name) {
		this.cfg_name = cfg_name;
	}
	
	public Object getCfg_value() {
		return cfg_value;
	}
	
	public void setCfg_value(String cfg_value) {
		this.cfg_value = cfg_value;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((cfg_id == null) ? 0 : cfg_id.hashCode());
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
		ConfigVO other = (ConfigVO) obj;
		if (cfg_id == null) {
			if (other.cfg_id != null)
				return false;
		} else if (!cfg_id.equals(other.cfg_id))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ConfigVO [cfg_group=" + cfg_group + ", cfg_id=" + cfg_id + ", cfg_name=" + cfg_name + ", cfg_value="
				+ cfg_value + "]";
	}
}


