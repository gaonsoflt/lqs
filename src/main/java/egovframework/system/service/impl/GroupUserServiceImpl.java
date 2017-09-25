package egovframework.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.system.service.GroupUserService;
import egovframework.system.service.UserService;

@Service("groupUserService")
public class GroupUserServiceImpl implements GroupUserService {
	Logger logger = LoggerFactory.getLogger(GroupUserServiceImpl.class);
	
	@Resource(name = "groupUserMapper")
	private GroupUserMapper groupUserMapper;
	
	@Resource(name = "groupMapper")
	private GroupMapper groupMapper;
	
	@Resource(name = "userService")
	private UserService userService;

	@Override
	public Map<String, Object> getGroups(Map<String, Object> map) throws Exception {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<Map<String, Object>> rtnList = groupMapper.retrieveGroups(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", groupMapper.retrieveGroupsCount(map));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}

	@Override
	public Map<String, Object> getGroup(int groupID) throws Exception {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("group_id", groupID);
			List<Map<String, Object>> rtnList = groupMapper.retrieveGroups(param);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", groupMapper.retrieveGroupsCount(param));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}

	@Override
	public Map<String, Object> getNoGroupUsers(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<Map<String, Object>> rtnList = groupUserMapper.retrieveNoGroupUsers(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}

	@Override
	public Map<String, Object> getGroupUsers(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<Map<String, Object>> rtnList = groupUserMapper.retrieveGroupUsers(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", rtnList.size());
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> getGroupsByUser(String userID) throws Exception {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		Map<String, Object> param = new HashMap<>();
		param.put("user_id", userID);
		try {
			List<Map<String, Object>> rtnList = groupUserMapper.retrieveUserGroups(param);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}

	@Override
	public Map<String, Object> getGroupsByLoginUser() throws Exception {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		Map<String, Object> param = new HashMap<>();
		param.put("user_id", userService.getLoginUserInfo().getUsername());
		try {
			List<Map<String, Object>> rtnList = groupUserMapper.retrieveUserGroups(param);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}

	@Override
	public int insertGroup(Map<String, Object> map) throws Exception {
		return groupMapper.createGroup(map);
	}

	@Override
	public int updateGroup(Map<String, Object> map) throws Exception {
		return groupMapper.updateGroup(map);
	}

	@Override
	public int deleteGroup(Map<String, Object> map) throws Exception {
		return groupMapper.deleteGroup(map);
	}

	@Override
	public int saveGroupUser(Map<String, Object> map) throws Exception {
		int executeCnt = 0;
		String group_id;
		groupUserMapper.deleteGroupUser(map);
		group_id = map.get("group_id").toString();
		List<Map<String, Object>> users = EgovWebUtil.parseJsonToList(map.get("users").toString());
		for (Map<String, Object> param : users) {
			param.put("group_id", group_id);
			executeCnt = groupUserMapper.createGroupUser(param);
		}
		return executeCnt;
	}

	@Override
	public int deleteGroupUser(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}	
}
