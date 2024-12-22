<%@page import="dto.NoticeDTO"%>
<%@page import="dao.NoticeDAO"%>
<%@page import="dao.UserDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.BoardDTO"%>
<%@page import="java.util.*"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	BoardDAO dao = new BoardDAO();
	
	int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
	
	// 정렬 및 카테고리 파라미터 받기
	String sort = request.getParameter("sort") != null ? request.getParameter("sort") : "latestOrder"; // 기본값은 최신순
	String category = request.getParameter("category") != null ? request.getParameter("category") : "all"; // 기본값은 전체
	String searchField= request.getParameter("searchField") != null ? request.getParameter("searchField") : "title"; 
	String searchWord = request.getParameter("searchWord") != null ? request.getParameter("searchWord") : "";
	
	// 검색어를 Map에 저장
    Map<String, Object> searchMap = new HashMap<>();

    if ("nickname".equals(searchField)) {
        UserDAO userdao = new UserDAO();
        String email = userdao.findEmailByNickname(searchWord);
        if (email != null) {
            searchMap.put("searchField", BoardDTO.USEREMAIL);
            searchMap.put("searchWord", email);
        } else {
            searchMap.put("searchField", BoardDTO.USEREMAIL);
            searchMap.put("searchWord", null);
        }
    } else {
        if (searchWord == null || searchWord.trim().isEmpty()) {
            searchMap.put("searchField", searchField);
            searchMap.put("searchWord", null);
        } else {
            searchMap.put("searchField", searchField);
            searchMap.put("searchWord", searchWord);
        }
    }
		
	int itemsPerPage;
	if(currentPage ==1){
		if(searchWord != null && !searchWord.trim().isEmpty()){
			itemsPerPage = 8;
		}else{
			itemsPerPage = 5;
		}
	}else{
		itemsPerPage = 8;
	}
	int totalBoards = dao.getTotalBoardCount(sort, category, searchMap);
	int additionalItems = ((searchWord == null || searchWord.trim().isEmpty()) ? 3 : 0);
	int totalPages = (int)Math.ceil((double)(totalBoards + additionalItems) / 8);
// 	int totalPages = (int) Math.ceil((double)(totalBoards+3)/itemsPerPage); //총 페이지 수
	System.out.println("totalPage-"+ totalPages + " itemsPerPage=" +itemsPerPage + " additionalItems- "+ additionalItems);	

	List<BoardDTO> boardList = dao.getBoardList(sort, category, searchMap, currentPage, itemsPerPage);
	
	List<NoticeDTO> noticeList = new ArrayList<>();
	if(currentPage==1 && (searchWord == null || searchWord.trim().isEmpty())){
		NoticeDAO noticedao = new NoticeDAO();
		noticeList = noticedao.getTop3Notice();
		noticedao.close();
	}
	
	dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <link rel="stylesheet" href="../resources/css/header.css" />
    <link rel="stylesheet" href="../resources/css/footer.css" />
    <link rel="stylesheet" href="../resources/css/board.css" />
</head>
<body>
    <%@include file="/common/side_background.jsp"%>
    <%@include file="/common/header.jsp" %>
    <div id="container">
    <section>
        <div id="section-container">

          <div id="section-top">
            <div class="board-sort">
                <label for="bSort">정렬</label>
                <select name="bSort" id="bSort">
			            <option value="latestOrder" <%= "latestOrder".equals(sort) ? "selected" : "" %>>최신순</option>
			            <option value="oldOrder" <%= "oldOrder".equals(sort) ? "selected" : "" %>>오래된순</option>
			            <option value="visitOrder" <%= "visitOrder".equals(sort) ? "selected" : "" %>>조회수순</option>
			            <option value="likeOrder" <%= "likeOrder".equals(sort) ? "selected" : "" %>>추천수순</option>
				        </select>
                <select name="bSort-category" id="bSort-category">
                  <option value="all" <%= "all".equals(category) ? "selected" : "" %>>전체</option>
                  <option value="연극" <%= "연극".equals(category) ? "selected" : "" %>>연극</option>
                  <option value="소통" <%= "소통".equals(category) ? "selected" : "" %>>소통</option>
                </select>
            </div>
            <div class="board-search">
              <form name="boardSearchForm" action="#">
                <select name="bSearch" id="bSearchSelect">
                  <option value="title">제목</option>
                  <option value="nickname">작성자</option>
                  <option value="id">글번호</option>
                </select>
                <div class="boardSearchBtn">
                  <input type="text" name="searchWord" id="searchWordInput" placeholder="검색어 입력" />
                  <button type="button" id="searchButton">
		                <span><i class="fa-solid fa-magnifying-glass fa-lg"></i></span>
			            </button>
                </div>
              </form>
            </div>
            
            <div class="board-write">
              <button id="boardWriteBtn">글쓰기</button>
            </div>
          </div>
          <div id="section-middle">
            <table>
              <thead>
                <tr>
                  <th>글번호</th>
                  <th>카테고리</th>
                  <th>제목</th>
                  <th>작성자</th>
                  <th>작성일</th>
                  <th>조회수</th>
                  <th>추천수</th>
                </tr>
              </thead>
              <tbody>
              <%
              	int displayedItem = 0; //현 페이지의 표시된 게시글 추적
              	if(noticeList != null){             	
              	for(NoticeDTO notice : noticeList){
              %>
								<tr data-notice-id="<%= notice.getId()%>" style="cursor:pointer;" class="noticeBackground">
	                <td><%= notice.getId() %></td>
	                <td>공지사항</td>
	                <td><%= notice.getTitle().length() > 10 ? notice.getTitle().substring(0, 10) + "..." : notice.getTitle() %></td>
	                <td>관리자</td>
	                <td><%=notice.getDate() %></td>
	                <td>-</td>
	                <td>-</td>
	              </tr>
              <%
              	displayedItem++;
              	} 
              }%>
			
							<% for(BoardDTO board:boardList){ 
								String account = board.getUser_email();
								UserDAO userdao = new UserDAO();
								String nick = userdao.findNicknameByEmail(account);
								userdao.close();
								%>
								<tr data-board-id="<%= board.getId() %>" style="cursor:pointer;">
									<td><%= board.getId() %></td>
									<td><%= board.getType() %></td>
									<td><%= board.getTitle().length() > 10 ? board.getTitle().substring(0, 10) + "..." : board.getTitle() %></td>
									<td><%= nick %></td>
									<td><%= board.getDate() %></td>
									<td><%= board.getViews() %></td>
									<td><%= board.getLike_count() %></td>
								</tr>
							<%
// 							        }
							        displayedItem++; // 게시글이 출력될 때마다 증가
							    }
							    %>

						    <!-- 빈 행 추가 -->
					    <%
							    int emptyRows;
							    if (currentPage == 1 && searchWord.isEmpty()) { // searchTerm이 검색어를 담고 있는 변수라고 가정
							        emptyRows = itemsPerPage - (displayedItem - 3);
							    } else {
							        emptyRows = itemsPerPage - displayedItem; // 일반적인 경우
							    }
							    for (int i = 0; i < emptyRows; i++) {
							%>
					        <tr>
					            <td colspan="7" class="emptyRow"></td> <!-- 7열 전체를 차지하는 빈 행 -->
					        </tr>
							<%
							    }
							    %>
                
              </tbody>
            </table>
          </div>
          
          <div id="section-bottom" data-current-page="<%= currentPage %>">
          	<% if (currentPage > 1) { %>
<!-- 			        <button onclick="location.href='./boardList.jsp?page=1'">처음</button> -->
		        	<button onclick="location.href='./boardList.jsp?page=<%= currentPage - 1 %>&sort=<%= sort %>&category=<%= category %>&searchField=${searchField}&searchWord=${searchWord}'">이전</button>
				    <% } else { %>
			        <!-- 현재 첫 페이지일 경우, 페이지를 다시 로드 -->
			        <button onclick="location.reload()">이전</button>
				    <% } %>
				    
				    <% for (int i = 1; i <= totalPages; i++) { %>
<%-- 			        <button onclick="location.href='./boardList.jsp?page=<%= i %>&sort=<%= sort %>&category=<%= category %>'"><%= i %></button> --%>
			        <button onclick="location.href='./boardList.jsp?page=<%= i %>&sort=<%= sort %>&category=<%= category %>&searchField=<%= searchField %>&searchWord=<%= searchWord %>'"><%= i %></button>
				    <% } %>
				    
				    <% if (currentPage < totalPages) { %>
			        <button onclick="location.href='./boardList.jsp?page=<%= currentPage + 1 %>&sort=<%= sort %>&category=<%= category %>&searchField=${searchField}&searchWord=${searchWord}'">다음</button>
<%-- 			        <button onclick="location.href='./boardList.jsp?page=<%= totalPages %>'">끝</button> --%>
				    <% } else { %>
			        <!-- 현재 마지막 페이지일 경우, 페이지를 다시 로드 -->
			        <button onclick="location.reload()">다음</button>
				    <% } %>
          </div>
        </div>
      </section>
    </div>
    <%@include file="/common/footer.jsp" %>
    <script src="../resources/js/boardList.js"></script>
</body>
</html>