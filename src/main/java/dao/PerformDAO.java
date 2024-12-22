package dao;

import java.io.IOException;
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
import utils.Downloader;
import dto.PerformCardDTO;

public class PerformDAO extends JDBConnect {

	// 한 페이지에 표시할 항목 수
	private final int ITEMS_PER_PAGE = 4 * 6;

	public int insertList(List<PerformDTO> performList) {

		String sql = "INSERT INTO perform (%s, %s, %s, %s, %s, %s) " + "VALUES (?, ?, ?, ?, ?, ?)";

		sql = String.format(sql, PerformDTO.NAME, PerformDTO.START, PerformDTO.END, PerformDTO.IMG, PerformDTO.STATE,
		    PerformDTO.DETAIL_ID);

		try {
			pstmt = conn.prepareStatement(sql);

			System.out.println("[PerformDAO.insertList] pstmt : " + pstmt.toString());

			for (PerformDTO dto : performList) {

				pstmt.setString(1, dto.getName());
				pstmt.setString(2, dto.getStart());
				pstmt.setString(3, dto.getEnd());
				pstmt.setString(4, dto.getImg_path());
				pstmt.setString(5, dto.getState());
				pstmt.setString(6, dto.getPerform_Detail_id());

				// System.out.println("[PerformDAO.insertList] pstmt : " + pstmt.toString());

				pstmt.addBatch();
			}

			int[] results = pstmt.executeBatch();
			for (int result : results) {
				if (result == 0) {
					System.err.println("[PerformDAO.insertList] failed ");
					return 0;
				}
			}

			System.out.println("[PerformDAO.insertList] success");

			return 1;

		} catch (Exception e) {
			System.out.println("[PerformDAO.insertList] Exception ");
			e.printStackTrace();
		}

		return 0;
	}

	public int deleteAll() {
		String sql = "DELETE FROM perform";

		try {
			stmt = conn.createStatement();
			int result = stmt.executeUpdate(sql);
			if (result == 0) {
				System.out.println("[PerformDAO.deleteAll] failed : " + result);
				return 0;
			}

			System.out.println("[PerformDAO.deleteAll] success");

			return 1;

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("[PerformDAO.deleteAll] Exception ");
		}

		return 0;
	}

	public Object[] getPerformList(String searchKeyword, String performState, int page, String rootPath, String realPath) throws IOException {

		// OFFSET 계산
		int offset = (page - 1) * ITEMS_PER_PAGE;

		JSONObject jsonResult = new JSONObject();
		JSONObject jsonData = new JSONObject();

		
		String joinQuery =" p "
				+ " JOIN( "
				+ "	SELECT id, average_rate, venue_name "
				+ "    FROM perform_detail "
				+ " ) As pd ON p.Perform_Detail_id = pd.id ";

		// 기본 쿼리 시작 부분 (WHERE 절은 이후에 동적으로 추가)
		// 1=1을 사용하는 이유는, 이후에 AND 또는 OR로 조건을 동적으로 추가할 때 쿼리의 구문 오류를 방지하기 위함
		String mainQuery = String.format("SELECT * FROM Perform %s WHERE 1=1 ", joinQuery);
		StringBuilder query = new StringBuilder(mainQuery);
		
		// searchKeyword가 비어있지 않은 경우 LIKE 조건 추가
		if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
			query.append("AND " + PerformDTO.NAME + " LIKE ? ");
		}

		// stateFilter가 비어있지 않은 경우 상태 필터 조건 추가
		if (performState != null && !performState.trim().isEmpty()) {
			query.append("AND " + PerformDTO.STATE + " = ? ");
		}

		if (0 < page) {
			// LIMIT와 OFFSET 조건 추가
			query.append("LIMIT ? OFFSET ?");
		}

		try {

			pstmt = conn.prepareStatement(query.toString());

			int paramIndex = 1;

			// searchKeyword가 비어있지 않으면 LIKE 조건에 바인딩
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				String keyword = "%" + searchKeyword.trim() + "%"; // 부분 검색을 위한 와일드카드 추가
				pstmt.setString(paramIndex, keyword);
				paramIndex++;
			}

			// stateFilter가 비어있지 않으면 상태 필터 조건에 바인딩
			if (performState != null && !performState.trim().isEmpty()) {
				String value = "공연중";
				switch (performState) {
				case "ing":
					value = "공연중";
					break;
				case "ends":
					value = "공연완료";
					break;
				case "soon":
					value = "공연예정";
					break;
				}
				pstmt.setString(paramIndex, value);
				paramIndex++;
			}

			if (0 < page) {
				// LIMIT와 OFFSET 바인딩
				pstmt.setInt(paramIndex, ITEMS_PER_PAGE); // LIMIT 바인딩
				pstmt.setInt(paramIndex + 1, offset); // OFFSET 바인딩
			}

			System.out.println("[PerformDAO.getList] pstmt : " + pstmt.toString());

			rs = pstmt.executeQuery();

			JSONArray jsonArray = new JSONArray();

			Downloader downloader = new Downloader(realPath);
			
			while (rs.next()) {

				PerformCardDTO card = new PerformCardDTO();
				PerformDTO perform = new PerformDTO();

				String fileName = rs.getString(PerformDTO.IMG);

				perform.setId(rs.getInt(PerformDTO.ID));
				perform.setName(rs.getString(PerformDTO.NAME));
				perform.setStart(rs.getString(PerformDTO.START));
				perform.setEnd(rs.getString(PerformDTO.END));
				perform.setState(rs.getString(PerformDTO.STATE));
				perform.setPerform_Detail_id(rs.getString(PerformDTO.DETAIL_ID));
				perform.setImg_path(PerformDTO.makeRelativeImagePath(fileName, rootPath));

				downloader.reloadPoster(realPath, rootPath, fileName, perform.getPerform_Detail_id());
				
				card.setPerform(perform);
				card.setAverage_rate(rs.getFloat("average_rate"));
				card.setVenue_name(rs.getString("venue_name"));
				
				jsonArray.put(card.toJson());

				// System.out.println("[PerformDAO.getList] card : " + card.toString());

			}

			System.out.println("[PerformDAO.getList] jsonArray.length() : " + jsonArray.length());

			if (0 < jsonArray.length()) {
				jsonResult.put("result", "success");
			} else {
				jsonResult.put("result", "failed");
			}

			jsonData.put("data", jsonArray);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return new Object[] { jsonResult, jsonData };
	}

	public PerformDTO getPerform(String detailId, String rootPath, String realPath) {

		PerformDTO dto = null;

		String query = "SELECT * FROM perform " + "WHERE %s = ?";

		query = String.format(query, PerformDTO.DETAIL_ID);

		try {

			pstmt = conn.prepareStatement(query);

			pstmt.setString(1, detailId);

			System.out.println("[PerformDAO.getPerform] pstmt : " + pstmt.toString());

			rs = pstmt.executeQuery();

			
			if (rs.next()) {
				dto = new PerformDTO();

				String fileName = rs.getString(PerformDTO.IMG);

				dto.setId(rs.getInt(PerformDTO.ID));
				dto.setName(rs.getString(PerformDTO.NAME));
				dto.setStart(rs.getString(PerformDTO.START));
				dto.setEnd(rs.getString(PerformDTO.END));
				dto.setState(rs.getString(PerformDTO.STATE));
				dto.setPerform_Detail_id(rs.getString(PerformDTO.DETAIL_ID));
				dto.setImg_path(PerformDTO.makeRelativeImagePath(fileName, rootPath));

				Downloader downloader = new Downloader(realPath);
				downloader.reloadPoster(realPath, rootPath, fileName, dto.getPerform_Detail_id());
				
				System.out.println("[PerformDAO.getPerform] success : " + dto.toString());
			}
		} catch (Exception e) {
			System.err.println("[PerformDAO.getPerform] Exception : ");
			e.printStackTrace();
		}

		return dto;
	}

	public Map<Integer, List<PerformDTO>> getListinMonth(int year, int month) {

		Map<Integer, List<PerformDTO>> map = new HashMap<Integer, List<PerformDTO>>();

		String query = "SELECT * FROM perform " + "WHERE (YEAR(start) = ? AND MONTH(start) = ?) " + // 시작일 입력값과 일치하는지
		    "   OR (YEAR(end) = ? AND MONTH(end) = ?) " + // 또는 종료일이 입력값과 일치하는지
		    "   OR (YEAR(start) <= ? AND MONTH(start) <= ? " + // 또는 입력값 안에 시작 또는 종료가 걸치는지
		    "       AND YEAR(end) >= ? AND MONTH(end) >= ?)";

		try {

			pstmt = conn.prepareStatement(query);

			pstmt.setInt(1, year);
			pstmt.setInt(2, month);

			pstmt.setInt(3, year);
			pstmt.setInt(4, month);

			pstmt.setInt(5, year);
			pstmt.setInt(6, month);

			pstmt.setInt(7, year);
			pstmt.setInt(8, month);

			System.out.println("[PerformDAO.getListinMonth] pstmt : " + pstmt.toString());

			rs = pstmt.executeQuery();

			while (rs.next()) {

				PerformDTO dto = new PerformDTO();

				dto.setId(rs.getInt(PerformDTO.ID));
				dto.setName(rs.getString(PerformDTO.NAME));
				dto.setStart(rs.getString(PerformDTO.START));
				dto.setEnd(rs.getString(PerformDTO.END));
				dto.setState(rs.getString(PerformDTO.STATE));
				dto.setPerform_Detail_id(rs.getString(PerformDTO.DETAIL_ID));

				List<Integer> dates = getDates(dto.getStart(), dto.getEnd(), month);

				dates.forEach(day -> {
					List<PerformDTO> list = null;
					if (!map.containsKey(day)) {
						list = new ArrayList<PerformDTO>();
					} else {
						list = (List<PerformDTO>) map.get(day);
					}
					list.add(dto);
					map.put(day, list);
				});

				// System.out.println("[PerformDAO.getListinMonth] dto : " + dto.toString());
			}

		} catch (Exception e) {
			System.err.println("[PerformDAO.getListinMonth] Exception : ");
			e.printStackTrace();
		}

		return map;
	}

	List<Integer> getDates(String start, String end, int targetMonth) {

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

		LocalDateTime startDateTime = LocalDateTime.parse(start, formatter);
		LocalDateTime endDateTime = LocalDateTime.parse(end, formatter);

		LocalDate startDate = startDateTime.toLocalDate();
		LocalDate endDate = endDateTime.toLocalDate();

		List<Integer> dates = new ArrayList<>();
		LocalDate current = startDate;

		while (!current.isAfter(endDate)) {
			if (current.getMonthValue() == targetMonth) {
				dates.add(current.getDayOfMonth());
			}
			current = current.plusDays(1);
		}

		return dates;
	}

	public List<PerformCardDTO> getWeeklyRankList(String rootPath, String realPath) {

		List<PerformCardDTO> list = new ArrayList<>();

		String query = "SELECT p.*, pd.average_rate, pd.venue_name " + 
        "FROM perform p " + 
        "JOIN ( " +
        "    SELECT id, average_rate, venue_name " +
        "    FROM perform_detail " +
        "    ORDER BY average_rate DESC " +
        "    LIMIT 10 " +
        ") AS pd ON p.Perform_Detail_id = pd.id";
		
		
		try {

			pstmt = conn.prepareStatement(query);

			System.out.println("[PerformDAO.getWeeklyRankList] pstmt : " + pstmt.toString());

			rs = pstmt.executeQuery();

			Downloader downloader = new Downloader(realPath);

			while (rs.next()) {

				PerformCardDTO weeklyRank = new PerformCardDTO();
				PerformDTO perform = new PerformDTO();

				String fileName = rs.getString(PerformDTO.IMG);
				
				perform.setId(rs.getInt(PerformDTO.ID));
				perform.setName(rs.getString(PerformDTO.NAME));
				perform.setStart(rs.getString(PerformDTO.START));
				perform.setEnd(rs.getString(PerformDTO.END));
				perform.setState(rs.getString(PerformDTO.STATE));
				perform.setPerform_Detail_id(rs.getString(PerformDTO.DETAIL_ID));
				perform.setImg_path(PerformDTO.makeRelativeImagePath(fileName, rootPath));

				downloader.reloadPoster(realPath, rootPath, fileName, perform.getPerform_Detail_id());
				
				weeklyRank.setPerform(perform);
				
				weeklyRank.setAverage_rate(rs.getFloat("average_rate"));
				weeklyRank.setVenue_name(rs.getString("venue_name"));
				
				list.add(weeklyRank);

				// System.out.println("[PerformDAO.getWeeklyRankList] dto : " + weeklyRank.toString());
			}
			
			System.out.println("[PerformDAO.getWeeklyRankList] list size : " + list.size());

		} catch (Exception e) {
			System.err.println("[PerformDAO.getListinMonth] Exception : ");
			e.printStackTrace();
		}

		return list;
	}

	public PerformDTO getPerformName(String performDetailId) {
		PerformDTO dto = new PerformDTO();
		String sql = "SELECT * FROM perform where perform_detail_id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, performDetailId);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setId(rs.getInt(PerformDTO.ID));
				dto.setName(rs.getString(PerformDTO.NAME));
				dto.setPerform_Detail_id(rs.getString(PerformDTO.DETAIL_ID));
			}
		} catch (Exception e) {
			System.err.println("[PerformDAO.getPerformName] Exception : " + e.getMessage());
			e.printStackTrace();
		}
		return dto;
	}

}
