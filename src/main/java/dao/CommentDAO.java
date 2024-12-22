package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import common.JDBConnect;
import dto.CommentDTO;

public class CommentDAO extends JDBConnect{

    // 댓글 추가
    public boolean insertComment(CommentDTO comment) {
        String sql = "INSERT INTO comment (content, user_email, board_id) VALUES (?, ?, ?)";
        try {
        	pstmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
        	
            pstmt.setString(1, comment.getContent());
            pstmt.setString(2, comment.getUserEmail());
            pstmt.setInt(3, comment.getBoardId());
            int result = pstmt.executeUpdate();

            System.out.println("CommentDAO insertComment success");

            // 삽입 후 자동 생성된 키를 가져오기
            if (result > 0) {
	            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
	                if (generatedKeys.next()) {
	                    comment.setId(generatedKeys.getInt(1)); // 생성된 commentId 설정
	                }
	            }
            }
            
            return result > 0 ;
        } catch (SQLException e) {
        	e.printStackTrace();
            System.out.println("CommentDAO insertComment failed: " + e.getMessage());
        }
        return false;
    }
    
    //답글 추가
    public boolean insertRecomment(CommentDTO comment) {
        String sql = "INSERT INTO comment (content, user_email, board_id, parent_comment_id) VALUES (?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, comment.getContent());
            pstmt.setString(2, comment.getUserEmail());
            pstmt.setInt(3, comment.getBoardId());
            pstmt.setInt(4, comment.getParentCommentId()); // 부모 댓글 ID
            int result = pstmt.executeUpdate();
            
            System.out.println("CommentDAO insertRecomment success");
            
            // 삽입 후 자동 생성된 키를 가져오기
            if (result > 0) {
	            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
	                if (generatedKeys.next()) {
	                    comment.setId(generatedKeys.getInt(1)); // 생성된 commentId 설정
	                }
	            }
            }
            
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("CommentDAO insertRecomment failed: " + e.getMessage());
        }
        return false;
    }

  	public CommentDTO getCommentById(int commentId) {
  		CommentDTO dto = null;
	    try {
	    	
	        String sql = "SELECT * FROM comment WHERE id = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, commentId);
	        
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
            
	        	dto = new CommentDTO();
	        	
	        	dto.setId(rs.getInt("id"));
	        	dto.setContent(rs.getString("content"));
	        	dto.setDate(rs.getDate("date"));
	        	dto.setParentCommentId(rs.getInt("parent_comment_id"));
	        	dto.setLikeCount(rs.getInt("like_count"));
	        	dto.setUserEmail(rs.getString("user_email"));
	        	dto.setReportState(rs.getInt("report_state"));
	        	dto.setBoardId(rs.getInt("board_id"));
	        	
	        }
	        System.out.println("CommentDAO getCommentById success");
	    } catch (Exception e) {
	    	System.out.println("CommentDAO getCommentById Exception: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return dto;
  	}
  	
    // 댓글 조회
    public List<CommentDTO> getCommentByBoardId(int id) {
    	List<CommentDTO> comments = new ArrayList<>();
    	
        String sql = "SELECT * FROM comment WHERE board_id = ? and parent_comment_id is null ORDER BY date desc";
        
        try{
        	pstmt = conn.prepareStatement(sql);
        	pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                CommentDTO comment = new CommentDTO();
                comment.setId(rs.getInt("id"));
                comment.setContent(rs.getString("content"));
                comment.setDate(rs.getDate("date"));
                comment.setParentCommentId(rs.getInt("parent_comment_id"));
                comment.setLikeCount(rs.getInt("like_count"));
                comment.setUserEmail(rs.getString("user_email"));
                comment.setReportState(rs.getInt("report_state"));
                comment.setBoardId(rs.getInt("board_id"));
                comments.add(comment);
            }
            System.out.println("CommentDAO getCommentByBoardId success : "+comments.size());
        } catch (SQLException e) {
            System.out.println("CommentDAO getCommentByBoardId failed: " + e.getMessage());
        	e.printStackTrace();
        }
        return comments; // 댓글을 찾지 못한 경우
    }
    
    
    public List<CommentDTO> getAllComments(int parentId) {
        List<CommentDTO> comments = new ArrayList<>();
        // 1차 답글 가져오기
        List<CommentDTO> directReplies = getReComment(parentId);
        comments.addAll(directReplies); // 1차 답글 추가

        // 각 1차 답글에 대해 재귀 호출하여 모든 답글 가져오기
        for (CommentDTO reply : directReplies) {
            comments.addAll(getAllComments(reply.getId())); // 재귀 호출
        }
        
        return comments;
    }
    
    
    public List<CommentDTO> getReComment(int parentid) {
    	List<CommentDTO> comments = new ArrayList<>();
    	
        String sql = "SELECT * FROM comment WHERE parent_comment_id = ? ORDER BY date asc";
        
        try{
        	pstmt = conn.prepareStatement(sql);
        	pstmt.setInt(1, parentid);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                CommentDTO comment = new CommentDTO();
                comment.setId(rs.getInt("id"));
                comment.setContent(rs.getString("content"));
                comment.setDate(rs.getDate("date"));
                comment.setParentCommentId(rs.getInt("parent_comment_id"));
                comment.setLikeCount(rs.getInt("like_count"));
                comment.setUserEmail(rs.getString("user_email"));
                comment.setReportState(rs.getInt("report_state"));
                comment.setBoardId(rs.getInt("board_id"));
                comments.add(comment);
            }
            System.out.println("CommentDAO getReComment success : "+comments.size());
        } catch (SQLException e) {
            System.out.println("CommentDAO getReComment failed: " + e.getMessage());
        	e.printStackTrace();
        }
        return comments; // 댓글을 찾지 못한 경우
    }

    // 댓글 수정
    public boolean updateComment(int commentid, String updateContent, Date date) {
        String sql = "UPDATE comment SET content = ?, `date` = ? WHERE id = ?";
        
        try{
        	pstmt = conn.prepareStatement(sql);
        	
            pstmt.setString(1, updateContent);
            pstmt.setTimestamp(2, new java.sql.Timestamp(date.getTime()));
            pstmt.setInt(3, commentid);
            
            int result = pstmt.executeUpdate();
            System.out.println("CommentDAO updateComment success : "+result);

            return result > 0;
        } catch (SQLException e) {
            System.out.println("CommentDAO updateComment failed: " + e.getMessage());
        	e.printStackTrace();
        }
        return false;
    }

    // 댓글 삭제
    public boolean deleteComment(int commentid) {
    	String delRecommtsql = "DELETE FROM comment WHERE parent_comment_id = ?";
        String delCommtsql = "DELETE FROM comment WHERE id = ?";
        try{
        	pstmt = conn.prepareStatement(delRecommtsql);
            pstmt.setInt(1, commentid);
            pstmt.executeUpdate();
            
            pstmt = conn.prepareStatement(delCommtsql);
            pstmt.setInt(1, commentid);
            int result = pstmt.executeUpdate();
            
            System.out.println("CommentDAO deleteComment success ");

            return result >0;
        } catch (SQLException e) {
            System.out.println("CommentDAO deleteComment failed: " + e.getMessage());
        	e.printStackTrace();
        }
        return false;
    }

    public List<CommentDTO> getCommentByUser(String email){
    	List<CommentDTO> commentList = new ArrayList<CommentDTO>();
    	String sql = "SELECT * FROM comment WHERE user_email = ?";
    	
    	try {
    		pstmt=conn.prepareStatement(sql);
    		pstmt.setString(1, email);
    		rs= pstmt.executeQuery();
    		
    		while(rs.next()) {
    			CommentDTO comment = new CommentDTO();
    			comment.setId(rs.getInt("id"));
                comment.setContent(rs.getString("content"));
                comment.setDate(rs.getDate("date"));
                comment.setParentCommentId(rs.getInt("parent_comment_id"));
                comment.setLikeCount(rs.getInt("like_count"));
                comment.setUserEmail(rs.getString("user_email"));
                comment.setReportState(rs.getInt("report_state"));
                comment.setBoardId(rs.getInt("board_id"));
                commentList.add(comment);
    		}
            System.out.println("CommentDAO getCommentByUser success :"+ commentList.size());
    	}catch (SQLException e) {
            System.out.println("CommentDAO getCommentByUser failed: " + e.getMessage());
        	e.printStackTrace();
        }
    	return commentList;
    }
    

    public String getParentCommentNickname(int parentCommentId) {
    	String parentNickname = null;
        String sql = "SELECT pu.nickname " +
                     "FROM comment pc " +
                     "LEFT JOIN user pu ON pc.User_email = pu.email " +
                     "WHERE pc.id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, parentCommentId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    parentNickname = rs.getString("nickname");
                }
            }
            
        } catch (SQLException e) {
            System.out.println("CommentDAO getParentCommentNickname failed: " + e.getMessage());
            e.printStackTrace();  // 예외 처리
        }
        
        return parentNickname;
    }


}
