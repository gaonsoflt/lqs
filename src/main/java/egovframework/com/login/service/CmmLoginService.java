package egovframework.com.login.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import egovframework.com.user.service.UserInfoService;

public class CmmLoginService implements UserDetailsService {
	Logger logger = LoggerFactory.getLogger(CmmLoginService.class);

    @Autowired
    protected UserInfoService userInfoService;
    
	public UserDetails loadUserByUsername(String input) throws UsernameNotFoundException {
		// split combinedInput(username:areaId)
		String username = input;
		
        CmmLoginUser user = new CmmLoginUser();
        user.setUsername(username);

        HashMap<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("USER_ID", username);

        //UserInfoVo userInfoVO = null;
        HashMap<String, Object> userInfoMap = null;
        try {
        	userInfoMap = userInfoService.retrieveUserInfo(searchMap);
        	
        } catch (Exception e) {
            throw new UsernameNotFoundException("로그인 정보가 존재하지 않습니다.");
        }
        
//        user.setUserseq(userInfoMap.get("user_seq").toString());
        user.setPrinciple(userInfoMap.get("principle").toString());
        user.setUsername(userInfoMap.get("user_id").toString());
        user.setPassword(userInfoMap.get("password").toString().trim());
        user.setFullname(userInfoMap.get("user_name").toString());
        
        
        Set<GrantedAuthority> dbAuthsSet = new HashSet<>();
        try {
        	List<Map<String, Object>> result = userInfoService.loadUserAuthorities(user.getUsername());
        	for (Map<String, Object> map : result) {
        		Iterator<String> key = map.keySet().iterator();
        		while(key.hasNext()) {
        			dbAuthsSet.add(new SimpleGrantedAuthority(map.get(key.next()).toString()));
        		}
			}
        	result.clear();
        	result = userInfoService.loadGroupAuthorities(user.getUsername());
        	for (Map<String, Object> map : result) {
        		Iterator<String> key = map.keySet().iterator();
        		while(key.hasNext()) {
        			dbAuthsSet.add(new SimpleGrantedAuthority(map.get(key.next()).toString()));
        		}
        	}
		} catch (Exception e) {
			e.printStackTrace();
		}
        List<GrantedAuthority> dbAuths = new ArrayList<GrantedAuthority>(dbAuthsSet);
        user.setAuthorities(dbAuths);
        
        if(logger.isDebugEnabled()) {
        	if(dbAuths.size() == 0) {
        		logger.debug("User [" + user.getUsername() + "] has no authorities and will be treated as not found.");
        	} else {
        		logger.debug("User [" + user.getUsername() + "] has authorities" + dbAuths);
        	}
        }
        
//        user.setAuthority("ROLE_USER");
        //user.setAuthority("ROLE_SYSTEM");
        //user.setAuthority("ROLE_ADMIN");
        
/*        if (userInfoVO.getDelAt())
            user.setEnabled(false);
        else if (userInfoVO.getUserStatus().equals("N"))
            user.setAccountNonLocked(false);

        if (!userInfoVO.getUserType().equals("ROLE_USER")) {
            user.setAuthority(userInfoVO.getUserType());
            if (userInfoVO.getUserType().equals("ROLE_SYSTEM"))
                user.setAuthority("ROLE_ADMIN");
        }*/

        return user;
    }
}
