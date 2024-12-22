<%@page import="org.json.JSONObject"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String boardIdStr = request.getParameter("boardId");
	int boardId = Integer.parseInt(boardIdStr);
	
	BoardDAO dao = new BoardDAO();
	int result = dao.incrementView(boardId);
	
	dao.close();
	
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("result", result);
	
	System.out.println("[viewcountProc] result : " + jsonObject.toString());

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	response.getWriter().write(jsonObject.toString());
%>