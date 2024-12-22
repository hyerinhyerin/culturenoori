<%@page import="org.json.JSONObject"%>
<%@page import="dao.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	 String commentIdStr = request.getParameter("commentId");
	 int commentId = Integer.parseInt(commentIdStr);
	
	 CommentDAO commentDao = new CommentDAO();
	 boolean result = commentDao.deleteComment(commentId);
	 commentDao.close();
	
	 System.out.println("[deleteCommentProc] result : " + result);
	
	 JSONObject jsonObject = new JSONObject();
	 jsonObject.put("success", result);
	 response.setContentType("application/json");
	 response.setCharacterEncoding("UTF-8");
	
   response.getWriter().write(jsonObject.toString());
%>