package egovframework.com.login.security.intercept;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.FactoryBean;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.util.matcher.RequestMatcher;

import egovframework.com.login.service.SecuredObjectService;


public class UrlResourcesMapFactoryBean implements FactoryBean<LinkedHashMap<RequestMatcher, List<ConfigAttribute>>> {

	private SecuredObjectService securedObjectService;

	private LinkedHashMap<RequestMatcher, List<ConfigAttribute>> resourcesMap;
    
	public void setSecuredObjectService(SecuredObjectService securedObjectService) {
        this.securedObjectService = securedObjectService;
    }

    public void init() throws Exception {
    	resourcesMap = securedObjectService.getRolesAndUrl();
    }

    public LinkedHashMap<RequestMatcher, List<ConfigAttribute>> getObject() throws Exception {
        if (resourcesMap == null) {
            init();
        }
        return resourcesMap;
    }

    @SuppressWarnings("rawtypes")
	public Class<LinkedHashMap> getObjectType() {
        return LinkedHashMap.class;
    }

    public boolean isSingleton() {
        return true;
    }
}
