package dao;

import java.util.Map;

import common.JDBConnect;
import dto.PerformDTO;
import dto.TheaterDTO;

public class TheaterDAO extends JDBConnect {
	
	public int insertMap(Map<String, TheaterDTO> theaterMap) {
		
		String sql 	= "INSERT INTO theater (%s, %s, %s, %s) "
				+ "VALUES (?, ?, ?, ?)";
		
		sql = String.format(sql, 
				TheaterDTO.ID, 
				TheaterDTO.ADDRESS, 
				TheaterDTO.TOTAL_SEATS, 
				TheaterDTO.VENUE_NAME);

		try {
	      pstmt = conn.prepareStatement(sql);
	      
	      System.out.println("[TheaterDAO.insertMap] : " + pstmt.toString());
	      
	      for(Map.Entry<String, TheaterDTO> entry : theaterMap.entrySet()) {
	    		TheaterDTO dto = entry.getValue();

	    		// FIXME:JHK - Duplicate entry 'FC000018' for key 'theater.PRIMARY'
//	    		TheaterDTO existing_dto = getTheater(dto.getId());
//	    		if(existing_dto == null) {
		    		pstmt.setString(1, dto.getId());
						pstmt.setString(2, dto.getAddress());
						pstmt.setInt(3, dto.getTotal_seats());
						pstmt.setString(4, dto.getVenue_name());

		    		// System.out.println("[TheaterDAO.insertMap] : " + pstmt.toString());

		    		pstmt.addBatch();
//	    		}else {
//	    			System.err.println("[TheaterDAO.insertMap] Duplicate entry : " + dto.getId());
//	    		}
	    	}
	 
	    	int[] results = pstmt.executeBatch();
	    	for(int result : results) {
	    		if(result == 0) {
	    			System.err.println("[TheaterDAO.insertMap] failed 1");
	    			return 0;
	    		}
	    	}

	        System.out.println("[TheaterDAO.insertMap] success");

	        return 1;
	        
		}catch(Exception e) {
			e.printStackTrace();
			System.err.println("[TheaterDAO.insertMap] failed 2");
		}
		
		return 0;
	}
	
	public int deleteAll() {
		String sql 	= "DELETE FROM theater";
		
		try {
			stmt = conn.createStatement();
			int result = stmt.executeUpdate(sql);
    		if(result == 0) {
    			System.out.println("[TheaterDAO.deleteAll] failed : " + result);
    			return 0;
    		}

	        System.out.println("[TheaterDAO.deleteAll] success");

	        return 1;
	        
		}catch(Exception e) {
			e.printStackTrace();
			System.err.println("[TheaterDAO.deleteAll] failed 2");
		}
		
		return 0;
	}
	
	public TheaterDTO getTheater(String theaterId) {

		TheaterDTO dto = null;
		
		String query = 
				   "SELECT * FROM theater " +
	               "WHERE %s = ?";

		query = String.format(query, 
				TheaterDTO.ID);
		
		try {
			
	    	pstmt = conn.prepareStatement(query);
	    	
	    	pstmt.setString(1, theaterId);
	    	
	    	System.out.println("[TheaterDAO.getTheater] pstmt : " + pstmt.toString());
	    	
	    	rs = pstmt.executeQuery();
	    	
	    	if(rs.next()) {
	    		dto = new TheaterDTO();
	    		
	    		dto.setId(rs.getString(TheaterDTO.ID));
	    		dto.setAddress(rs.getString(TheaterDTO.ADDRESS));
	    		dto.setTotal_seats(rs.getInt(TheaterDTO.TOTAL_SEATS));
	    		dto.setVenue_name(rs.getString(TheaterDTO.VENUE_NAME));
	    		
	    		System.out.println("[TheaterDAO.getTheater] success : " + dto.toString());
	    		
	    	}else {
	    		System.err.println("[TheaterDAO.getTheater] failed : ");
	    	}
	    	
		}catch(Exception e) {
			System.err.println("[TheaterDAO.getTheater] Exception : " + e.toString());
			e.printStackTrace();
		}
		
		return dto;	
	}	
	
}




















