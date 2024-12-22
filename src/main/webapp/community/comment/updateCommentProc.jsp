<%@page import="dao.CommentDAO"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String commentIdStr = request.getParameter("commentId");
	String updatedContent = request.getParameter("updatedContent");
	
	JSONObject jsonObject = new JSONObject();
	
	if(commentIdStr != null && updatedContent != null){
		int commentId = Integer.parseInt(commentIdStr);
		
		CommentDAO commentdao = new CommentDAO();
		
		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime()); // java.util.Date를 java.sql.Date로 변환
		
		boolean result = commentdao.updateComment(commentId, updatedContent, sqlDate);
		
		commentdao.close();
		if(result){
			jsonObject.put("success", true);
		}else{
			jsonObject.put("success", false);
		}
		System.out.println("[updateCommentProc] result : " + result);

	}
	
	
	
	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	response.getWriter().write(jsonObject.toString());

%>