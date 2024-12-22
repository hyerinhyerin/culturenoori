package dao;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import common.JDBConnect;
import dto.PerformDTO;
import dto.PerformDetailDTO;
import dto.ViewPerformDTO;

import dto.PerformDTO;

public class ViewPerformDAO extends JDBConnect {
	public List<ViewPerformDTO> getWishList(String userEmail, String rootPath) {
	    
	    List<ViewPerformDTO> list = new ArrayList<ViewPerformDTO>();
	    
	    String query = "SELECT * FROM vw_user_wishlist WHERE email = ?";
	    
	    try {
	        pstmt = conn.prepareStatement(query);
	        pstmt.setString(1, userEmail);  // user_email 바인딩
	        System.out.println("[PerformDAO.getWishList] pstmt : " + pstmt.toString());
	        
	        rs = pstmt.executeQuery();
	        
	        while (rs.next()) {
	            ViewPerformDTO dto = new ViewPerformDTO();
	            
	            dto.setName(rs.getString(ViewPerformDTO.NAME));
	            dto.setStart(rs.getString(ViewPerformDTO.START));
	            dto.setEnd(rs.getString(ViewPerformDTO.END));
	            dto.setPerform_detail_id(rs.getString(ViewPerformDTO.PERFORM_DETAIL_ID));
	            dto.setState(rs.getString(ViewPerformDTO.STATE));
	            dto.setImg_path(PerformDTO.makeRelativeImagePath(rs.getString(ViewPerformDTO.IMG), rootPath));

	            dto.setVenue_name(rs.getString(ViewPerformDTO.VENUE_NAME));
	            
	            list.add(dto);
	            
	            System.out.println("[PerformDAO.getWishList] dto : " + dto.toString());
	        }
	        
	    } catch (Exception e) {
	        System.err.println("[PerformDAO.getWishList] Exception : " + e.toString());
	        e.printStackTrace();
	    }
	    
	    return list;
	}
}
