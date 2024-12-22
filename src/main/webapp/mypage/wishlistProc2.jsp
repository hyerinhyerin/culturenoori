<%@page import="dao.PerformDetailDAO"%>
<%@page import="dao.PerformDAO"%>
<%@page import="dto.TheaterDTO"%>
<%@page import="dto.PerformDetailDTO"%>
<%@page import="dto.PerformDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.WishDAO"%>
<%@page import="dto.WishDTO"%>
<%@page import="common.JDBConnect"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>

<%
String userEmail = request.getParameter("user_email");
String detailId = request.getParameter("perform_detail_id");
boolean like = Boolean.parseBoolean(request.getParameter("like"));

try {
    // JDBConnect 클래스를 사용하여 데이터베이스 연결
    JDBConnect jdbc = new JDBConnect();
    Connection conn = jdbc.conn;
    
    WishDAO wishDAO = new WishDAO(conn);
    WishDTO wishDTO = new WishDTO();
    wishDTO.setUser_email(userEmail);
    wishDTO.setPerform_detail_id(detailId);

    if (like) {
        // 좋아요 추가
        wishDAO.addWish(wishDTO);
        out.print("좋아요 추가 완료");
    } else {
        // 좋아요 제거
        wishDAO.removeWish(wishDTO);
        out.print("좋아요 제거 완료");
    }

    // 데이터베이스 연결 종료
    jdbc.close();
} catch (SQLException e) {
    e.printStackTrace();
    out.print("오류 발생: " + e.getMessage());
}
%>
