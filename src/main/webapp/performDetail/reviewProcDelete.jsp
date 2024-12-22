<%@page import="dto.ReviewDTO"%>
<%@page import="common.LoginManager"%>
<%@page import="dto.UserDTO"%>
<%@page import="org.json.JSONObject"%>
<%@page import="dao.ReviewDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // 현재 로그인한 사용자 가져오기
    UserDTO user = LoginManager.getUser();
    String reviewIdStr = request.getParameter("reviewId");

    // 파라미터 검증
    if (user == null || reviewIdStr == null || reviewIdStr.isEmpty()) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input data.");
        return;
    }

    int reviewId = Integer.parseInt(reviewIdStr);

    ReviewDAO reviewDAO = new ReviewDAO();

    // 현재 리뷰를 작성한 사용자가 본인인지 확인
    ReviewDTO review = reviewDAO.getReviewById(reviewId);
    if (review == null || !review.getEmail().equals(user.getEmail())) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Permission denied.");
        return;
    }

    // 리뷰 삭제 처리
    boolean result = reviewDAO.deleteReview(reviewId, user.getEmail());

    // 응답 처리
    JSONObject resultJson = new JSONObject();
    resultJson.put("result", result);
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(resultJson.toString());

    reviewDAO.close();
%>
