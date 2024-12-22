package utils;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CookieManager {

	public static void makeCookie(HttpServletResponse res, String key, String value, int timeSec) throws UnsupportedEncodingException {
		Cookie cookie = new Cookie(key, URLEncoder.encode(value, "UTF-8"));
		
		cookie.setPath("/");
		cookie.setMaxAge(timeSec);
		
		res.addCookie(cookie);
		
		System.out.println("makeCookie : " + key + ", " + value + ", " + timeSec);
	}
	public static String readCookie(HttpServletRequest req, String key) throws UnsupportedEncodingException {
		String value = "";
		Cookie[] cookies = req.getCookies();
		if(cookies != null) {
			for(Cookie c : cookies) {
				if(c.getName().equals(key)) {
					value = URLDecoder.decode(c.getValue(), "UTF-8");
					break;
				}
			}
		}
		
		System.out.println("readCookie : " + key + ", " + value);

		return value;
	}
	public static void deleteCookie(HttpServletResponse res, String key) throws UnsupportedEncodingException {
		System.out.println("deleteCookie : " + key);
		makeCookie(res, key, "", 0);
	}
}
