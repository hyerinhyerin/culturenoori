<%@page import="dto.NoticeDTO"%>
<%@page import="dao.NoticeDAO"%>
<%@page import="java.util.*"%>
<%@page import="dao.UserDAO"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	String sort = request.getParameter("sort");
	String category = request.getParameter("category");
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	
	BoardDAO dao = new BoardDAO();
	UserDAO userdao = new UserDAO();
	NoticeDAO noticedao = new NoticeDAO();
	
	Map<String, Object> searchMap = new HashMap<>();
  if(searchField.equals("nickname")){
   	String email = userdao.findEmailByNickname(searchWord);
   	
	  if(email != null){
		  searchMap.put("searchField", BoardDTO.USEREMAIL);
	   	searchMap.put("searchWord", email);
	  }else{
	   searchMap.put("searchField", BoardDTO.USEREMAIL);
	   searchMap.put("searchWord", null);
  	}
  }else{
	  if(searchWord == null || searchWord.trim().isEmpty()){
		  searchMap.put("searchField", searchField);
	   	searchMap.put("searchWord", null);
	  }else{
		  searchMap.put("searchField", searchField);
	   	searchMap.put("searchWord", searchWord);
	  }
	}
	
	
	int itemsPerPage = (currentPage == 1 && searchWord != null && !searchWord.trim().isEmpty()) ? 8 : 5;
	int sortBoardCount = dao.getTotalBoardCount(sort, category, searchMap);//정렬 결과 개수
// 	int totalPages = (int)Math.ceil((double)(sortBoardCount+3)/itemsPerPage); //공지사항 3 포함해서 페이지 개수
	int totalPages = (int)Math.ceil((double)(sortBoardCount + (currentPage == 1 && searchWord == null ? 3 : 0)) / itemsPerPage);
  List<BoardDTO> boardList = dao.getBoardList(sort, category, searchMap, currentPage, itemsPerPage);
	
	List<NoticeDTO> noticeList = new ArrayList<>();
	
	if(currentPage == 1 && (searchWord == null || searchWord.trim().isEmpty())){
		noticeList = noticedao.getTop3Notice();
	}
	
	dao.close();
	noticedao.close();
	   
	JSONArray jsonArray = new JSONArray();
	
	for (BoardDTO board : boardList) {
	   JSONObject jsonObject = new JSONObject();
	   
	   jsonObject.put("id", board.getId());
	   jsonObject.put("type", board.getType());
	   jsonObject.put("title", board.getTitle());
	   jsonObject.put("nickname", userdao.findNicknameByEmail(board.getUser_email()));
	   jsonObject.put("date", board.getDate());
	   jsonObject.put("views", board.getViews());
	   jsonObject.put("likeCount", board.getLike_count());
	   jsonObject.put("reportState", board.getReport_state());
	   
	   jsonArray.put(jsonObject);
   }
	
	JSONArray noticeArray = new JSONArray();
	for(NoticeDTO notice : noticeList){
		JSONObject noticeObject = new JSONObject();
		noticeObject.put("id", notice.getId());
		noticeObject.put("title", notice.getTitle());
		noticeObject.put("date", notice.getDate());
		
		noticeArray.put(noticeObject);
	}
	
	
	
	userdao.close();
	
	System.out.println("[boardSortProc] totalPages : " + totalPages);

	JSONObject responseJson = new JSONObject();
	
	responseJson.put("boardList", jsonArray);
	responseJson.put("noticeList", noticeArray);
	responseJson.put("totalPages", totalPages);
	
	
	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	response.getWriter().write(responseJson.toString());
%>