<%@page import="common.LoginManager"%>
<%@page import="dto.UserDTO"%>
<%@page import="org.json.JSONObject"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="dto.ReviewDTO"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // 현재 로그인한 사용자 가져오기
    UserDTO user = LoginManager.getUser();
    String reviewIdStr = request.getParameter("reviewId");
    String contents = request.getParameter("contents");
    String starNumStr = request.getParameter("star_num");

    // 파라미터 검증
    if (user == null || reviewIdStr == null || contents == null || contents.isEmpty() || starNumStr == null || starNumStr.isEmpty()) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input data.");
        return;
    }

    int reviewId = Integer.parseInt(reviewIdStr);
    int starNum = Integer.parseInt(starNumStr);

    ReviewDAO reviewDAO = new ReviewDAO();

    // 현재 리뷰를 작성한 사용자가 본인인지 확인
    ReviewDTO review = reviewDAO.getReviewById(reviewId);
    if (review == null || !review.getEmail().equals(user.getEmail())) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Permission denied.");
        return;
    }
    
    boolean result = reviewDAO.updateReview(reviewId, contents, starNum);

    JSONObject resultJson = new JSONObject();
    resultJson.put("result", result);
    
    if(result){
    	ReviewDTO updatedReview = reviewDAO.getReviewById(reviewId);
    	resultJson.put("data", updatedReview.toJSON());
    }
    
    // 리뷰 수정 처리

    // 응답 처리
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(resultJson.toString());

    reviewDAO.close();
%>
