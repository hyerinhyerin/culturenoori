package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.CNPath;
import common.JDBConnect;
import dto.PerformDetailDTO;
import utils.Downloader;

public class PerformDetailDAO extends JDBConnect {

	public int insertList(List<PerformDetailDTO> performDetailList) {

		String sql = "INSERT INTO perform_detail (%s, %s, %s, %s, %s, %s, %s, %s, %s) " 
						+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

		sql = String.format(sql, 
					PerformDetailDTO.ID, 
					PerformDetailDTO.AVG_RATE, 
					PerformDetailDTO.PRICE,
					PerformDetailDTO.CAST, 
					PerformDetailDTO.THEATER_ID, 
					PerformDetailDTO.IMG_PATH, 
					PerformDetailDTO.RUNTIME, 
					PerformDetailDTO.VENUE_NAME, 
					PerformDetailDTO.RESERV_LINK);

		try {
			pstmt = conn.prepareStatement(sql);

			System.out.println("[PerformDetailDAO.insertList] pstmt : " + pstmt.toString());

			for (PerformDetailDTO dto : performDetailList) {

				pstmt.setString(1, dto.getId());
				pstmt.setFloat(2, dto.getAverage_rate());
				pstmt.setString(3, dto.getPrice()); // 문자열로 변경 필요할 것 같음
				pstmt.setString(4, dto.getCast());
				pstmt.setString(5, dto.getTheater_id());
				pstmt.setString(6, dto.getImg_path());

				pstmt.setString(7, dto.getRuntime());
				pstmt.setString(8, dto.getVenue_name());
				pstmt.setString(9, dto.getReservation_link());

				// System.out.println("[PerformDetailDAO.insertList] pstmt : " + pstmt.toString());

				pstmt.addBatch();
			}

			int[] results = pstmt.executeBatch();
			for (int result : results) {
				if (result == 0) {
					System.err.println("[PerformDetailDAO.insertList] failed");
					return 0;
				}
			}

			System.out.println("[PerformDetailDAO.insertList] success");

			return 1;

		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("[PerformDetailDAO.insertList] Exception");
		}

		return 0;
	}

	public int deleteAll() {
		String sql = "DELETE FROM perform_detail";

		try {
			stmt = conn.createStatement();
			int result = stmt.executeUpdate(sql);
			if (result == 0) {
				System.err.println("[PerformDetailDAO.deleteAll] failed 1 : " + result);
				return 0;
			}

			System.out.println("[PerformDetailDAO.deleteAll] success");

			return 1;

		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("[PerformDetailDAO.deleteAll] failed 2");
		}

		return 0;
	}

	public PerformDetailDTO getDetail(String detailId, String rootPath, String realPath) {

		PerformDetailDTO dto = null;

		String query = "SELECT * FROM perform_detail " + "WHERE %s = ?";

		query = String.format(query, PerformDetailDTO.ID);

		try {

			pstmt = conn.prepareStatement(query);

			pstmt.setString(1, detailId);

			System.out.println("[PerformDetailDAO.getDetail] pstmt : " + pstmt.toString());

			rs = pstmt.executeQuery();
			
			Downloader downloader = new Downloader(realPath);

			if (rs.next()) {
				dto = new PerformDetailDTO();

				dto.setId(rs.getString(PerformDetailDTO.ID));
				dto.setAverage_rate(rs.getFloat(PerformDetailDTO.AVG_RATE));
				dto.setPrice(rs.getString(PerformDetailDTO.PRICE));
				dto.setCast(rs.getString(PerformDetailDTO.CAST));
				dto.setTheater_id(rs.getString(PerformDetailDTO.THEATER_ID));

				dto.setRuntime(rs.getString(PerformDetailDTO.RUNTIME));
				dto.setVenue_name(rs.getString(PerformDetailDTO.VENUE_NAME));
				dto.setReservation_link(rs.getString(PerformDetailDTO.RESERV_LINK));
			
				List<String> strPaths = new ArrayList<String>();
	    		
				String fileNameWithComma = rs.getString(PerformDetailDTO.IMG_PATH);
				System.err.println("[PerformDetailDAO.getDetail] fileName : " + fileNameWithComma);
				
	    		String[] fileNameSplit1 = fileNameWithComma.split(",");
	    		
	    		for(int i = 0; i < fileNameSplit1.length; i++) {
	    			
	    			String fileName = fileNameSplit1[i];
		    		String[] fileNameSplit2 = fileName.split("_");
		    		String imagepath = rootPath + "/" +  CNPath.IMG_ROOT + fileNameSplit2[1] + "/" + fileName;
		    	
		    		strPaths.add(imagepath);
			        
			        downloader.reloadStory(realPath, rootPath, fileName, detailId);
	    		}
	    		
	    		dto.setImg_path(String.join(",", strPaths));
	    		
	    		System.err.println("[PerformDetailDAO.getDetail] getImg_path : " + dto.getImg_path());
				System.out.println("[PerformDetailDAO.getDetail] success : " + dto.toString());
				
			} else {
				System.err.println("[PerformDetailDAO.getDetail] failed : ");
			}
		} catch (Exception e) {
			System.err.println("[PerformDetailDAO.getDetail] Exception : ");
			e.printStackTrace();
		}

		return dto;
	}
	public float getAverageRateById(String performDetailId) {
        String sql = "SELECT average_rate FROM perform_detail WHERE id = ?";
        float averageRate = 0.0f;

        try {
        	pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, performDetailId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
              averageRate = rs.getFloat("average_rate");
              // System.out.println("average_rate : "+ averageRate);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return averageRate;
    }

}
