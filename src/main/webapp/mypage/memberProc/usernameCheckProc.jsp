<%@page import="org.json.JSONObject"%>
<%@page import="dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String username = request.getParameter("username");
	UserDAO userdao = new UserDAO();
	boolean checkNick = userdao.checkNick(username);
	
	JSONObject jsonObject = new JSONObject();
	if(checkNick){
		jsonObject.put("result", "unavailable");
	}else{
		jsonObject.put("result", "available");
	}
	
	userdao.close();
	System.out.println("[usernameCheckProc] result : " + jsonObject.toString());

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	response.getWriter().write(jsonObject.toString());
%>