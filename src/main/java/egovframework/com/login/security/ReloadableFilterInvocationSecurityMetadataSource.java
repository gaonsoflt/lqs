package egovframework.com.login.security;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.util.matcher.RequestMatcher;

import egovframework.com.login.service.SecuredObjectService;

public class ReloadableFilterInvocationSecurityMetadataSource implements FilterInvocationSecurityMetadataSource {
	Logger logger = LoggerFactory.getLogger(ReloadableFilterInvocationSecurityMetadataSource.class.getName());

	private final Map<RequestMatcher, Collection<ConfigAttribute>> requestMap;
	
	private SecuredObjectService securedObjectService;
	
	public ReloadableFilterInvocationSecurityMetadataSource(LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>> requestMap) {
		this.requestMap = requestMap;
	}
	
	public void setSecuredObjectService(SecuredObjectService securedObjectService) {
		this.securedObjectService = securedObjectService;
	}

	@Override
	public Collection<ConfigAttribute> getAttributes(Object object) throws IllegalArgumentException {
		HttpServletRequest request = ((FilterInvocation) object).getRequest();
		Collection<ConfigAttribute> result = null;
		for(Map.Entry<RequestMatcher, Collection<ConfigAttribute>> entry : requestMap.entrySet()) {
			if(entry.getKey().matches(request)) {
				result = entry.getValue();
				break;
			}
		}
		return result;
	}

	@Override
	public Collection<ConfigAttribute> getAllConfigAttributes() {
		Set<ConfigAttribute> allAttributes = new HashSet<ConfigAttribute>();
		for(Map.Entry<RequestMatcher, Collection<ConfigAttribute>> entry : requestMap.entrySet()) {
			allAttributes.addAll(entry.getValue());
		}
		return allAttributes;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return FilterInvocation.class.isAssignableFrom(clazz);
	}
	
	//reload security meta data
	public void reload() throws Exception {
		LinkedHashMap<RequestMatcher, List<ConfigAttribute>> reloadedMap = securedObjectService.getRolesAndUrl();
		Iterator<Entry<RequestMatcher, List<ConfigAttribute>>> iterator = reloadedMap.entrySet().iterator();
		
		// clear old data
		requestMap.clear();
		
		while(iterator.hasNext()) {
			Entry<RequestMatcher, List<ConfigAttribute>> entry = iterator.next();
			reloadedMap.put(entry.getKey(), entry.getValue());
		}
		
		if(logger.isInfoEnabled()) {
			logger.info("Secured Url Resource - Role Mappings reloaded at Runtime!");
		}
	}
}
