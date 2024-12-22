<%@page import="dto.UserDTO"%>
<%@page import="dto.NoticeDTO"%>
<%@page import="dao.NoticeDAO"%>
<%@page import="dao.BoardDAO"%>
<%@page import="dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 	String account = LoginManager.getLoginedAccount(session);
	UserDTO account = LoginManager.getUser();
	if (account == null) {
    // 로그인하지 않은 경우
    out.println("<script>alert('글을 작성하고 싶다면 로그인해주세요.'); window.history.back();</script>");
    return; // 이후 코드는 실행하지 않도록 함
	}
	
   String boardId = request.getParameter("boardId"); // 수정 모드인지 확인
   String noticeId = request.getParameter("noticeId");
   
   BoardDTO board = null;
   NoticeDTO notice = null;
   
   if (boardId != null) {
      BoardDAO boardDao = new BoardDAO();
      board = boardDao.getBoardById(Integer.parseInt(boardId));
      boardDao.close();
 	 }else if(noticeId != null){
 		 NoticeDAO noticedao = new NoticeDAO();
 		 notice = noticedao.getNoticeById(Integer.parseInt(noticeId));
 		 noticedao.close();
 	 }
   
   //관리자 계정 확인
//    boolean isAdmin = LoginManager.isAdmin(session);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
    />
    <link rel="stylesheet" href="../resources/css/header.css" />
    <link rel="stylesheet" href="../resources/css/footer.css" />
    <link rel="stylesheet" href="../resources/css/boardAdd.css" />
</head>
<body>
		<%@include file="/common/side_background.jsp"%>
    <%@include file="/common/header.jsp" %>
    <div id="container">
    <section>
        <div id="section-container">


          <!-- 글작성 본문 -->
          <div class="write-container">
            <div class="write">
              <form action="${pageContext.request.contextPath}/boardAddServlet" method="post" name="boardForm" enctype="multipart/form-data">
              	<input type="hidden" name="account" value="<%= account.getEmail() %>">
              	<input type="hidden" name="boardId" value="<%= board != null ? board.getId() : "" %>">
              	<input type="hidden" name="noticeId" value="<%= notice != null ? notice.getId() : "" %>">
                <div style="
                	display: flex;
							    justify-content: space-evenly;
							    align-items: center;
							    margin: 35px auto;
							    width:80%;
                ">
	                <div class="title">
	                  <p>제목 </p>
	                  <input
	                    type="text"
	                    name="boardTitle"
	                    id="boardTitle"
	                    placeholder="글 제목을 입력하세요."
	                    value="<%= board != null ? board.getTitle() : (notice != null ? notice.getTitle() : "") %>"
	                  />
	                </div>
	                <div class="category">
	                	<% if(isAdmin) { %>
	                  <select name="noticPriority" id="noticPriority">
	                    <option value="priority">우선순위</option>
	                    <option value="1" <%= notice != null && notice.getPriority() == 1 ? "selected" : "" %>>1</option>
	                    <option value="2" <%= notice != null && notice.getPriority() == 2 ? "selected" : "" %>>2</option>
	                    <option value="3" <%= notice != null && notice.getPriority() == 3 ? "selected" : "" %>>3</option>
	                  </select>
	                  
	                  <select name="boardCategory" id="boardCategory">
	                    <option value="category">카테고리</option>
	                    <option value="공지사항">공지사항</option>
	                    <option value="연극">연극</option>
	                    <option value="소통">소통</option>
	                  </select>
	                  <%}else{ %>
	
	                  <select name="boardCategory" id="boardCategory">
	                    <option value="category">카테고리</option>
	                    <option value="연극" <%= board != null && "연극".equals(board.getType()) ? "selected" : "" %>>연극</option>
	            				<option value="소통" <%= board != null && "소통".equals(board.getType()) ? "selected" : "" %>>소통</option>
	                  </select>
	                  <%} %>                  
                  </div>
                </div>
                <div class="content">
                  <div class="content-image">
                    <label for="contentImage">이미지 업로드</label>
                    <input
                      type="file"
                      name="contentImage"
                      id="contentImage"
                      accept="image/*"
                      multiple
                    />
                    <ul id="imgPreview">
                    <%
                    if(boardId != null && board != null){
	                    String imgPath = board.getImg_path(); // 이미지 경로 가져오기
	                    if (imgPath != null && !imgPath.isEmpty()) {
	                        String[] images = imgPath.split(","); // 쉼표로 구분된 이미지 파일명 배열
	                        for (String imageName : images) {
	                            // 서버의 이미지 경로 (상대경로로 조정)
	                            String imageUrl = request.getContextPath() + "/resources/image/boardImage/" + imageName;
                    %>
                      <li><img src="<%= imageUrl %>" alt="<%=imageName %>" /></li>
                    <%
                        }
	                    }
                    }
                    %>
                    </ul>
                  </div>
                  <textarea name="contentText" id="contentText" placeholder="글 내용을 입력하세요"><%= board != null ? board.getContents() : (notice != null ? notice.getContents() : "") %></textarea>
                </div>
                <!-- <p>닉네임</p> -->
                <div id="boardAddBtns">
                	<button type="submit" id="boardSubmitBtn"><%= boardId != null || noticeId != null ? "글 수정" : "글 등록" %></button>
                	<button type="button" id="boardBackBtn"><%= boardId != null || noticeId != null ? "수정 취소" : "등록 취소" %></button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </section>
    
    </div>
        <%@include file="/common/footer.jsp" %>
    
    <script src="../resources/js/boardAdd.js"></script>
</body>
</html>