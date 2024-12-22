package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.FaqDTO;

public class FaqDAO {

	
	private Connection getConnection() {
	    Connection conn = null;
	    try {
	        // MySQL JDBC 드라이버 로드
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        
	        // 데이터베이스 연결 (DB URL, 사용자명, 비밀번호 입력)
	        String url = "jdbc:mysql://localhost:3306/culturenoori";  // DB URL
	        String user = "root";  // DB 사용자명
	        String password = "1234";  // DB 비밀번호
	        
	        conn = DriverManager.getConnection(url, user, password);
	        System.out.println("DB 연결 성공"); // 연결 성공 메시지
	    } catch (ClassNotFoundException e) {
	        // 드라이버를 찾을 수 없는 경우 예외 처리
	        e.printStackTrace();
	        System.out.println("JDBC 드라이버를 찾을 수 없습니다.");
	        
	    } catch (SQLException e) {
	        // SQL 관련 예외 처리
	        e.printStackTrace();
	        System.out.println("데이터베이스 연결에 실패했습니다.");
	    }
	    
	    return conn;  // 예외가 발생해도 null을 반환
	}

	
	
	//신규 문의 목록 가져오기 
	public List<FaqDTO> getNewFaqs() {
	    List<FaqDTO> faqList = new ArrayList<>();
	    String sql = "SELECT * FROM faq WHERE comment IS NULL";  // comment가 없는 문의(신규 문의)
	    
	    try (Connection conn = getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         ResultSet rs = pstmt.executeQuery()) {

	        while (rs.next()) {
	            FaqDTO faq = new FaqDTO();
	            faq.setId(rs.getInt("id"));
	            faq.setTitle(rs.getString("title"));
	            faq.setContents(rs.getString("contents"));
	            faq.setDate(rs.getString("date"));
	            faq.setUserEmail(rs.getString("User_email"));
	            faqList.add(faq);  // 리스트에 추가
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();  // 예외 발생 시 에러 메시지를 콘솔에 출력
	        // 로그로 남기거나 사용자에게 에러 페이지를 표시할 수도 있음
	    }
	    
	    return faqList;  // 예외가 발생해도 빈 리스트를 반환할 수 있도록
	}

	// 완료된 문의 목록 가져오기 
	public List<FaqDTO> getCompletedFaqs() {
	    List<FaqDTO> faqList = new ArrayList<>();
	    String sql = "SELECT * FROM faq WHERE comment IS NOT NULL";  // Comment 있는 문의(완료된 문의)
	    
	    try (Connection conn = getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         ResultSet rs = pstmt.executeQuery()) {

	        while (rs.next()) {
	            FaqDTO faq = new FaqDTO();
	            faq.setId(rs.getInt("id"));
	            faq.setTitle(rs.getString("title"));
	            faq.setContents(rs.getString("contents"));
	            faq.setDate(rs.getString("date"));
	            faq.setComment(rs.getString("comment"));  // 댓글(답변)
	            faq.setComDate(rs.getString("com_date")); // 답변 날짜
	            faq.setUserEmail(rs.getString("User_email"));
	            faqList.add(faq);  // 리스트에 추가
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();  // 예외 발생 시 에러 메시지를 콘솔에 출력
	        // 로그로 남기거나 사용자에게 에러 페이지를 표시할 수도 있음
	    }
	    
	    return faqList;  // 예외가 발생해도 빈 리스트를 반환할 수 있도록
	}
	
	


	
	public void updateFaqAnswer(int faqId, String comment) {
	    String sql = "UPDATE faq SET comment = ?, com_date = NOW() WHERE id = ?";
	    try (Connection conn = getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, comment); // 답변 내용
	        pstmt.setInt(2, faqId); // FAQ ID
	        int rowsAffected = pstmt.executeUpdate(); // 쿼리 실행

	        if (rowsAffected > 0) {
	            System.out.println("답변 등록 성공"); // 성공 메시지
	            
	        } else {
	            System.out.println("답변 등록 실패: 해당 ID가 존재하지 않거나 이미 답변이 등록되어 있음.");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace(); // 예외 발생 시 에러 메시지 출력
	    }
	}

	

	
	}

