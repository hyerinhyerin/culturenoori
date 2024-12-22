package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.WishDTO;
import dto.PerformDTO;
import dto.PerformDetailDTO;

public class WishDAO {
    private Connection conn;

    public WishDAO(Connection connection) {
        this.conn = connection;
    }

    public List<PerformDTO> getWishListByUserEmail(String userEmail) {
        List<PerformDTO> wishList = new ArrayList<>();
        String query = "SELECT * FROM vw_user_wishlist WHERE user_email = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, userEmail);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                // PerformDTO 생성 및 설정
                PerformDTO perform = new PerformDTO();
                perform.setId(rs.getInt("perform_id"));  // Perform 테이블의 ID
                perform.setName(rs.getString("perform_name"));

                // PerformDetailDTO 생성 및 설정
                PerformDetailDTO detail = new PerformDetailDTO();
                detail.setId(rs.getString("Perform_Detail_id"));  // PerformDetail 테이블의 ID
                perform.setStart(rs.getString("start"));
                perform.setEnd(rs.getString("end"));
                detail.setImg_path(rs.getString("img_path"));

                // PerformDTO에 PerformDetailDTO 설정
                perform.setDetail(detail);

                // 관심 목록에 추가
                wishList.add(perform);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return wishList;
    }
    
    // 위시 추가 메서드
    public void addWish(WishDTO wish) throws SQLException {
        String sql = "INSERT INTO wish (wish_dt, Perform_Detail_id, User_email) VALUES (NOW(), ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, wish.getPerform_detail_id());
            pstmt.setString(2, wish.getUser_email());
            pstmt.executeUpdate();
        }
    }

    // 위시 제거 메서드
    public void removeWish(WishDTO wish) throws SQLException {
        String sql = "DELETE FROM wish WHERE Perform_Detail_id = ? AND User_email = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, wish.getPerform_detail_id());
            pstmt.setString(2, wish.getUser_email());
            pstmt.executeUpdate();
        }
    }
    
    public boolean checkWish(String perform_detail_id, String user_email){
    	String sql = "SELECT * FROM wish WHERE Perform_Detail_id = ? AND User_email = ?";
    	try(PreparedStatement pstmt = conn.prepareStatement(sql)){
    		pstmt.setString(1, perform_detail_id);
    		pstmt.setString(2, user_email);
    		try(ResultSet rs = pstmt.executeQuery()){
    			if(rs.next()) {
    				return true;
    			}
    		}
    		
    	}catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("WishDAO checkWish Exception : " + e.toString());
    	}
    	return false;
    }
    
    public void close() throws SQLException {
        if (conn != null && !conn.isClosed()) {
            conn.close();
        }
    }
}
