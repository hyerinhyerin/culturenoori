<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, org.json.JSONObject" %>
<%
    response.setContentType("application/json;charset=UTF-8");
    JSONObject jsonResponse = new JSONObject();
    String jdbcURL = "jdbc:mysql://localhost:3306/culturenoori"; 
    String jdbcUsername = "root"; 
    String jdbcPassword = "1234"; 
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        String questionId = request.getParameter("id");
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        
        String sql = "DELETE FROM faq WHERE id = ?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, Integer.parseInt(questionId));
        
        int rowsAffected = preparedStatement.executeUpdate();
        
        if (rowsAffected > 0) {
            jsonResponse.put("success", true);
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "질문을 찾을 수 없습니다.");
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        jsonResponse.put("success", false);
        jsonResponse.put("message", "서버 오류가 발생했습니다.");
    } finally {
        if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) {}
        if (connection != null) try { connection.close(); } catch (SQLException e) {}
    }

    out.print(jsonResponse.toString());
%>