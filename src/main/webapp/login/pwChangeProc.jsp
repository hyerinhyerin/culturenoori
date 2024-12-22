<%@page import="org.json.JSONObject"%>
<%@page import="dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String account = request.getParameter("account");
	String newPassword= request.getParameter("newPassword");
	
	UserDAO dao = new UserDAO();
	boolean result = dao.changePassword(account, newPassword);
	dao.close();
	
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("result", result);
	
	System.out.println("[pwChangeProc] result : " + jsonObject.toString());

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	response.getWriter().write(jsonObject.toString());
%>