<%@page import="dao.BoardDAO"%>
<%@page import="dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="common.LoginManager"%>
<%@page import="dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 게시글 목록 탭 -->
<%
	UserDTO user = LoginManager.getUser();
	BoardDAO boarddao = new BoardDAO();
	List<BoardDTO> boards = boarddao.getBoardListByUser(user.getEmail());
	boarddao.close();
	if(boards == null || boards.isEmpty()){
%>
	<p>작성한 게시글이 없습니다. </p>
	<%
	}else{
		for(BoardDTO board : boards){
	%>
		<div class="boarditem">
	        <a href="<%= request.getContextPath() %>/community/boardDetail.jsp?boardId=<%=board.getId()%>">
	          <h3><%=board.getTitle().length() > 10 ? board.getTitle().substring(0, 10)+"..." : board.getTitle() %></h3>
	          <p>
	          <%= board.getContents().length() > 30 ? board.getContents().substring(0, 30)+"..." : board.getContents()%>
	          </p>
	          <p><%= board.getDate() %></p>
	        </a>
	        <img class="boardEdit" src="../resources/image/edit.png" alt="수정"
	        	onclick="location.href='<%= request.getContextPath() %>/community/boardAdd.jsp?boardId=<%=board.getId() %>'" />
	        <img
	          class="boardDelete"
	          src="../resources/image/delete.png"
	          alt="삭제"
	          onclick="deleteBoard('<%=board.getId() %>')"
	        />
        <%if(board.getReport_state() == 2) {%>
        	<span class="report">신고된 글입니다. 자세한 사항은 Q&A로 문의해주세요.</span>
       	<%} %>
    </div>
	<%
		}
	}
	%>

	<script src="../resources/js/activity_myboard.js"></script>