package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import common.JDBConnect;
import dto.CommentLikeDTO;

public class CommentLikeDAO extends JDBConnect{

    // 좋아요 추가
	public boolean insertLike(CommentLikeDTO like) {
		String sql = "INSERT INTO comment_like (comment_id, user_email) VALUES (?, ?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, like.getCommentId());
			pstmt.setString(2, like.getUserEmail());
			int result = pstmt.executeUpdate();
			
			System.out.println("CommentLikeDAO likedao success: "+result);

			return result > 0;
		}catch(SQLException e) {
			System.out.println("CommentLikeDAO likedao exception: "+e.toString());
			e.printStackTrace();
		}
		return false;
	}
    
    
    // 좋아요 삭제
    public boolean deleteLike(CommentLikeDTO like) {
        String sql = "DELETE FROM comment_like WHERE comment_id = ? AND user_email = ?";
        
        try{
        	pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, like.getCommentId());
            pstmt.setString(2, like.getUserEmail());
            int result = pstmt.executeUpdate();
            
			System.out.println("CommentLikeDAO deleteLike success: "+result);

            return result > 0;
        }catch(SQLException e) {
			System.out.println("CommentLikeDAO deleteLike exception: "+e.toString());
			e.printStackTrace();
		}
        return false;
    }

   public boolean isLiked(int commentId, String email) {
	   String sql="SELECT COUNT(*) FROM comment_like WHERE comment_id = ? AND user_email = ?";
	   boolean result=false;
	   try {
		   pstmt=conn.prepareStatement(sql);
		   pstmt.setInt(1, commentId);
		   pstmt.setString(2, email);
           rs = pstmt.executeQuery();
           
           if(rs.next()) {
        	   result = (rs.getInt(1) > 0);
           }
			System.out.println("CommentLikeDAO isLiked success: "+result);
	   }catch(SQLException e) {
			System.out.println("CommentLikeDAO isLiked exception: "+e.toString());
			e.printStackTrace();
		}
	   return result;
   }
    

    // 특정 댓글에 대한 좋아요 조회
//    public List<CommentLikeDTO> getLikesByCommentId(int commentId) throws SQLException {
//        List<CommentLikeDTO> likes = new ArrayList<>();
//        String sql = "SELECT * FROM comment_likes WHERE comment_id = ?";
//        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
//            pstmt.setInt(1, commentId);
//            ResultSet rs = pstmt.executeQuery();
//            while (rs.next()) {
//                CommentLikeDTO like = new CommentLikeDTO();
//                like.setDate(rs.getDate("date"));
//                like.setCommentId(rs.getInt("comment_id"));
//                like.setUserEmail(rs.getString("user_email"));
//                likes.add(like);
//            }
//        }
//        return likes;
//    }



//    // 좋아요 수 조회
//    public int countLikes(int commentId) throws SQLException {
//        String sql = "SELECT COUNT(*) FROM comment_likes WHERE comment_id = ?";
//        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
//            pstmt.setInt(1, commentId);
//            ResultSet rs = pstmt.executeQuery();
//            if (rs.next()) {
//                return rs.getInt(1); // 좋아요 수 반환
//            }
//        }
//        return 0;
//    }
    
    
    
}
