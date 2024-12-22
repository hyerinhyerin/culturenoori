package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import common.JDBConnect;
import dto.BoardDTO;

public class BoardDAO extends JDBConnect {
	
	//글 삽입
	public int insertBoard(BoardDTO board) {
        String insert_sql = "INSERT INTO board (title, date, type, contents, user_email, img_path) VALUES (?, ?, ?, ?, ?, ?)";
        int generatedId=0;
        try {
        	
        	pstmt = conn.prepareStatement(insert_sql, Statement.RETURN_GENERATED_KEYS);
	    	
             
        	pstmt.setString(1, board.getTitle());
        	pstmt.setTimestamp(2, new java.sql.Timestamp(board.getDate().getTime()));
        	pstmt.setString(3, board.getType());
        	pstmt.setString(4, board.getContents());
        	pstmt.setString(5, board.getUser_email());
        	pstmt.setString(6, board.getImg_path());
        	
            int result = pstmt.executeUpdate();
            if(result > 0) {
            	rs = pstmt.getGeneratedKeys();
            	if(rs.next()) {
            		generatedId = rs.getInt(1);
            	}
            }
        } catch (SQLException e) {
        	System.out.println("BoardDAO insertBoard Exception : " + e.toString());
            e.printStackTrace();
        }
        return generatedId;
    }
	
	//검색 시 결과 개수 반환
//	public int selectCount(Map<String, Object> map) {
//		int totalCount = 0;
//		
//		String query = "select count(*) from board";
//		
//		if(map.get("searchWord") != null) {
//			query 	+= " where " + map.get("searchField") + " "
//					+ " like '%" + map.get("searchWord") + "%'";
//		}
//		
//		try {
//			stmt = conn.createStatement();
//			rs = stmt.executeQuery(query);
//			rs.next();
//			totalCount = rs.getInt(1);
//		}catch(Exception e) {
//			System.out.println("게시물 수를 구하는 중 예외 발생");
//			e.printStackTrace();
//		}
//		
//		return totalCount;
//	}
	
	//검색 결과
//	public List<BoardDTO> selectList(Map<String, Object> map){
//		List<BoardDTO> boardList = new ArrayList<BoardDTO>();
//		
//		String query = "select * from board";
//		
//		if(map.get("searchWord") != null) {
//			query 	+= " where " + map.get("searchField") + " "
//					+ " like '%" + map.get("searchWord") + "%'";
//		}
//		
//		query += " order by id desc";
//		
//		try {
//			stmt = conn.createStatement();
//			rs = stmt.executeQuery(query);
//			
//			while(rs.next()) {
//				BoardDTO board = new BoardDTO();
//
//				board.setId(rs.getInt("id"));
//                board.setTitle(rs.getString("title"));
//                board.setDate(new Date(rs.getTimestamp("date").getTime()));
//                board.setViews(rs.getInt("views"));
//                board.setType(rs.getString("type"));
//                board.setContents(rs.getString("contents"));
//                board.setLike_count(rs.getInt("like_count"));
//                board.setUser_email(rs.getString("user_email"));
//                board.setImg_path(rs.getString("img_path"));
//                board.setReport_state(rs.getInt("report_state"));
//                boardList.add(board);
//			}
//			
//		}catch(Exception e) {
//			System.out.println("게시물 조회 중 예외 발생");
//			e.printStackTrace();
//		}
//		
//		return boardList;
//	}
	
	//모든 게시글 가져오기
	public List<BoardDTO> getAllBoards() {
        List<BoardDTO> boardList = new ArrayList<>();
        String query = "SELECT * FROM board order by id desc";

        try {

        	pstmt = conn.prepareStatement(query);
        	rs=pstmt.executeQuery();
        	
            while (rs.next()) {
                BoardDTO board = new BoardDTO();
                board.setId(rs.getInt("id"));
                board.setTitle(rs.getString("title"));
                board.setDate(new Date(rs.getTimestamp("date").getTime()));
                board.setViews(rs.getInt("views"));
                board.setType(rs.getString("type"));
                board.setContents(rs.getString("contents"));
                board.setLike_count(rs.getInt("like_count"));
                board.setUser_email(rs.getString("user_email"));
                board.setImg_path(rs.getString("img_path"));
                board.setReport_state(rs.getInt("report_state"));
                boardList.add(board);
            }
            System.out.println("BoardDAO getAllBoards success");
        } catch (SQLException e) {
            System.out.println("BoardDAO getAllBoards Exception: " + e.getMessage());
            e.printStackTrace();
        }

        return boardList;
    }
	
	//id로 게시글 찾기
	public BoardDTO getBoardById(int boardId) {
	    BoardDTO board = null;
	    try {
	        String sql = "SELECT * FROM board WHERE id = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, boardId);
	        
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	            board = new BoardDTO();
	            board.setId(rs.getInt("id"));
                board.setTitle(rs.getString("title"));
                board.setDate(new Date(rs.getTimestamp("date").getTime()));
                board.setViews(rs.getInt("views"));
                board.setType(rs.getString("type"));
                board.setContents(rs.getString("contents"));
                board.setLike_count(rs.getInt("like_count"));
                board.setUser_email(rs.getString("user_email"));
                board.setImg_path(rs.getString("img_path"));
                board.setReport_state(rs.getInt("report_state"));
	        }
	        System.out.println("BoardDAO getBoardById success");
	    } catch (Exception e) {
	    	System.out.println("BoardDAO getBoardById Exception: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return board;
	}
	
	
	//글 수정 
	public boolean updateBoard(BoardDTO board) {
	    String sql = "UPDATE board SET title = ?, date = ? ,type = ?, contents = ?, img_path = ? WHERE id = ?";
	    try{
	    	pstmt = conn.prepareStatement(sql);
	    	
	        pstmt.setString(1, board.getTitle());
	        pstmt.setTimestamp(2, new java.sql.Timestamp(board.getDate().getTime()));
	        pstmt.setString(3, board.getType());
	        pstmt.setString(4, board.getContents());
	        pstmt.setString(5, board.getImg_path());
	        pstmt.setInt(6, board.getId());
	
	        int result = pstmt.executeUpdate();
	        System.out.println("BoardDAO updateBoard success");
	        
	        return result > 0; // 성공적으로 업데이트되면 true 반환
	    } catch (SQLException e) {
	        System.out.println("BoardDAO updateBoard Exception: " + e.toString());
	        e.printStackTrace();
	        return false; // 예외 발생 시 false 반환
	    }
	}
	
		
	//게시글 삭제
	public boolean deleteBoard(int boardId) {
		String sql = "DELETE FROM board WHERE id = ?";
	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, boardId);
	        int result = pstmt.executeUpdate();
	        
	        System.out.println("BoardDAO deleteBoard success");
	        return result > 0; // 삭제가 성공했으면 true 반환
	    } catch (SQLException e) {
	    	System.out.println("BoardDAO deleteBoard Exception: " + e.getMessage());
	        e.printStackTrace();
	        return false; // 오류 발생 시 false 반환
	    }
	}
	
	
	//조회수 필드 하나씩 증가
	public int incrementView(int boardId) {
		int result=0;
		String sql = "UPDATE board SET views = views + 1 WHERE id = ?";
		
	    try{
	    	pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, boardId);
	        result = pstmt.executeUpdate();
	        
	        System.out.println("BoardDAO incrementView success: ");
	    } catch (SQLException e) {
	        System.out.println("BoardDAO incrementView Exception: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return result;
	}
	
	
	public int getTotalBoardCount(String sort, String category,Map<String, Object> map) {
	    int count = 0;
	    String sql ="SELECT COUNT(*) FROM board";
	    
	 // 카테고리 필터링
	    if (!category.equals("all")) {
	        sql += " WHERE type = ?";
	    }
	    
	 // 검색어 필터링
	    if (map.get("searchWord") != null && !map.get("searchWord").equals("")) {
	        if (!category.equals("all")) {
	            sql += " AND " + map.get("searchField") + " LIKE ?";
	        } else {
	            sql += " WHERE " + map.get("searchField") + " LIKE ?";
	        }
	    }
	    
	 // 정렬 조건 추가
	    switch (sort) {
		    case "latestOrder":
		        sql += " ORDER BY date DESC";
		        break;
		    case "oldOrder":
		        sql += " ORDER BY date ASC";
		        break;
		    case "visitOrder":
		        sql += " ORDER BY views DESC, date DESC"; // 조회수 기준 정렬 후, 동일한 경우 최신순으로
		        break;
		    case "likeOrder":
		        sql += " ORDER BY like_count DESC, date DESC"; // 추천수 기준 정렬 후, 동일한 경우 최신순으로
		        break;
	    }
	    
	    
	    try {
	    	pstmt = conn.prepareStatement(sql);
	    	
	    	int paramIndex = 1;
	    	
	    	if (!category.equals("all")) {
	            pstmt.setString(paramIndex++, category);
	        }
	    	
	    	if(map.get("searchWord") != null && !map.get("searchWord").equals("")) {
	    		pstmt.setString(paramIndex++, "%"+map.get("searchWord")+"%" );
	    	}
	    	
	    	rs= pstmt.executeQuery();
	    	
	    	if(rs.next()) {
	    		count = rs.getInt(1);
	    	}
			System.out.println("BoardDAO getTotalBoardCount sql: " + sql);

	    	System.out.println("BoardDAO getTotalBoardCount success: " + count);
	    	
	    }catch(SQLException e) {
	    	System.out.println("BoardDAO getTotalBoardCount Exception: " + e.getMessage());
	        e.printStackTrace();
	    }
	    
	    return count;
	}

	//boardList.jsp에서 목록 한 페이지에 5개씩 뽑아냄
	public List<BoardDTO> getBoardList(String sort, String category, Map<String, Object> map, int currentPage, int itemsPerPage){
		List<BoardDTO> boardList = new ArrayList<>();
		String sql = "SELECT * FROM board";

	    // 카테고리 필터링
	    if (!category.equals("all")) {
	        sql += " WHERE type = ?";
	    }
	    
	    //검색어 필터링
	    if (map.get("searchWord") != null && !map.get("searchWord").equals("")) {
	        if (!category.equals("all")) {
	            sql += " AND " + map.get("searchField") + " LIKE ?";
	        } else {
	            sql += " WHERE " + map.get("searchField") + " LIKE ?";
	        }
	    }
	    
	    // 정렬 조건 추가
	    switch (sort) {
	        case "latestOrder":
	            sql += " ORDER BY date DESC";
	            break;
	        case "oldOrder":
	            sql += " ORDER BY date ASC";
	            break;
	        case "visitOrder":
	            sql += " ORDER BY views DESC, date DESC"; // 조회수 기준 정렬 후, 동일한 경우 최신순으로
	            break;
	        case "likeOrder":
	            sql += " ORDER BY like_count DESC, date DESC"; // 추천수 기준 정렬 후, 동일한 경우 최신순으로
	            break;
	    }
	    
	    // 페이지네이션 로직
	    int start;
	    boolean hasSearchWord = map.get("searchWord") != null && !map.get("searchWord").equals("");
	    if (currentPage == 1) {
	        sql += " LIMIT 0, " + (hasSearchWord ? "8" : "5"); // 공지사항 3개는 별도로 가져옴
	    } else {
	        // 두 번째 페이지부터는 공지사항 3개를 제외한 일반 게시글을 가져옴
	    	int itPP = hasSearchWord ? 8 : 5;
	    	start = (currentPage - 1) * itPP; // 첫 페이지의 게시글을 제외하고 시작 인덱스 계산
	        if (hasSearchWord) {
	            sql += " LIMIT " + start + ", 8"; // 검색어가 있는 경우 8개
	        } else {
	            sql += " LIMIT " + start + ", 5"; // 검색어가 없는 경우 5개
	        }
	    }
	    
		try {
			pstmt = conn.prepareStatement(sql);
			
			int paramIndex = 1;
			
			if (!category.equals("all")) {
	            pstmt.setString(paramIndex++, category);
	        }
			
			if(map.get("searchWord") != null && !map.get("searchWord").equals("")) {
				pstmt.setString(paramIndex++, "%"+map.get("searchWord")+"%");
			}
			
			
			if(currentPage > 1) {
				start = (currentPage -2)*itemsPerPage+2;
//				pstmt.setInt(paramIndex++, start);
//	            pstmt.setInt(paramIndex++, itemsPerPage);
			}
			
            
			System.out.println("BoardDAO getBoardList sql: " + sql);

	        rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardDTO board = new BoardDTO();
				
                board.setId(rs.getInt("id"));
                board.setTitle(rs.getString("title"));
                board.setDate(new Date(rs.getTimestamp("date").getTime()));
                board.setViews(rs.getInt("views"));
                board.setType(rs.getString("type"));
                board.setContents(rs.getString("contents"));
                board.setLike_count(rs.getInt("like_count"));
                board.setUser_email(rs.getString("user_email"));
                board.setImg_path(rs.getString("img_path"));
                board.setReport_state(rs.getInt("report_state"));
                
                boardList.add(board);
			}
			System.out.println("BoardDAO getBoardList success: " + boardList.size());
		}catch(SQLException e) {
	    	System.out.println("BoardDAO getBoardList Exception: " + e.getMessage());
	        e.printStackTrace();
	    }
		return boardList;
	}

	
	//board_detail 현 게시글 전 2개
	public List<BoardDTO> getAdjacentBoards(int currentBoardId, String sort, String category, Map<String, Object> searchMap, int offset) {
	    List<BoardDTO> boardList = new ArrayList<>();
	    String sql = "SELECT * FROM board WHERE id != ?"; // 현 게시글 제외

	    // 카테고리 필터링
	    if (!category.equals("all")) {
	        sql += " AND type = ?";
	    }

	    // 검색어 필터링
	    if (searchMap.get("searchWord") != null && !searchMap.get("searchWord").equals("") && !searchMap.get("searchWord").equals("null")) {
            sql += " AND " + searchMap.get("searchField") + " LIKE ?";
	    }


	    // 정렬 조건 추가
	    switch (sort) {
	        case "latestOrder":
	            sql += " AND date < (SELECT date FROM board WHERE id = ?) ORDER BY date DESC";
	            break;
	        case "oldOrder":
	            sql += " AND date > (SELECT date FROM board WHERE id = ?) ORDER BY date ASC";
	            break;
	        case "visitOrder":
	            sql += " AND views < (SELECT views FROM board WHERE id = ?) ORDER BY views DESC, date DESC";
	            break;
	        case "likeOrder":
	        	sql += " AND (like_count < (SELECT like_count FROM board WHERE id = ?) "
	                    + "OR (like_count = (SELECT like_count FROM board WHERE id = ?) AND date < (SELECT date FROM board WHERE id = ?))) "
	                    + "ORDER BY like_count DESC, date DESC";
	            break;
	    }

	    // LIMIT 추가 (가져올 게시글 수 설정)
	    sql += " LIMIT ?";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, currentBoardId); // 현재 게시글 ID
	        int paramIndex = 2; // 매개변수 인덱스 시작
	        
	        if (!category.equals("all")) {
	            pstmt.setString(paramIndex++, category);
	        }

	        if (searchMap.get("searchWord") != null && !searchMap.get("searchWord").equals("") && !searchMap.get("searchWord").equals("null")) {
	            pstmt.setString(paramIndex++, "%" + searchMap.get("searchWord") + "%");
	        }

	        switch (sort) {
	            case "latestOrder":
	            case "oldOrder":
	            case "visitOrder":
	                pstmt.setInt(paramIndex++, currentBoardId);
	                break;
	            case "likeOrder":
	                pstmt.setInt(paramIndex++, currentBoardId); // like_count 조건
	                pstmt.setInt(paramIndex++, currentBoardId); // like_count가 같을 경우
	                pstmt.setInt(paramIndex++, currentBoardId); // date 조건
	                break;
	        }
	        pstmt.setInt(paramIndex++, offset);  // 가져올 게시글 수

	    	System.out.println("BoardDAO getAdjacentBoards sql: " + sql);


	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            BoardDTO board = new BoardDTO();
	            board.setId(rs.getInt("id"));
	            board.setTitle(rs.getString("title"));
	            board.setDate(new Date(rs.getTimestamp("date").getTime()));
	            board.setViews(rs.getInt("views"));
	            board.setType(rs.getString("type"));
	            board.setContents(rs.getString("contents"));
	            board.setLike_count(rs.getInt("like_count"));
	            board.setUser_email(rs.getString("user_email"));
	            board.setImg_path(rs.getString("img_path"));
	            board.setReport_state(rs.getInt("report_state"));

	            boardList.add(board);
	        }
	        System.out.println("BoardDAO getAdjacentBoards success: " + boardList.size());
	    } catch (SQLException e) {
	        System.out.println("BoardDAO getAdjacentBoards Exception: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return boardList;
	}

	//board_detail 기준 후 게시글
	public List<BoardDTO> getAdjacentBoardsAfter(int currentBoardId, String sort, String category, Map<String, Object> searchMap, int offset) {
		System.out.println("BoardDAO getAdjacentBoardsAfter id-"+currentBoardId+" sort-"+sort+" category-"+category+" searchfield-"+searchMap.get("searchField")+" searchword-"+searchMap.get("searchWord")+" offset-"+offset );
		
		List<BoardDTO> boardList = new ArrayList<>();
	    String sql = "SELECT * FROM board WHERE id != ?"; // 현 게시글 제외

	    // 카테고리 필터링
	    if (!category.equals("all")) {
	        sql += " AND type = ?";
	    }

	    // 검색어 필터링
	    if (searchMap.get("searchWord") != null && !searchMap.get("searchWord").equals("") && !searchMap.get("searchWord").equals("null")) {
            sql += " AND " + searchMap.get("searchField") + " LIKE ?";
	    }

	    // 정렬 조건 추가
	    switch (sort) {
	        case "latestOrder":
	            sql += " AND date > (SELECT date FROM board WHERE id = ?) ORDER BY date ASC";
	            break;
	        case "oldOrder":
	            sql += " AND date < (SELECT date FROM board WHERE id = ?) ORDER BY date DESC";
	            break;
	        case "visitOrder":
	            sql += " AND views > (SELECT views FROM board WHERE id = ?) ORDER BY views ASC, date ASC";
	            break;
	        case "likeOrder":
	        	sql += " AND (like_count > (SELECT like_count FROM board WHERE id = ?) "
	                    + "OR (like_count = (SELECT like_count FROM board WHERE id = ?) AND date > (SELECT date FROM board WHERE id = ?))) "
	                    + "ORDER BY like_count ASC, date ASC";
	            break;
	    }

	    // LIMIT 추가 (가져올 게시글 수 설정)
	    sql += " LIMIT ?";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, currentBoardId); // 현재 게시글 ID
	        int paramIndex = 2; // 매개변수 인덱스 시작
	        
	        if (!category.equals("all")) {
	            pstmt.setString(paramIndex++, category);
	        }

	        if (searchMap.get("searchWord") != null && !searchMap.get("searchWord").equals("") && !searchMap.get("searchWord").equals("null")) {
	            pstmt.setString(paramIndex++, "%" + searchMap.get("searchWord") + "%");
	        }

	        switch (sort) {
	            case "latestOrder":
	            case "oldOrder":
	            case "visitOrder":
	                pstmt.setInt(paramIndex++, currentBoardId);
	                break;
	            case "likeOrder":
	                pstmt.setInt(paramIndex++, currentBoardId); // like_count 조건
	                pstmt.setInt(paramIndex++, currentBoardId); // like_count가 같을 경우
	                pstmt.setInt(paramIndex++, currentBoardId); // date 조건
	                break;
	        }
	        pstmt.setInt(paramIndex++, offset);  // 가져올 게시글 수
	        

	    	System.out.println("BoardDAO getAdjacentBoards sql: " + sql);

	        
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            BoardDTO board = new BoardDTO();
	            board.setId(rs.getInt("id"));
	            board.setTitle(rs.getString("title"));
	            board.setDate(new Date(rs.getTimestamp("date").getTime()));
	            board.setViews(rs.getInt("views"));
	            board.setType(rs.getString("type"));
	            board.setContents(rs.getString("contents"));
	            board.setLike_count(rs.getInt("like_count"));
	            board.setUser_email(rs.getString("user_email"));
	            board.setImg_path(rs.getString("img_path"));
	            board.setReport_state(rs.getInt("report_state"));

	            boardList.add(board);
	        }
	        System.out.println("BoardDAO getAdjacentBoardsAfter success: " + boardList.size());
	    } catch (SQLException e) {
	        System.out.println("BoardDAO getAdjacentBoardsAfter Exception: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return boardList;
	}

	public List<BoardDTO> getTop5Boards(String sort, String category, Map<String, Object> searchMap){
		List<BoardDTO> boardList = new ArrayList<>();
	    String sql = "SELECT * FROM board"; // 현 게시글 제외

	 // 카테고리 필터링
	    if (!category.equals("all")) {
	        sql += " WHERE type = ?";
	    }
	    
	    //검색어 필터링
	    if (searchMap.get("searchWord") != null && !searchMap.get("searchWord").equals("")) {
	        if (!category.equals("all")) {
	            sql += " AND " + searchMap.get("searchField") + " LIKE ?";
	        } else {
	            sql += " WHERE " + searchMap.get("searchField") + " LIKE ?";
	        }
	    }
	    
	    switch (sort) {
	        case "latestOrder":
	            sql += " ORDER BY date DESC";
	            break;
	        case "oldOrder":
	            sql += " ORDER BY date ASC";
	            break;
	        case "visitOrder":
	            sql += " ORDER BY views DESC, date DESC"; // 조회수 기준 정렬 후, 동일한 경우 최신순으로
	            break;
	        case "likeOrder":
	            sql += " ORDER BY like_count DESC, date DESC"; // 추천수 기준 정렬 후, 동일한 경우 최신순으로
	            break;
	    }
	    
	    sql += " LIMIT 5";
	    
	    try {
	    	pstmt = conn.prepareStatement(sql);
	    	int paramIndex=1;
	    	
	    	if (!category.equals("all")) {
	            pstmt.setString(paramIndex++, category);
	        }
			
			if(searchMap.get("searchWord") != null && !searchMap.get("searchWord").equals("")) {
				pstmt.setString(paramIndex++, "%"+searchMap.get("searchWord")+"%");
			}
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setId(rs.getInt("id"));
	            board.setTitle(rs.getString("title"));
	            board.setDate(new Date(rs.getTimestamp("date").getTime()));
	            board.setViews(rs.getInt("views"));
	            board.setType(rs.getString("type"));
	            board.setContents(rs.getString("contents"));
	            board.setLike_count(rs.getInt("like_count"));
	            board.setUser_email(rs.getString("user_email"));
	            board.setImg_path(rs.getString("img_path"));
	            board.setReport_state(rs.getInt("report_state"));
				boardList.add(board);
			}
	        System.out.println("BoardDAO getTop5Boards success: " + boardList.size());
	    }catch (SQLException e) {
	        System.out.println("BoardDAO getTop5Boards Exception: " + e.getMessage());
	        e.printStackTrace();
	    }

	    return boardList;
	}
	

	public List<BoardDTO> getBoardListByUser(String email){
		List<BoardDTO> boards = new ArrayList<BoardDTO>();
		String sql = "SELECT * FROM board WHERE user_email = ? ORDER BY date desc";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setId(rs.getInt("id"));
				board.setTitle(rs.getString("title"));
				board.setDate(new Date(rs.getTimestamp("date").getTime()));
				board.setViews(rs.getInt("views"));
	            board.setType(rs.getString("type"));
	            board.setContents(rs.getString("contents"));
	            board.setLike_count(rs.getInt("like_count"));
	            board.setUser_email(rs.getString("user_email"));
	            board.setImg_path(rs.getString("img_path"));
	            board.setReport_state(rs.getInt("report_state"));
	            boards.add(board);
			}
	        System.out.println("BoardDAO getBoardListByUser success: " + boards.size());

		}catch (SQLException e) {
	        System.out.println("BoardDAO getBoardListByUser Exception: " + e.getMessage());
	        e.printStackTrace();
	    }

	    return boards;
		
	}
}
