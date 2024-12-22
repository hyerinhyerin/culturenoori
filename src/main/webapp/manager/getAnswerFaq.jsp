<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>  

<%
    String dbURL = "jdbc:mysql://localhost:3306/culturenoori"; // 데이터베이스 URL
    String dbUser = "root"; // 데이터베이스 사용자명
    String dbPass = "1234"; // 데이터베이스 비밀번호

    String faqId = request.getParameter("faqId");
    String faqComment = request.getParameter("faqComment");
    

    
 // faqId가 빈 문자열인지 체크
    if (faqId == null || faqId.trim().isEmpty()) {
        out.println("유효하지 않은 FAQ ID입니다.");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 데이터베이스에 연결
        Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL JDBC 드라이버
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // SQL 쿼리 준비
        String sql =  "UPDATE faq SET comment = ?, com_date = NOW() WHERE id = ?";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1,faqComment);
   			pstmt.setInt(2, Integer.parseInt(faqId));

        // 쿼리 실행
        int rowsAffected = pstmt.executeUpdate();
        
        System.out.println("[rowsAffected] rowsAffected : " + rowsAffected);
        
        if (rowsAffected > 0) {
        	 // 성공적으로 등록된 경우

            
          	JSONObject jsonObject = new JSONObject();
          	jsonObject.put("result", "success");
          	response.setContentType("application/json");
          	response.setCharacterEncoding("UTF-8");
          	response.getWriter().write(jsonObject.toString());
            
//             return; // 리다이렉트 후 코드 실행 중지

        } else {
            out.println("답변 등록에 실패했습니다.");
        }
    } catch (Exception e) {
    	 e.printStackTrace(new PrintWriter(out)); // JspWriter를 PrintWriter로 변환
         out.println("오류가 발생했습니다: " + e.getMessage());
    } finally {
        // 자원 해제
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
    