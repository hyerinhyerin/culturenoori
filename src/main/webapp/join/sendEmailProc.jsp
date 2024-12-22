<%@page import="org.json.JSONObject"%>
<%@page import="utils.EmailSender"%>
<%@page import="common.LoginManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, javax.mail.*, javax.mail.internet.*" %>
<%
	String new_user_email = request.getParameter("email");

	boolean result = (new EmailSender().send(session, new_user_email));

	JSONObject jsonObject = new JSONObject();
	
	jsonObject.put("result", result);
	
	System.out.println("[sendEmailProc] result : " + jsonObject.toString());
	
    // 응답의 Content-Type을 JSON으로 설정
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    // JSON 객체를 응답으로 출력
    response.getWriter().write(jsonObject.toString());
    
%>
