<%@page import="org.json.JSONObject"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String boardIdStr = request.getParameter("boardId");
	
	JSONObject jsonObject = new JSONObject();
	if(boardIdStr != null){
		int boardId = Integer.parseInt(boardIdStr);
		
		BoardDAO boarddao = new BoardDAO();
		boolean result = boarddao.deleteBoard(boardId);
		boarddao.close();

		if(result){
			jsonObject.put("result", true);
		}else{
			jsonObject.put("result", false);
		}
	}
	
	System.out.println("[deleteBoard] result : " + jsonObject.toString());

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	response.getWriter().write(jsonObject.toString());
%>