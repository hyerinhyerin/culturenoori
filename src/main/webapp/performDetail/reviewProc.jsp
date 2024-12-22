<%@page import="dto.UserDTO"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="common.LoginManager" %>
<%@page import="java.util.*"%>
<%
    HttpSession reviewSession = request.getSession();
    String detailId = (String)session.getAttribute("detailId");
    UserDTO user = LoginManager.getUser();

    System.out.println("reviewProc detailid: "+detailId);
    
    ReviewDAO reviewDAO = new ReviewDAO();
    List<ReviewDTO> reviews = new ArrayList<>();

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String action = request.getParameter("action");

        if ("write".equals(action)) {
            String contents = request.getParameter("contents");
            String starNumStr = request.getParameter("star_num");
            int starNum = 0;

            if (contents == null || contents.isEmpty() || starNumStr == null || starNumStr.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Contents or star number is missing.");
                return;
            }

            try {
                starNum = Integer.parseInt(starNumStr);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid star number.");
                return;
            }

            if (user == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in.");
                return;
            }

            ReviewDTO review = new ReviewDTO();
            review.setContents(contents);
            review.setStar_num(starNum);
            review.setEmail(user.getEmail());
            review.setPerform_detail_id(detailId);

            boolean isInserted = reviewDAO.writeReview(review);
            if (!isInserted) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to insert review.");
                return;
            }
        } else if ("delete".equals(action)) {
            String reviewId = request.getParameter("reviewId");
            if (reviewId != null) {
                boolean isDeleted = reviewDAO.deleteReview(Integer.parseInt(reviewId), user.getEmail());
                if (!isDeleted) {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete review.");
                    return;
                }
            }
        } else if ("update".equals(action)) {
            String reviewId = request.getParameter("reviewId");
            String contents = request.getParameter("contents");
            String starNumStr = request.getParameter("star_num");
            int starNum = Integer.parseInt(starNumStr);

            if (reviewId != null && contents != null && !contents.isEmpty()) {
                boolean isUpdated = reviewDAO.updateReview(Integer.parseInt(reviewId), contents, starNum);
                if (!isUpdated) {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update review.");
                    return;
                }
            }
        }

        reviews = reviewDAO.getAllReview(detailId);
        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("../performDetail/reviewList.jsp").include(request, response);
        return;
    }

    try {
        reviews = reviewDAO.getAllReview(detailId);
    } catch (Exception e) {
        e.printStackTrace();
    }

    request.setAttribute("reviews", reviews);
%>