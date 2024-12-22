<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@page import="dao.CommentDAO"%>
<%@page import="dto.CommentDTO"%>
<%@page import="java.util.List"%>
<%@page import="common.LoginManager"%>
<%@page import="dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	UserDTO user = LoginManager.getUser();
	CommentDAO commentdao = new CommentDAO();
	List<CommentDTO> comments = commentdao.getCommentByUser(user.getEmail());
	commentdao.close();
	if(comments == null || comments.isEmpty()){
%>
	<p>작성한 댓글이 없습니다. </p>
	<%
	}else{
		for(CommentDTO comment: comments){
			BoardDAO boarddao = new BoardDAO();
			BoardDTO board = boarddao.getBoardById(comment.getBoardId());
			boarddao.close();
	%>
    <div class="commentitem">
       <a href="<%= request.getContextPath() %>/community/boardDetail.jsp?boardId=<%=board.getId()%>" id="commentLink<%=comment.getId()%>">
         <%if(comment.getParentCommentId() == 0){ %>
         <img
           class="commentImg"
           src="../resources/image/comment.png"
           alt="댓글"
         />
         <%} else if(comment.getParentCommentId() != 0) {%>
         <img
           class="commentImg"
           src="../resources/image/recomment.png"
           alt="답글"
         />
         <%} %>
         <h3 style="width:200px;"><%=board.getTitle().length() > 10 ? board.getTitle().substring(0, 10)+"..." : board.getTitle() %></h3>
         <p id="commentText<%=comment.getId()%>"><%=comment.getContent().length() > 30 ? comment.getContent().substring(0, 30)+"..." : comment.getContent() %></p>
         <textarea rows="2" id="commentTA<%=comment.getId()%>" style="display:none; width:100px;"><%=comment.getContent() %></textarea>
         <p id="commentDate<%=comment.getId()%>" style="width:100px; margin-right:80px;"><%= comment.getDate() %></p>
       </a>
       <img class="commentEdit" src="../resources/image/edit.png" alt="수정" onclick="showEdit(<%=comment.getId() %>,event)" />
       <img
         class="commentDelete"
         src="../resources/image/delete.png"
         alt="삭제"
         onclick="deleteComment('<%=comment.getId()%>')"
       />
       <button class="editsavebtn" id="saveButton<%=comment.getId() %>" style="display:none;" onclick="saveComment(<%=comment.getId() %>)" type="button">수정 완료</button>
       <%if(comment.getReportState() == 2) {%>
        	<span class="report">신고된 글입니다. 자세한 사항은 Q&A로 문의해주세요.</span>
       	<%} %>
     </div>
	<%
		}
	}
	%>

<script src="<%= request.getContextPath() %>/resources/js/activity_mycomment.js"></script>

