<%@page import="dao.ReviewDAO"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String reviewIdStr = request.getParameter("reviewId");
	String userEmail = request.getParameter("userEmail");
	
	JSONObject jsonObject = new JSONObject();
	if(reviewIdStr != null){
		int reviewId = Integer.parseInt(reviewIdStr);
		
		ReviewDAO reviewdao = new ReviewDAO();
		boolean result = reviewdao.deleteReview(reviewId, userEmail);
		reviewdao.close();

		if(result){
			jsonObject.put("result", true);
		}else{
			jsonObject.put("result", false);
		}
	}
	
	System.out.println("[deleteReviewProc] result : " + jsonObject.toString());

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	response.getWriter().write(jsonObject.toString());
%>