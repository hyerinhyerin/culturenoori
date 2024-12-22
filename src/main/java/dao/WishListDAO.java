package dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import common.JDBConnect;

public class WishListDAO extends JDBConnect{
	public boolean insertWish(String detailId, String userEmail) {
        String sql = "INSERT INTO wish (wish_dt, Perform_Detail_id, User_email) VALUES (NOW(), ?, ?)";
		try {
			pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, detailId);
            pstmt.setString(2, userEmail);
			
			int result = pstmt.executeUpdate();
			System.out.println("WishListDAO insertWish success" );

			return result > 0;
		}catch(SQLException e) {
			System.out.println("WishListDAO insertWish Exception : " + e.toString());
			e.printStackTrace();
            return false;
		}
	}
	
	// 이미 좋아요를 눌렀는지 확인하는 메소드
    public boolean isClicked(String detailId, String userEmail) {
        String sql = "SELECT COUNT(*) FROM board_like WHERE Perform_Detail_id = ? AND User_email = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, detailId);
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
    public boolean deleteWish(String detailId, String userEmail) {
        String sql = "DELETE FROM board_like WHERE Perform_Detail_id = ? AND User_email = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, detailId);
            pstmt.setString(2, userEmail);
            
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
