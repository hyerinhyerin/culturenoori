package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import common.JDBConnect;
import dto.ReviewDTO;

public class ReviewDAO extends JDBConnect {
  
	
	public int insertReview(ReviewDTO review) {
		int reviewId = 0;
			
      String query = "INSERT into REVIEW (contents, create_at, star_number, User_email, perform_detail_id) VALUES(?, NOW(), ?, ?, ?)";
      
      try {
          pstmt = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
          
          pstmt.setString(1, review.getContents());
          pstmt.setInt(2, review.getStar_num());
          pstmt.setString(3, review.getEmail());
          pstmt.setString(4, review.getPerform_detail_id());
          
          int rowsAffected = pstmt.executeUpdate();
          System.out.println("[ReviewDAO.insertReview] Rows affected: " + rowsAffected);
          
          if(0 < rowsAffected) {
          	try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
              if (generatedKeys.next()) {
              	reviewId = generatedKeys.getInt(1);
                System.out.println("[ReviewDAO.insertReview] reviewId : " + reviewId);
              } else {
                System.err.println("[ReviewDAO.insertReview] No ID obtained.");
              }
          }
          }else {
          	reviewId = rowsAffected;
          }
      } catch (Exception e) {
          e.printStackTrace();
      }
      
      return reviewId;	
	}
	
    public boolean writeReview(ReviewDTO review) throws SQLException {
        String query = "INSERT into REVIEW (contents, create_at, star_number, User_email, perform_detail_id) VALUES(?, NOW(), ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, review.getContents());
            pstmt.setInt(2, review.getStar_num());
            pstmt.setString(3, review.getEmail());
            pstmt.setString(4, review.getPerform_detail_id());
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 리뷰 삭제 메서드
    public boolean deleteReview(int reviewId, String userEmail) throws SQLException {
        String query = "DELETE FROM review WHERE id = ? AND User_email = ?";
        try {
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, reviewId); // 삭제할 리뷰 ID
            pstmt.setString(2, userEmail); // 리뷰 작성자 확인 (보안)
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0; // 1 이상의 값이 리턴되면 삭제 성공
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
//    public ReviewDTO getReviewById(int reviewId) {
//      ReviewDTO review = null;
//      
//      String query = "SELECT * FROM review WHERE id = ?";
//
//      try {
//          pstmt = conn.prepareStatement(query);
//          pstmt.setInt(1, reviewId); 
//          rs = pstmt.executeQuery();
//          
//          if(rs.next()) {
//            review = new ReviewDTO();
//            
//            review.setId(rs.getInt("id"));
//            review.setContents(rs.getString("contents"));
//            review.setCreate_at(rs.getTimestamp("create_at"));
//            review.setStar_num(rs.getInt("star_number"));
//            review.setEmail(rs.getString("User_email"));
//            review.setPerform_detail_id(rs.getString("perform_detail_id"));
//            review.setNickname(rs.getString("nickname"));
//            
//          }
//      } catch (Exception e) {
//          e.printStackTrace();
//      }
//      
//      return review;
//    }
    
    
    // 한줄평 보여주는 함수
    public List<ReviewDTO> getAllReview(String detailId) {
        List<ReviewDTO> reviews = new ArrayList<>();
        String query = "SELECT r.*, u.nickname, u.img_path "
        		+ "FROM review r JOIN user u ON r.User_email = u.email WHERE r.perform_detail_id = ? ORDER By r.create_at ASC"; // detail_id로 조건을 추가

        try {
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, detailId); // 매개변수 설정
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ReviewDTO review = new ReviewDTO();
                
                review.setId(rs.getInt("id"));
                review.setContents(rs.getString("contents"));
                review.setCreate_at(rs.getTimestamp("create_at"));
                review.setStar_num(rs.getInt("star_number"));
                review.setEmail(rs.getString("User_email"));
                review.setPerform_detail_id(rs.getString("perform_detail_id"));
                review.setNickname(rs.getString("nickname"));
                review.setImg_path(rs.getString("img_path"));
                
                reviews.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return reviews;
    }
    //한줄평 수정 함수
    public boolean updateReview(int reviewId, String contents, int star_number) throws SQLException {
        String query = "UPDATE REVIEW SET contents = ?, star_number = ? WHERE id = ?";
        try {
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, contents);
            pstmt.setInt(2, star_number);
            pstmt.setInt(3, reviewId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    
    public List<ReviewDTO> getReviewByUser(String email){
    	List<ReviewDTO> reviewList = new ArrayList<>();
    	String sql = "SELECT * FROM review WHERE user_email = ?";
    	
    	try {
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, email);
    		rs = pstmt.executeQuery();
    		
    		while(rs.next()) {
    			ReviewDTO review = new ReviewDTO();
    			review.setId(rs.getInt("id"));
    			review.setContents(rs.getString("contents"));
    			review.setCreate_at(rs.getTimestamp("create_at"));
                review.setStar_num(rs.getInt("star_number"));
                review.setEmail(rs.getString("User_email"));
                review.setPerform_detail_id(rs.getString("perform_detail_id"));
    			review.setRepot_state(rs.getInt("report_state"));
    			
    			reviewList.add(review);
    		}
    	}catch(SQLException e) {
    		e.printStackTrace();
    		System.out.println("ReviewDAO getReviewByUser failed : "+e.getMessage());
    	}
    	return reviewList;
    }
    
    public ReviewDTO getReviewById(int reviewId) {
        ReviewDTO review = null;
        String query = "SELECT r.*, u.nickname, u.img_path FROM review r JOIN user u ON r.User_email = u.email WHERE r.id = ?";

        try {
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, reviewId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                review = new ReviewDTO();
                review.setId(rs.getInt("id"));
                review.setContents(rs.getString("contents"));
                review.setCreate_at(rs.getTimestamp("create_at"));
                review.setStar_num(rs.getInt("star_number"));
                review.setEmail(rs.getString("User_email"));
                review.setPerform_detail_id(rs.getString("perform_detail_id"));
                review.setNickname(rs.getString("nickname"));
                review.setImg_path(rs.getString("img_path"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return review;
    }
}