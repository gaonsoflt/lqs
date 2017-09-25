package egovframework.common.annotation.container;

public class InnerPageVO {
	private String name;
	private String url;
	private String id;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getUrl() {
		return url;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}

	@Override
	public String toString() {
		return "InnerPageVO [name=" + name + ", url=" + url + ", id=" + id + "]";
	}
}
