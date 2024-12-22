<%@page import="dao.UserDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, org.json.JSONArray, org.json.JSONObject" %>

<%
    response.setContentType("application/json;charset=UTF-8");
    JSONArray jsonResponse = new JSONArray();
    String jdbcURL = "jdbc:mysql://localhost:3306/culturenoori"; 
    String jdbcUsername = "root"; 
    String jdbcPassword = "1234"; 
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        statement = connection.createStatement();
        String sql = "SELECT id,title, contents, User_email, date, comment, com_date FROM faq";
        resultSet = statement.executeQuery(sql);
        
    

        while (resultSet.next()) {
            JSONObject question = new JSONObject();
            
            UserDAO userdao = new UserDAO();
            String nick = userdao.findNicknameByEmail(resultSet.getString("User_email"));
            
            question.put("id", resultSet.getString("id"));
            question.put("title", resultSet.getString("title"));
            question.put("contents", resultSet.getString("contents"));
            question.put("User_email", resultSet.getString("User_email"));
            question.put("date", resultSet.getString("date"));
            question.put("nickname", nick);
            
         // comment�� com_date�� NULL�� �ƴ� ��쿡�� �߰�
            String comment = resultSet.getString("comment");
            String comDate = resultSet.getString("com_date");

            if (comment != null) {
                question.put("comment", comment);
            } else {
                question.put("comment", ""); // NULL�� ��� �� ���ڿ��� �߰�
            }

            if (comDate != null) {
                question.put("com_date", comDate);
            } else {
                question.put("com_date", ""); // NULL�� ��� �� ���ڿ��� �߰�
            }

            System.out.println("ID: " + resultSet.getString("id") + 
                               ", Title: " + resultSet.getString("title") +
                               ", Comment: " + comment +
                               ", Comment Date: " + comDate);

            jsonResponse.put(question);
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        if (resultSet != null) try { resultSet.close(); } catch (SQLException e) {}
        if (statement != null) try { statement.close(); } catch (SQLException e) {}
        if (connection != null) try { connection.close(); } catch (SQLException e) {}
    }

    out.print(jsonResponse.toString());
%>
