<%@page import="org.json.JSONObject"%>
<%@page import="dao.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String commentIdStr = request.getParameter("commentid");
	String content = request.getParameter("content");
	
	JSONObject jsonObject = new JSONObject();
	if(commentIdStr != null){
		int commentId = Integer.parseInt(commentIdStr);
		
		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime()); // java.util.Date를 java.sql.Date로 변환
		
		CommentDAO commentdao = new CommentDAO();
		boolean result = commentdao.updateComment(commentId, content, sqlDate);
		commentdao.close();
		if(result){
			jsonObject.put("success", true);
		}else{
			jsonObject.put("success", false);
		}
	}
	
	
	System.out.println("[updateCommentProc] result : " + jsonObject.toString());

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	response.getWriter().write(jsonObject.toString());
%>