<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	String detailId = request.getParameter("detailId");
	System.out.println("[reviewProcList] detailId: " + detailId);

	ReviewDAO dao = new ReviewDAO();
	List<ReviewDTO> reviews = dao.getAllReview(detailId);
	dao.close();
	
	System.out.println("[reviewProcList] reviews count : " + reviews.size());
	
	
	JSONArray jsonArray = new JSONArray();
	for (ReviewDTO review : reviews) {
	    jsonArray.put(review.toJSON());
	}
	
	System.out.println("[reviewProcList] reviews : " + reviews.toString());
	System.out.println("[reviewProcList] jsonArray : " + jsonArray.toString());

// 	[수정] - 예외처리 및 로그 추가

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	response.getWriter().write(jsonArray.toString());

%>