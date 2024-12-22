package dao;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import common.JDBConnect;
import dto.BoardDTO;
import dto.CommentDTO;
import dto.ReportDTO;
import dto.ReportView;
import dto.ReportType;
import dto.ReviewDTO;

public class ReportDAO extends JDBConnect {

  public int addReport(ReportDTO report) throws SQLException {
    int result = 0;
    
    String query = "INSERT INTO report (%s, %s, %s, %s, %s) VALUES (?, ?, ?, ?, ?)";

    query = String.format(query
    		, ReportDTO.DATE
    		, ReportDTO.REASON
    		, ReportDTO.TYPE
    		, ReportDTO.REPORT_ID
    		, ReportDTO.USER_EMAIL
				);

    try {
      pstmt = conn.prepareStatement(query);
      
      pstmt.setTimestamp(1, Timestamp.valueOf(report.getDate()));
      pstmt.setString(2, report.getReason());
      pstmt.setString(3, report.getType().getValue());
      pstmt.setInt(4, report.getReportedId());
      pstmt.setString(5, report.getUserEmail());

      System.out.println("[ReportDAO.addReport] pstmt : " + pstmt.toString());

      result = pstmt.executeUpdate();

      System.out.println("[ReportDAO.addReport] result : " + result);

    } catch (SQLException e) {
      e.printStackTrace();
      System.err.println("[ReportDAO.addReport] SQLException : " + e.toString());
    }

    return result;
  }

  public ReportDTO getReport(int id) throws SQLException {
    ReportDTO report = null;
    String query = "SELECT * FROM report WHERE %s = ?";
    
    query = String.format(query
    		, ReportDTO.ID
				);
    
    try {

    	pstmt = conn.prepareStatement(query);
      
    	pstmt.setInt(1, id);
      
      System.out.println("[ReportDAO.getReport] pstmt : " + pstmt.toString());

      rs = pstmt.executeQuery();

      if (rs.next()) {
        report = new ReportDTO();
        
        report.setId(rs.getInt(ReportDTO.ID));
        report.setDate(rs.getTimestamp(ReportDTO.DATE).toLocalDateTime());
        report.setReason(rs.getString(ReportDTO.REASON));
        report.setType(ReportType.fromValue(rs.getString(ReportDTO.TYPE)));
        report.setReportedId(rs.getInt(ReportDTO.REPORT_ID));
        report.setUserEmail(rs.getString(ReportDTO.USER_EMAIL));
        
        System.out.println("[ReportDAO.getReport] report : " + report.toString());

      }

    } catch (SQLException e) {
      e.printStackTrace();
      System.err.println("[ReportDAO.getReport] SQLException : " + e.toString());
    }

    return report;
  }
  
  // TODO:JHK - 쿼리 조인으로 변경 필요
  public List<ReportView> getAllReportViwes() throws SQLException {
  	
  	List<ReportDTO> reports = getAllReportsWithoutAction();
  	List<ReportView> reportViews = new ArrayList<ReportView>();
  	
		UserDAO userDAO = new UserDAO();
		BoardDAO boardDAO = new BoardDAO();
		CommentDAO commentDAO = new CommentDAO();
		ReviewDAO reviewDAO = new ReviewDAO();

  	for(ReportDTO report : reports) {
  		
  		String writerEmail = "";
  		String linkId = "";
  		
  		switch(report.getType()) {
  		case BOARD:{
  			BoardDTO dto = boardDAO.getBoardById(report.getReportedId());
  			if(null != dto) {
  				writerEmail = dto.getUser_email();
  			// 신고된 곳이 board 인경우에도 일관된 사용을 위해서 소속된 boardId를 넣어준다.
  				linkId = String.valueOf(dto.getId());
  			}
  		}
  		break;
  		case COMMENT:
  		case REPLY:{
  			CommentDTO dto = commentDAO.getCommentById(report.getReportedId());
  			if(null != dto) {
  				writerEmail = dto.getUserEmail();
  				
  			  // 신고된 곳이 comment, reply 인경우 소속된 boardId를 넣어준다.
  				linkId = String.valueOf(dto.getBoardId());
  			}
  		}
  		break;
  		case REVIEW:{
  			ReviewDTO dto = reviewDAO.getReviewById(report.getReportedId());
  			if(null != dto) {
  				writerEmail = dto.getEmail();
  			  // 신고된 곳이 comment, reply 인경우 소속된 boardId를 넣어준다.
  				linkId = dto.getPerform_detail_id();
  			}
  		}
  		break;
			default:
				System.out.println("[ReportDAO.getAllReportViwes] type error : " + report.getType());
				continue;
  		}
  		
  		
  		if(writerEmail.isEmpty()) {
  			System.out.println("[ReportDAO.getAllReportViwes] writerEmail is null : ");
				continue;
  		}
  		
  		// 닉테임 얻어오기
   		String writerNickname = userDAO.findNicknameByEmail(writerEmail);
  		String reporterNickname = userDAO.findNicknameByEmail(report.getUserEmail());
  		
  		if(writerNickname == null) {
  			System.out.println("[ReportDAO.getAllReportViwes] writerNickname is null : ");
				continue;
  		}
  		if(reporterNickname == null) {
  			System.out.println("[ReportDAO.getAllReportViwes] reporterNickname is null : ");
				continue;
  		}
  		
  		ReportView dto = new ReportView();
  		
  		dto.setReport(report);
  		dto.setWriterName(writerNickname);
  		dto.setReporterName(reporterNickname);
  		dto.setLinkId(linkId);
  		
  		reportViews.add(dto);
  	}
  	
		userDAO.close();
		boardDAO.close();
		commentDAO.close();
		reviewDAO.close();
		
		return reportViews;
  }
  
  public List<ReportDTO> getAllReportsWithoutAction() throws SQLException {
    List<ReportDTO> reports = new ArrayList<>();

    String query = "SELECT * FROM report WHERE id NOT IN (SELECT Report_id FROM report_action)";
    
    try {
    	
      pstmt = conn.prepareStatement(query);
      
      System.out.println("[ReportDAO.getAllReportsWithoutAction] pstmt : " + pstmt.toString());

      rs = pstmt.executeQuery();


      while (rs.next()) {
        ReportDTO report = new ReportDTO();
        
        report.setId(rs.getInt(ReportDTO.ID));
        report.setDate(rs.getTimestamp(ReportDTO.DATE).toLocalDateTime());
        report.setReason(rs.getString(ReportDTO.REASON));
        report.setType(ReportType.fromValue(rs.getString(ReportDTO.TYPE)));
        report.setReportedId(rs.getInt(ReportDTO.REPORT_ID));
        report.setUserEmail(rs.getString(ReportDTO.USER_EMAIL));
        
        reports.add(report);

        System.out.println("[ReportDAO.getAllReportsWithoutAction] report : " + report.toString());
      }

    } catch (SQLException e) {
      e.printStackTrace();
      System.err.println("[ReportDAO.getAllReportsWithoutAction] SQLException : " + e.toString());
    }

    return reports;
  }

  public int updateReport(ReportDTO report) throws SQLException {
    
  	int result = 0;
    
  	String query = "UPDATE report SET %s = ?, %s = ?, %s = ?, %s = ?, %s = ? WHERE %s = ?";

    query = String.format(query
    		, ReportDTO.DATE
    		, ReportDTO.REASON
    		, ReportDTO.TYPE
    		, ReportDTO.REPORT_ID
    		, ReportDTO.USER_EMAIL
    		, ReportDTO.ID
				);
    
    try {
      
    	pstmt = conn.prepareStatement(query);
      
      pstmt.setTimestamp(1, Timestamp.valueOf(report.getDate()));
      pstmt.setString(2, report.getReason());
      pstmt.setString(3, report.getType().getValue());
      pstmt.setInt(4, report.getReportedId());
      pstmt.setString(5, report.getUserEmail());
      pstmt.setInt(6, report.getId());

      System.out.println("[ReportDAO.updateReport] pstmt : " + pstmt.toString());

      result = pstmt.executeUpdate();
      
      System.out.println("[ReportDAO.updateReport] result : " + result);

    } catch (SQLException e) {
      e.printStackTrace();
      System.err.println("[ReportDAO.updateReport] SQLException : " + e.toString());
    }

    return result;
  }

  public int deleteReport(int id) throws SQLException {
    int result = 0;
    String query = "DELETE FROM report WHERE %s = ?";

    query = String.format(query
    		, ReportDTO.ID
				);
    
    try {
      pstmt = conn.prepareStatement(query);
      
      pstmt.setInt(1, id);

      System.out.println("[ReportDAO.deleteReport] pstmt : " + pstmt);
      
      result = pstmt.executeUpdate();
      
      System.out.println("[ReportDAO.deleteReport] result : " + result);

    } catch (SQLException e) {
      e.printStackTrace();
      System.err.println("[ReportDAO.deleteReport] SQLException : " + e.toString());
    }

    return result;
  }
}

