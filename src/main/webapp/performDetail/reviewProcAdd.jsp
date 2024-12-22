<%@page import="java.sql.Timestamp"%>
<%@page import="common.LoginManager"%>
<%@page import="dto.UserDTO"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserDTO user = LoginManager.getUser();
	String detailId = request.getParameter("detailId");
	String contents = request.getParameter("contents");
	String starNumStr = request.getParameter("star_num");
	
	System.out.println("[reviewProcAdd] detailId: "+detailId);
	System.out.println("[reviewProcAdd] contents: "+contents);
	System.out.println("[reviewProcAdd] star_num: "+starNumStr);

	if(user == null){
		out.println("<script>alert('로그인이 필요합니다.');</script>");
	  response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Not Login");
	  System.out.println("[reviewProcAdd] 로그인이 필요합니다");
		return;
	}

	if (contents == null || contents.isEmpty()) {
  	response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Contents is null");
  	System.out.println("[reviewProcAdd] Contents is null ");
		return;
	}

	if (starNumStr == null || starNumStr.isEmpty()) {
  	response.sendError(HttpServletResponse.SC_BAD_REQUEST, "star number is missing.");
  	System.out.println("[reviewProcAdd] star number is missing.");
		return;
	}

	try {
	    
		int starNum = Integer.parseInt(starNumStr);
		
		ReviewDTO review = new ReviewDTO();
		
		review.setContents(contents);
		review.setStar_num(starNum);
		review.setEmail(user.getEmail());
		review.setNickname(user.getNickname());
		review.setCreate_at( new Timestamp(System.currentTimeMillis()) );
		review.setPerform_detail_id(detailId);
		
		
		ReviewDAO reviewDAO = new ReviewDAO();
		
		int reviewId = reviewDAO.insertReview(review);
		System.out.println("[reviewProcAdd] reviewId : " + reviewId);

		review = reviewDAO.getReviewById(reviewId);
	    
		reviewDAO.close();

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		JSONObject resultJson = new JSONObject();
		resultJson.put("result", (0 < reviewId));
		
		resultJson.put("data", review.toJSON());
		
		System.out.println("[reviewProcAdd] resultJson: " + resultJson.toString());
		
		response.getWriter().write(resultJson.toString());
		
	} catch (NumberFormatException e) {
	    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid star number.");
	}

%>

















