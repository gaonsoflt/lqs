package egovframework.system.vo;

import java.util.Iterator;
import java.util.Map;

public class AuthVO {
	
	public enum TargetType {
		USER,
		GROUP,
		ROLE
	}
	
	private int menu_seq;
	private String target_id;
	private TargetType target_type;
	private boolean auth_c;
	private boolean auth_r;
	private boolean auth_u;
	private boolean auth_d;
	private boolean auth_p;
	
	public AuthVO() {
		
	}
	
	public AuthVO(Map<String, Object> map) {
		
		Iterator<String> keys = map.keySet().iterator();
		while(keys.hasNext()) {
			String key = keys.next();
			if(key.equals("menu_seq")) {
				setMenu_seq((int) map.get(key));
			} else if(key.equals("target_id")) {
				setTarget_id(map.get(key).toString());
			} else if(key.equals("target_type")) {
				setTarget_type(TargetType.valueOf(map.get("target_type").toString()));
			} else if(key.equals("auth_c")) {
				setAuth_c((boolean) map.get(key));
			} else if(key.equals("auth_r")) {
				setAuth_r((boolean) map.get(key));
			} else if(key.equals("auth_u")) {
				setAuth_u((boolean) map.get(key));
			} else if(key.equals("auth_d")) {
				setAuth_d((boolean) map.get(key));
			} else if(key.equals("auth_p")) {
				setAuth_p((boolean) map.get(key));
			}
		}
	}
	
	public int getMenu_seq() {
		return menu_seq;
	}
	
	public void setMenu_seq(int menu_seq) {
		this.menu_seq = menu_seq;
	}
	
	public String getTarget_id() {
		return target_id;
	}
	
	public void setTarget_id(String target_id) {
		this.target_id = target_id;
	}
	
	public TargetType getTarget_type() {
		return target_type;
	}
	
	public void setTarget_type(TargetType target_type) {
		this.target_type = target_type;
	}


	public boolean isAuth_c() {
		return auth_c;
	}

	public void setAuth_c(boolean auth_c) {
		this.auth_c = auth_c;
	}

	public boolean isAuth_r() {
		return auth_r;
	}

	public void setAuth_r(boolean auth_r) {
		this.auth_r = auth_r;
	}

	public boolean isAuth_u() {
		return auth_u;
	}

	public void setAuth_u(boolean auth_u) {
		this.auth_u = auth_u;
	}

	public boolean isAuth_d() {
		return auth_d;
	}

	public void setAuth_d(boolean auth_d) {
		this.auth_d = auth_d;
	}

	public boolean isAuth_p() {
		return auth_p;
	}

	public void setAuth_p(boolean auth_p) {
		this.auth_p = auth_p;
	}

	@Override
	public String toString() {
		return "AuthVO [menu_seq=" + menu_seq + ", target_id=" + target_id + ", target_type=" + target_type
				+ ", auth_c=" + auth_c + ", auth_r=" + auth_r + ", auth_u=" + auth_u + ", auth_d=" + auth_d
				+ ", auth_p=" + auth_p + "]";
	}
}
