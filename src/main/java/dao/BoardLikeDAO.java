package dao;

import java.sql.SQLException;

import common.JDBConnect;

public class BoardLikeDAO extends JDBConnect{
	public boolean insertBoardLike(int boardId, String userEmail) {
		String sql = "INSERT INTO board_like (board_id, user_email) VALUES (?, ?)";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,boardId);
			pstmt.setString(2,userEmail);
			
			int result = pstmt.executeUpdate();
			System.out.println("BoardLikeDAO insertBoardLike success" );

			return result > 0;
		}catch(SQLException e) {
			System.out.println("BoardLikeDAO insertBoardLike Exception : " + e.toString());
			e.printStackTrace();
            return false;
		}
	}
	
	// 이미 좋아요를 눌렀는지 확인하는 메소드
    public boolean isClicked(int boardId, String userEmail) {
        String sql = "SELECT COUNT(*) FROM board_like WHERE board_id = ? AND user_email = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, boardId);
            pstmt.setString(2, userEmail);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;  // 이미 좋아요가 눌렸다면 true 반환
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;  // 좋아요가 눌리지 않았을 경우 false 반환
    }

    // 좋아요 삭제 메소드
    public boolean deleteBoardLike(int boardId, String userEmail) {
        String sql = "DELETE FROM board_like WHERE board_id = ? AND user_email = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, boardId);
            pstmt.setString(2, userEmail);
            
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
