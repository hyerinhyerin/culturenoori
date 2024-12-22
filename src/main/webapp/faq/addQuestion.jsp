<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONObject" %>
<%
    response.setContentType("application/json;charset=UTF-8");
    JSONObject jsonResponse = new JSONObject();

    // 클라이언트로부터 데이터 수신
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
    String userEmail = request.getParameter("User_email");
		/* String date = "2024-10-02"; */
		
		// 로그로 출력
/*     System.out.println("제목: " + title);
    System.out.println("내용: " + contents);
    System.out.println("이메일: " + userEmail); */

    String jdbcURL = "jdbc:mysql://localhost:3306/culturenoori"; // DB URL
    String jdbcUsername = "root"; // DB 사용자명
    String jdbcPassword = "1234"; // DB 비밀번호

    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
    	//JDBC 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        // SQL 문 준비
        String sql = "INSERT INTO faq (title, contents, User_email) VALUES (?, ?, ?)";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, title);
        preparedStatement.setString(2, contents);
        preparedStatement.setString(3, userEmail);
        /* preparedStatement.setTimestamp(4, new Timestamp(System.currentTimeMillis())); */ // 현재 시간 설정
        // SQL 문 실행
        int rowsInserted = preparedStatement.executeUpdate();
        if (rowsInserted > 0) {
            jsonResponse.put("success", true);
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "질문 등록에 실패했습니다.");
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        jsonResponse.put("success", false);
        jsonResponse.put("message", "오류 발생: " + e.getMessage());
    } finally {
        if (preparedStatement != null) {
            try { preparedStatement.close(); } catch (SQLException e) {}
        }
        if (connection != null) {
            try { connection.close(); } catch (SQLException e) {}
        }
    }
//JSON 응답 전송
    out.print(jsonResponse.toString());
%>
    