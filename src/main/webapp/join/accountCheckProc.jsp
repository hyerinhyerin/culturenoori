<%@page import="dao.UserDAO"%>
<%@page import="org.json.JSONObject"%>
<%@page import="common.JDBConnect"%>
<%@page import="common.LoginManager"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%

	String account = request.getParameter("account");
    
	UserDAO user = new UserDAO();
	
	Object[] result = user.checkAccount(account);
	JSONObject resultJson = (JSONObject)result[0];
	
	user.close();
	
    // 응답의 Content-Type을 JSON으로 설정
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    // JSON 객체를 응답으로 출력
    response.getWriter().write(resultJson.toString());
    
%>

