package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBConnect {
	public Connection conn;
	public Statement stmt;
	public PreparedStatement pstmt;
	public ResultSet rs;
	
	public JDBConnect(){
	    try {
//	        String url = "jdbc:mysql://localhost:3306/culturenooridb";
	        String url = "jdbc:mysql://localhost:3306/culturenoori";
	        String id = "root";
	        String pw = "1234";
	        
	        Class.forName("com.mysql.cj.jdbc.Driver");
//	        Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection(url, id, pw);	
			
			if(conn != null)
				System.out.println("JDBConnect connect success.!!");
			else
				System.out.println("JDBConnect connect fail.!!");
	        
	    } catch (Exception e) {
	    	System.out.println("JDBConnect open Exception : " + e.toString());
	        e.printStackTrace();
	    } 
	}
	
	public void close() {
		
		try {
			System.out.println("JDBConnect close .!!");

			if (rs != null) try { rs.close(); } catch (SQLException e) {}
	        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
	        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
	        if (conn != null) try { conn.close(); } catch (SQLException e) {}
			
		}catch(Exception e) {
	    	System.out.println("JDBConnect close Exception : " + e.toString());
			e.printStackTrace();
		}
	}
}
