<%@page import="dao.CommentDAO"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String commentIdStr = request.getParameter("commentId");
	
	JSONObject jsonObject = new JSONObject();
	if(commentIdStr != null){
		int commentId = Integer.parseInt(commentIdStr);
		
		CommentDAO commentdao = new CommentDAO();
		boolean result = commentdao.deleteComment(commentId);
		commentdao.close();

		if(result){
			jsonObject.put("result", true);
		}else{
			jsonObject.put("result", false);
		}
	}
	
	System.out.println("[deleteCommentProc] result : " + jsonObject.toString());

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	response.getWriter().write(jsonObject.toString());
%>