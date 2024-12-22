<%@page import="org.json.JSONObject"%>
<%@page import="utils.JSFunction"%>
<%@page import="common.LoginManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String user_emailCode = request.getParameter("emailCode");
	String emailCode = LoginManager.getSession(session, LoginManager.EMAIL_CODE);
	
	boolean result;
	if(!user_emailCode.equals(emailCode)){
		result=false;
	}else{
		result=true;
	}
	JSONObject jsonObject = new JSONObject();
	
	jsonObject.put("result", result);
	
	System.out.println("[emailcodeCheckProc] result : " + jsonObject.toString());
	
	// 응답의 Content-Type을 JSON으로 설정
	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	// JSON 객체를 응답으로 출력
	response.getWriter().write(jsonObject.toString());
%>
    