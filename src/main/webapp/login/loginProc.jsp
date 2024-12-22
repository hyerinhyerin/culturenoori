<%@page import="org.json.JSONObject"%>
<%@page import="common.LoginManager"%>
<%@page import="dto.UserDTO"%>
<%@page import="dao.UserDAO"%>
<%@page import="utils.JSFunction"%>
<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String entered_account = request.getParameter("user_account");
	String entered_pw = request.getParameter("user_pw");
	String save_check = request.getParameter("save_check");
	
	
	UserDAO dao = new UserDAO();
	
	Object[] result = dao.checkAccount(entered_account);
	
	JSONObject resultJson = (JSONObject)result[0];
	UserDTO user = (UserDTO)result[1];
	
	dao.close();

	
	if(resultJson.get("result") == "possible"){
		
		JSFunction.alertBack("계정 정보 확인.", out);
		
	}else if(resultJson.get("result") == "already"){
		
		if(LoginManager.isMatched(user, entered_account, entered_pw)){

			// 유저 아이디 쿠키에 저장
			boolean isSave = save_check != null && save_check.equals("on");
			LoginManager.login(response, session, user, entered_account, entered_pw, isSave);

			String redirectUrl = request.getParameter("redirect");
			System.out.println("Redirect URL: " + redirectUrl);
			
			if (redirectUrl != null && !redirectUrl.equals("null")) {
				if(redirectUrl.contains("join.jsp") || redirectUrl.contains("login.jsp")){
        	response.sendRedirect("../main.jsp"); // 기본 페이지로 리디렉션
				}else{
	        response.sendRedirect(redirectUrl); // 저장된 URL로 리디렉션
				}
	    } else {
        response.sendRedirect("../main.jsp"); // 기본 페이지로 리디렉션
	    }
		}else{
			JSFunction.alertBack("비밀번호 확인.", out);
		}
	}
	
%>










