package egovframework.common.util;

import java.util.regex.Pattern;

public class StringUtil {
	public enum PatternType {
		NUMBER,
		EMAIL,
		TEL,
		PHONE,
		TEL_HYP,
		PHONE_HYP
	}
	
	public static boolean checkPattern(PatternType type, String str) {
		String regex = null;
		switch(type) {
			case NUMBER: // 숫자 체크
				regex = "^[0-9]*$";
				break;
			case EMAIL: // 이메일 체크
				regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";
				break;
			case TEL: // 전화번호 체크
				regex = "^\\d{2,3}\\d{3,4}\\d{4}$";
				break;
			case PHONE: // 휴대폰번호 체크
				regex = "^01(?:0|1[6-9])(?:\\d{3}|\\d{4})\\d{4}$";
				break;
			case TEL_HYP: // 전화번호 체크
				regex = "^\\d{2,3}-\\d{3,4}-\\d{4}$";
				break;
			case PHONE_HYP: // 휴대폰번호 체크
				regex = "^01(?:0|1[6-9])-(?:\\d{3}|\\d{4})-\\d{4}$";
				break;
			default:
				break;
		}
		if(regex != null) {
			return Pattern.matches(regex, str);
		}
		return false;
	}
	
	public static PatternType getStringPatternType(String str) {
		for (PatternType type : PatternType.values()) {
			if(checkPattern(type, str)) {
				return type;
			}
		}
		return null;
	}
	
	// TODO: 나중에 정규식을 공부해서 바꿔야함
	public static String makePhoneNumber(String phoneNumber) {
		String regEx = "(\\d{3})(\\d{3,4})(\\d{4})";
//		String regEx = "^(\\d{2,3})(\\d{3,4})(\\d{4})$";

		if (!Pattern.matches(regEx, phoneNumber))
			return null;

		return phoneNumber.replaceAll(regEx, "$1-$2-$3");

	}
}
