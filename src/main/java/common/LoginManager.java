package common;

import java.io.UnsupportedEncodingException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import dto.UserDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.CookieManager;

public class LoginManager {

	public static final String SAVED_ACCOUNT = "saved_account";
	public static final String LOGINED_ACCOUNT = "logined_account";
	public static final String EMAIL_CODE = "emailCode";
	public static UserDTO user = null;
	public static final String ADMIN_EMAIL ="ascent920@gmail.com";
	public static final String ADMIN_NICKNAME = "관리자";
	
	
	public static String getLoginedAccount(HttpSession session) {
		String account = (String)session.getAttribute(LOGINED_ACCOUNT);
		return (account == null) ? "" : account;
	}
	
	public static boolean isLogined(HttpSession session) {
		if(session.getAttribute(LOGINED_ACCOUNT) != null)
			return true;
		
		return false;
	}
	
	public static boolean isAdmin(HttpSession session) {
		String account = getLoginedAccount(session);
		if (account == null || account.isEmpty()) {
	        return false;
	    }
	    
	    // 로그인한 계정이 관리자 이메일이나 닉네임인지 확인
	    return account.equals(ADMIN_EMAIL) || account.equals(ADMIN_NICKNAME);
	}
	
	public static void addSession(HttpSession session, String key, String value) {
		session.setAttribute(key, value);
	}
	
	public static String getSession(HttpSession session, String key) {
		return (String)session.getAttribute(key);
	}
	
	public static void deleteSession(HttpSession session, String key) {
		session.removeAttribute(key);
	}
	
	public static boolean isMatched(UserDTO dto, String account, String pw) {
		if(!pw.equals(dto.getPassword())) 
			return false;
		
		if(account.equals(dto.getEmail())) 
			return true;
		
		if(account.equals(dto.getNickname())) 
			return true;
		
		return false;
	}
	
	public static boolean isEmail(String account) {
		String EMAIL_PATTERN = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
		
	    Pattern pattern = Pattern.compile(EMAIL_PATTERN);
		Matcher matcher = pattern.matcher(account);
		
		return matcher.matches();		
	}
	
	public static UserDTO getUser() {
		
		
		return user;
	}
	
	public static void updateUser(UserDTO updateuser) {
		user = updateuser;
	}
	
	public static void login(HttpServletResponse res, HttpSession session, UserDTO new_user, String entered_account, String entered_pw, boolean isSave) throws UnsupportedEncodingException {
		user = new_user;
		updateSavedAccount(res, entered_account, isSave);
		// 로그인 아이디 세션에 저장
		addSession(session, LoginManager.LOGINED_ACCOUNT, entered_account);
	}
	
	public static void logout(HttpSession session) {
		deleteSession(session, LoginManager.LOGINED_ACCOUNT);
		user = null;
	}
	
	public static void updateSavedAccount(HttpServletResponse res, String account, boolean isSave) throws UnsupportedEncodingException {
		if(isSave){
			CookieManager.makeCookie(res, SAVED_ACCOUNT, account, 60 * 1);
			
		}else{
			CookieManager.deleteCookie(res, SAVED_ACCOUNT);
		}	
	}
	
	public static String getSavedAccount(HttpServletRequest req) throws UnsupportedEncodingException {
		return CookieManager.readCookie(req, SAVED_ACCOUNT);
	}
	
	// 적당한 클래스로 이동 필요
	private static final String EMAIL_PATTERN =
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";

    private static final Pattern pattern = Pattern.compile(EMAIL_PATTERN);

    public static boolean isValidEmail(String email) {
        if (email == null) {
            return false;
        }
        
        Matcher matcher = pattern.matcher(email);
        
        return matcher.matches();
    }
    
 
}












