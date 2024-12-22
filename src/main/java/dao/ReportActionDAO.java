package dao;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import common.JDBConnect;
import dto.BoardDTO;
import dto.CommentDTO;
import dto.ReportActionDTO;
import dto.ReportActionView;
import dto.ReportDTO;
import dto.ReportView;
import dto.ReportStates;
import dto.ReportType;
import dto.ReviewDTO;

public class ReportActionDAO extends JDBConnect {

	public int addReportAction(ReportActionDTO reportAction) {
		int result = 0;

		String query = "INSERT INTO report_action (%s, %s, %s, %s) VALUES (?, ?, ?, ?)";

		query = String.format(query, ReportActionDTO.DATE, ReportActionDTO.STATES, ReportActionDTO.REASON,
				ReportActionDTO.REPORT_ID);

		try {
			pstmt = conn.prepareStatement(query);

			pstmt.setTimestamp(1, Timestamp.valueOf(reportAction.getDate()));
			pstmt.setString(2, reportAction.getStates().getValue());
			pstmt.setString(3, reportAction.getReason());
			pstmt.setInt(4, reportAction.getReport_id());

			System.out.println("[ReportActionDTO.addReportAction] pstmt : " + pstmt.toString());

			result = pstmt.executeUpdate();

			System.out.println("[ReportActionDTO.addReportAction] result : " + result);

		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println("[ReportActionDTO.addReportAction] SQLException : " + e.toString());
		}

		return result;
	}

	public List<ReportActionDTO> getAllReportActions() throws SQLException {
		List<ReportActionDTO> actions = new ArrayList<>();
		String query = "SELECT * FROM report_action";

		try {

			pstmt = conn.prepareStatement(query);

			System.out.println("[ReportActionDAO.getAllReportActions] pstmt : " + pstmt.toString());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReportActionDTO action = new ReportActionDTO();

				action.setId(rs.getInt(ReportActionDTO.ID));
				action.setDate(rs.getTimestamp(ReportActionDTO.DATE).toLocalDateTime());
				action.setReason(rs.getString(ReportActionDTO.REASON));
				action.setStates(ReportStates.fromValue(rs.getString(ReportActionDTO.STATES)));
				action.setReport_id(rs.getInt(ReportActionDTO.REPORT_ID));

				actions.add(action);

				System.out.println("[ReportActionDAO.getAllReportActions] report : " + action.toString());
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println("[ReportActionDAO.getAllReportActions] SQLException : " + e.toString());
		}

		return actions;
	}

	// TODO:JHK - 쿼리 조인으로 변경 필요
	public List<ReportActionView> getAllReportActionInfos() throws SQLException {
		List<ReportActionDTO> actions = getAllReportActions();
		List<ReportActionView> reportInfos = new ArrayList<>();

		UserDAO userDAO = new UserDAO();
		ReportDAO reportDAO = new ReportDAO();
		BoardDAO boardDAO = new BoardDAO();
		CommentDAO commentDAO = new CommentDAO();
		ReviewDAO reviewDAO = new ReviewDAO();

		for (ReportActionDTO action : actions) {

			int reportId = action.getReport_id();

			ReportDTO reportDTO = reportDAO.getReport(reportId);
			if (reportDTO == null)
				continue;

			int reported_id = reportDTO.getReportedId();

			String writerEmail = "";

			switch (reportDTO.getType()) {
			case BOARD: {
				BoardDTO dto = boardDAO.getBoardById(reported_id);
				if (null != dto) {
					writerEmail = dto.getUser_email();
				}
			}
				break;
			case COMMENT:
			case REPLY:{
				CommentDTO dto = commentDAO.getCommentById(reported_id);
				if (null != dto) {
					writerEmail = dto.getUserEmail();
				}
			}
				break;
			case REVIEW: {
				ReviewDTO dto = reviewDAO.getReviewById(reported_id);
				if (null != dto) {
					writerEmail = dto.getEmail();
				}
			}
				break;
			default:
				System.out.println("[ReportActionDAO.getAllReportActionInfos] type error : " + reportDTO.getType());
				continue;
			}

			if (writerEmail.isEmpty()) {
				System.out.println("[ReportActionDAO.getAllReportActionInfos] writerEmail is null : ");
				continue;
			}

			String writerNickname = userDAO.findNicknameByEmail(writerEmail);
			String reporterNickname = userDAO.findNicknameByEmail(reportDTO.getUserEmail());

			if (writerNickname == null) {
				System.out.println("[ReportActionDAO.getAllReportActionInfos] writerNickname is null : ");
				continue;
			}
			if (reporterNickname == null) {
				System.out.println("[ReportActionDAO.getAllReportActionInfos] reporterNickname is null : ");
				continue;
			}

			// add to
			ReportActionView dto = new ReportActionView();
			
			dto.setReport(reportDTO);
			dto.setReportDate(reportDTO.getDate()); // 신고일
			dto.setReportType(reportDTO.getType()); // 신고타입
			dto.setReporterName(reporterNickname); // 신고자 닉네임

			dto.setWriterName(writerNickname); // 신고당한 닉네임
			
			dto.setReportAction(action);
			dto.setReportActionId(action.getId());
			dto.setActionDate(action.getDate()); // 처리일
			dto.setReason(action.getReason());		// 처리내용
			
			reportInfos.add(dto);
		}

		return reportInfos;
	}

}
