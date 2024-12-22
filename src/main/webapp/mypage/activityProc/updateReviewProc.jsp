<%@page import="dao.ReviewDAO"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String reviewIdStr = request.getParameter("reviewId");
	String content = request.getParameter("content");
	
	JSONObject jsonObject = new JSONObject();
	if(reviewIdStr != null){
		int reviewId = Integer.parseInt(reviewIdStr);
		
		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime()); // java.util.Date를 java.sql.Date로 변환
		
		ReviewDAO reviewdao = new ReviewDAO();
		boolean result = reviewdao.updateReview(reviewId, content, 3);
		reviewdao.close();
		if(result){
			jsonObject.put("success", true);
		}else{
			jsonObject.put("success", false);
		}
	}
	
	System.out.println("[updateReviewProc] result : " + jsonObject.toString());

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	response.getWriter().write(jsonObject.toString());
%>