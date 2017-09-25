package egovframework.system.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.system.service.CodeService;


@Service("codeService")
public class CodeServiceImpl implements CodeService {
	
	@Resource(name = "codeMapper")
	private CodeMapper codeMapper;

	@Override
	public List<Map<String, Object>> getParentCode(Map<String, Object> map) throws Exception {
		return codeMapper.retrieveParentCodes(map);
	}

	@Override
	public List<Map<String, Object>> getChildCode(Map<String, Object> map) throws Exception {
		return codeMapper.retrieveChildCodes(map);
	}

	@Override
	public int getCodeCount(Map<String, Object> map) throws Exception {
		return codeMapper.retrieveCodeCount(map);
	}

	@Override
	public int insertCode(Map<String, Object> map) throws Exception {
		return codeMapper.createCode(map);
	}

	@Override
	public int updateCode(Map<String, Object> map) throws Exception {
		return codeMapper.updateCode(map);
	}

	@Override
	public int deleteCode(Map<String, Object> map) throws Exception {
		return codeMapper.deleteCode(map);
	}
}