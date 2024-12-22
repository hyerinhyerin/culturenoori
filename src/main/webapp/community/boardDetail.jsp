<%@page import="utils.ProfileImage"%>
<%@page import="dto.UserDTO"%>
<%@page import="dao.CommentLikeDAO"%>
<%@page import="dao.CommentDAO"%>
<%@page import="dto.CommentDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.NoticeDTO"%>
<%@page import="dao.NoticeDAO"%>
<%@page import="java.util.*"%>
<%@page import="dao.BoardLikeDAO"%>
<%@page import="dao.UserDAO"%>
<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	UserDTO useraccount = LoginManager.getUser();
// 	String imagePath=null;
// 	if(useraccount != null){
// 		imagePath = (useraccount.getImg_path() != null && !useraccount.getImg_path().isEmpty()) ?
// 				request.getContextPath()+"/resources/image/profileImage/"+useraccount.getImg_path()
// 				: request.getContextPath()+"/resources/image/comment_profile.png";
// 	}
	

	String boardIdStr = request.getParameter("boardId");
	String noticeIdStr = request.getParameter("noticeId");
	int boardId=0;
	int noticeId=0;
	String sort = (request.getParameter("sort") != null) ? request.getParameter("sort") : "latestOrder";
	String category = (request.getParameter("category") != null) ? request.getParameter("category") : "all";
	String searchField = (request.getParameter("searchField") != null) ? request.getParameter("searchField") : "title";
	String searchWord = (request.getParameter("searchWord") != null) ? request.getParameter("searchWord") : "";


	UserDAO userdao = new UserDAO();
	BoardDAO boarddao = new BoardDAO();
	NoticeDAO noticedao = new NoticeDAO();
	BoardLikeDAO likedao = new BoardLikeDAO();
	
	//searchField, searchWord map으로 묶기
	Map<String, Object> searchMap = new HashMap<>();

  if ("nickname".equals(searchField)) {
    String email = userdao.findEmailByNickname(searchWord);
    searchMap.put("searchField", BoardDTO.USEREMAIL);
    searchMap.put("searchWord", email != null ? email : null);
  } else {
	  searchMap.put("searchField", searchField);
    searchMap.put("searchWord", (searchWord == null || searchWord.trim().isEmpty()) ? null : searchWord);
  }
  
	
	BoardDTO board=null;
	NoticeDTO notice = null;
	String nick = ""; //작성자의 닉네임
  List<BoardDTO> previousBoards = new ArrayList<>();
  List<BoardDTO> nextBoards = new ArrayList<>();
  List<BoardDTO> topBoards = new ArrayList<>();
  
	
	//게시글 정보 가져오기
	if (boardIdStr != null) {
		try {
	    boardId = Integer.parseInt(boardIdStr);
	    board = boarddao.getBoardById(boardId);
	    
	    System.out.println("boardDetail_getboard : " + board);
	
	    if (board != null) {
     	 String account = board.getUser_email();
       nick = userdao.findNicknameByEmail(account);
	    } else {
       	// board가 null인 경우 처리
      	System.out.println("해당 ID의 게시글을 찾을 수 없습니다. ID: " + boardId);
       	// 필요한 경우 에러 메시지를 뷰에 전달하거나 다른 처리를 합니다.
	    }
	    
	    int offset = 2;
	    previousBoards = boarddao.getAdjacentBoards(boardId, sort, category, searchMap, offset);
	    nextBoards = boarddao.getAdjacentBoardsAfter(boardId, sort, category, searchMap, offset);
		} catch (NumberFormatException e) {
  	  	System.out.println("boardIdStr의 형식이 올바르지 않습니다: " + boardIdStr);
    }
	}else if(noticeIdStr != null){
		try {
	    noticeId = Integer.parseInt(noticeIdStr);
	    notice = noticedao.getNoticeById(noticeId);
	    if (notice != null) {
	        nick = "관리자";
	    }
	    
	    topBoards = boarddao.getTop5Boards(sort, category, searchMap);
    } catch (NumberFormatException e) {
       System.out.println("noticeIdStr의 형식이 올바르지 않습니다: " + noticeIdStr);
    }
	}
	
	//뷰어랑 작성자가 같은지 확인
	String boardwriter = (board != null) ? board.getUser_email() : LoginManager.ADMIN_EMAIL; 
	String viewermail = useraccount != null ? useraccount.getEmail() : "";
	
	boolean isUserViewer = (viewermail != null && viewermail.equals(boardwriter)) ? true : false;
	
	System.out.println("boardDetail writer-"+boardwriter+" viewer-"+viewermail);
	
	System.out.println("boardDetail isUserViewer-"+isUserViewer);
	
	
	//뷰어가 이미 좋아요를 클릭했는지 확인
	boolean liked = false;
  String classClicked = "";
  if (board != null) { // 일반 게시글일 때
    liked = likedao.isClicked(board.getId(), viewermail);
    classClicked = liked ? "clicked" : "";
  }
	
  
  boarddao.close();
  noticedao.close();
  likedao.close();
%>

<script>
	//JSP에서 전달된 변수를 JS에서 사용
<%-- 	let isBoardNull = <%= (board == null) ? "true" : "false" %>; --%>
<%-- 	let isNoticeNull = <%= (notice == null) ? "true" : "false" %>; --%>
	
// 	if (!isBoardNull && !isNoticeNull) {
// 	    alert("게시글과 공지사항이 없습니다.");
// 	    window.location.href = "./boardList.jsp"; // boardList.jsp로 리다이렉트
// 	} 
</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세 페이지</title>
	<link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    
    <link rel="stylesheet" href="../resources/css/common.css" />
    <link rel="stylesheet" href="../resources/css/header.css" />
    <link rel="stylesheet" href="../resources/css/footer.css" />
    <link rel="stylesheet" href="../resources/css/boardDetail.css" />
</head>
<body>
	<%@include file="/common/side_background.jsp"%>
	<%@include file="/common/header.jsp" %>
	<%@include file="../common/popupInput.jsp"%>
	<%@include file="../common/popupOkCancel.jsp"%>
	<div id="container">
		<section>
        <div id="section-container">

<!--            게시글 영역-->
            <div class="board-container">
<!--                버튼들 영역-->
                <div id="boardBtn">
										<% if(isUserViewer){ %>
                    <button type="button" id="boardEditBtn" onclick="location.href='boardAdd.jsp?<%= board != null ? "boardId=" + board.getId() : "noticeId=" + notice.getId() %>';">수정하기</button>
                    <button type="button" id="boardDeleteBtn" onclick="confirmDelete(<%= board != null ? board.getId() : notice.getId() %>, <%= board == null %>);">삭제하기</button>
                    <%} %>
                    <button type="button" id="boardListBtn">목록보기</button>
                </div>
<!--                본문 영역-->
                <div id="content-container">
                    <div class="content-top">
                        <div>
<!--                         	카테고리 -->
                            <p><%= board != null ? board.getType() : "공지사항" %><hr/></p>
                            <h3><span><%= board != null ? board.getTitle() : notice.getTitle() %></span></h3>
                        </div>
                    </div>
                    <div class="content-middle">
                    	<div style="display:flex; ">
                    	<% if(board != null && board.getReport_state() == 1){ %>
                    		<div style=" color: transparent; background-color: #f0f0f0; padding: 10px; border-radius:10px;">신고 처리된 게시글입니다.</div>
                    	<%}else{ %>
                    		<p style="margin-right:15px;">작성자 : <%= nick %></p> 
                        <p>작성 날짜 : <%= board != null ? board.getDate() : notice.getDate() %></p>
                        <%} %>
                    	</div>
                    	
                    	<div style="display:flex; align-items:center;">
	                    	<%if (!(notice != null)) { %>
	                        <button type="button" id="boardReportBtn" onclick="confirmReport(<%= board != null ? board.getId() : notice.getId() %>, '<%= viewermail %>', 'board', this);">
	                        	<img src="../resources/image/siren.png" class="commentReport" alt="report">
	                        </button>
                          
	                        <span class="likeIcon" data-board-id="<%= board.getId() %>" data-user-email="<%= viewermail %>" style="margin-left:15px;">
	                        <i class="fa-regular fa-thumbs-up fa-xl <%=classClicked %>"></i>
	                        <span class="likeCount"><%= board.getLike_count()== 0 ? "" : board.getLike_count()%></span>
	                        </span>
	                        <%} %>
                    	</div>
                    </div>
                    <div class="content-bottom">
                    		<div id="content-body" style="  align-items: center; height: 100%; text-align: left;">
                    		<%if(board != null && board.getReport_state() == 1) {%>
                    			<p style="color: #a64d4d; font-weight: bold; text-align: center;">신고 처리된 게시글입니다.</p>
                    		<%} else{ %>
                        	<p><%= (board != null ? board.getContents() : notice.getContents()).replace("\n", "<br>") %></p>
                        </div>
<!--                     	이미지가 있다면 개수만큼 -->
                    		<%
                    			if(board != null){
                    			String imgPaths = board.getImg_path();
                    			List<String> imageList = new ArrayList<>();
                    			
                    			if(imgPaths != null && !imgPaths.isEmpty()){
                    				String[] imgArray = imgPaths.split(",");
                    				for(String img:imgArray){
                    					imageList.add(img.trim());
                    				}
                    			}
                    			for(String imageName : imageList){
                    		%>
                        <img src="<%= request.getContextPath() + "/resources/image/boardImage/" + imageName %>" >
                        <%
	                    			}
	                   			}
                    		}
                        %>
                    </div>
                </div>
            </div>
<!--            댓글 영역-->
						<%if(board != null) { %>
            <div id="comment-container">

                <div class="commentInput" data-user-nick="<%= useraccount != null ? useraccount.getNickname() : ""%>">

                  <form id="commentForm" style="display:flex;">
                      <textarea name="comment" placeholder="댓글을 입력하세요." required></textarea>
                      <input type="hidden" name="userEmail" value="<%= viewermail %>">
                      <input type="hidden" name="boardId" value="<%=board.getId() %>">
                      <button type="submit">등록</button>
                  </form>
                </div>
                <hr>
<!--                전체 댓글 리스트-->
								<%
									CommentDAO commentdao = new CommentDAO();
									List<CommentDTO> comments = commentdao.getCommentByBoardId(board.getId());
									commentdao.close();
								%>
                <div class="commentList">
<!--                    댓글과 답글 감싸는 container-->

<!-- 					댓글 개수만큼. -->
									<% for(CommentDTO comment:comments){
											UserDAO cuserdao = new UserDAO();
											UserDTO cmdto = cuserdao.getUserByEmail(comment.getUserEmail());
											cuserdao.close();
											
											//이미지
											String imagePath;
									    if (comment.getReportState() == 1) {
								        imagePath = ""; // 신고된 경우 기본 이미지
									    } else {
									        imagePath = cmdto.getImg_path() != null ?
							           		request.getContextPath() + "/resources/image/profileImage/" + cmdto.getImg_path() :
								            ""; // 경로가 없는 경우 기본 이미지
									    } 
											
											
											boolean isCommentMaster = viewermail != null && viewermail.equals(comment.getUserEmail());
											
											CommentLikeDAO commentlikedao = new CommentLikeDAO();
											//뷰어가 댓글을 이미 좋아요 했는지 확인
										  boolean commentLiked = commentlikedao.isLiked(comment.getId(), viewermail);
										  String commentClassClicked = commentLiked ? "clicked" : "";
										  commentlikedao.close();
										  
										  //답글 가져오기
										  CommentDAO recommentdao = new CommentDAO();
										  List<CommentDTO> replies = recommentdao.getAllComments(comment.getId());
										  recommentdao.close();
										%>
                  <div class="commt-container" data-comment-id="<%=comment.getId()%>" data-user-nick="<%= useraccount != null ? useraccount.getNickname() : "비회원"%>">
<!--                        댓글 아이템-->
                     	<div class="commentItem">
													<% if(imagePath.isEmpty()) { %>
													    <%= ProfileImage.genSvgTag(70, 70, "#CBDCF5", 20) %> 
													<% } else { %>
													    <img src="<%= imagePath %>" class="commentProfile" alt="profile">
													<% } %>
													                         
                          <div class="commtItem-section">
                              <% if(comment.getReportState() == 1) {%>
                              <p class="report-message">신고처리된 댓글입니다.</p>
                              <%} else{ %>
                              <div class="commt-1">
                                  <p class="nick"><%=cmdto.getNickname() %></p>
                                  <span class="likeIcon" data-comment-id="<%= comment.getId() %>" data-user-email="<%= viewermail %>">
                                  <i class="fa-regular fa-thumbs-up fa-lg <%= commentClassClicked%>"></i>
                                  <span class="likeCount"><%= comment.getLikeCount() == 0 ? "0" : comment.getLikeCount() %></span>
                                  </span>
                              </div>
                              <p class="commt" id="commentText<%= comment.getId() %>"> <%=comment.getContent() %></p>
                              <textarea class="commt-textarea" id="commentTextarea<%= comment.getId() %>" style="display:none;"><%= comment.getContent() %></textarea>
                              <div class="commt-2">
                                  <p class="commtDate"><%=comment.getDate() %></p>
                                  <button class="recommt" id="recommtBtn" data-comment-id="<%=comment.getId()%>">답글쓰기</button>
                                  <%if(isCommentMaster) {%>
                                  <button class="recommt" id="editButton<%=comment.getId() %>" onclick="showEdit(<%= comment.getId() %>)">수정하기</button>
                                  <button class="recommt" id="saveButton<%= comment.getId() %>" style="display:none;" onclick="saveComment(<%= comment.getId() %>)">수정 완료</button>
                                  <button class="recommt" onclick="deleteComment(<%=comment.getId() %>)">삭제하기</button>
                                  <%} %>
<!--                              TODO:JHK: 신고(댓글) 기능 버튼 이벤트 달기 - reportIcon  -->                                  
                                  <span class="reportIcon" data-comment-id="<%= comment.getId() %>" data-user-email="<%= viewermail %>">
                                  <img src="../resources/image/siren.png" class="commentReport" alt="report">
                                  </span>
                              </div>
                              <%} %>
                          </div>
                      </div>
<!--                         답글 개수만큼 -->
                      <%if(!replies.isEmpty()) {
                    	  for(CommentDTO reply : replies){
                    		  UserDAO replyuserdao = new UserDAO();
													UserDTO redto = replyuserdao.getUserByEmail(reply.getUserEmail());
                    		  replyuserdao.close();
                    		  
                    		  String reImagePath;
											    if (reply.getReportState() == 1) {
											    	reImagePath = ""; // 신고된 경우 기본 이미지
											    } else {
											    	reImagePath = redto.getImg_path() != null ?
									           		request.getContextPath() + "/resources/image/profileImage/" + redto.getImg_path() :
										            ""; // 경로가 없는 경우 기본 이미지
											    }
                    		  
                    		  
                    		  
													boolean isReCommentMaster = viewermail != null && viewermail.equals(reply.getUserEmail());
													
													CommentLikeDAO recommentlikedao = new CommentLikeDAO();

													boolean recommentLiked = recommentlikedao.isLiked(reply.getId(), viewermail);
												  String recommentClassClicked = recommentLiked ? "clicked" : "";
												  recommentlikedao.close();
												  
												  CommentDAO parentNickdao = new CommentDAO();
												  String parentNick = parentNickdao.getParentCommentNickname(reply.getParentCommentId());
												  
													System.out.println("reply.getUseremail- "+reply.getUserEmail()+" viewermail-"+viewermail+" isRecommentMaster-"+isReCommentMaster+" recommentClassClicked-"+recommentClassClicked);

                      %>
<!--                        답글 아이템-->
                      <div class="recommentItem">
                          
													<% if(reImagePath.isEmpty()) { %>
													    <%= ProfileImage.genSvgTag(70, 70, "#CBDCF5", 20) %> 
													<% } else { %>
													    <img src="<%= reImagePath %>" class="commentProfile" alt="profile">
													<% } %>			                                              
                          
                          <div class="commtItem-section">
                              <% if(reply.getReportState() == 1){ %>
                              <p class="report-message">신고처리된 답글입니다.</p>
                              <%}else{ %>
                              <div class="commt-1">
                                  <p class="nick"><%=redto.getNickname() %></p>
                                  <span class="likeIcon" data-comment-id="<%= reply.getId() %>" data-user-email="<%= viewermail %>">
                                  <i class="fa-regular fa-thumbs-up fa-lg <%= recommentClassClicked%>"></i>
                                  <span class="likeCount"><%= reply.getLikeCount() == 0 ? "0" : reply.getLikeCount() %></span>
                                  </span>
                              </div>
                              <p class="commt" id="commentText<%= reply.getId() %>"><b>@<%=parentNick%></b> <%=reply.getContent() %></p>
                              <textarea class="commt-textarea" id="commentTextarea<%= reply.getId() %>" style="display:none;"><%= reply.getContent() %></textarea>
                              <div class="commt-2" >
                                  <p class="commtDate"><%=reply.getDate() %></p>
                                  <button class="recommt" id="recommtBtn" data-comment-id="<%=reply.getId()%>">답글쓰기</button>
                                  <%if(isReCommentMaster) {%>
                                  <button class="recommt" id="editButton<%=reply.getId() %>" onclick="showEdit(<%= reply.getId() %>)">수정하기</button>
                                	<button class="recommt" id="saveButton<%= reply.getId() %>" style="display:none;" onclick="saveComment(<%= reply.getId() %>)">수정 완료</button>
                                  <button class="recommt" onclick="deleteComment(<%=reply.getId() %>)">삭제하기</button>
                                  <%} %>
                                  <span class="reportIcon" data-reply-id="<%= reply.getId() %>" data-user-email="<%= viewermail %>">
                                  <img src="../resources/image/siren.png" class="commentReport" alt="report">
                                  </span>
                              </div>
                              <%} %>
                          </div>
                      </div>
                      <%}
                   	  }%>
                  </div>
								 <%} %>
                </div>
            </div>
            <%} %>
<!--            게시글 목록 영역 - 현 게시글 위치 기준 전2개, 후2개-->
            <div id="boardList">

                <div class="boardList-container">
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
                        <%if(board != null) {%>
                        <!-- 							            이후 게시글 -->
												<%
													Collections.reverse(nextBoards);
													for(BoardDTO nextboard : nextBoards){
                        		String account = nextboard.getUser_email();
														UserDAO dao = new UserDAO();
														String nicklist = dao.findNicknameByEmail(account);
														dao.close();
														
												%>
												 	<tr data-board-id="<%= nextboard.getId() %>" data-search-field="<%=searchField %>" date-search-word="<%=searchWord %>"
                        		data-sort-value="<%=sort %>" data-category-value="<%=category %>" style="cursor:pointer;">
														<td><%= nextboard.getId() %></td>
														<td><%= nextboard.getType() %></td>
														<td><%= nextboard.getTitle().length() > 10 ? nextboard.getTitle().substring(0, 10) + "..." : nextboard.getTitle() %></td>
														<td><%= nicklist %></td>
														<td><%= nextboard.getDate() %></td>
														<td><%= nextboard.getViews() %></td>
														<td><%= nextboard.getLike_count() %></td>
													</tr>
												<% 
													}%>
<!-- 												현 게시글 -->
													<tr class="currenboardList">
						                <td><%= board.getId() %></td>
						                <td><%= board.getType() %></td>
						                <td><%= board.getTitle().length() > 10 ? board.getTitle().substring(0, 10) + "..." : board.getTitle() %></td>
						                <td><%= nick %></td>
						                <td><%= board.getDate() %></td>
						                <td><%= board.getViews() %></td>
						                <td><%= board.getLike_count() %></td>
							            </tr>
<!--                         이전 게시글  -->
                        <%
                        	for(BoardDTO previousboard : previousBoards){
                        		String account = previousboard.getUser_email();
														UserDAO dao = new UserDAO();
														String nicklist = dao.findNicknameByEmail(account);
														dao.close();
														
                        %>
                        	<tr data-board-id="<%= previousboard.getId() %>" data-search-field="<%=searchField %>" date-search-word="<%=searchWord %>"
                        		data-sort-value="<%=sort %>" data-category-value="<%=category %>"	style="cursor:pointer;">
														<td><%= previousboard.getId() %></td>
														<td><%= previousboard.getType() %></td>
														<td><%= previousboard.getTitle().length() > 10 ? previousboard.getTitle().substring(0, 10) + "..." : previousboard.getTitle() %></td>
														<td><%= nicklist %></td>
														<td><%= previousboard.getDate() %></td>
														<td><%= previousboard.getViews() %></td>
														<td><%= previousboard.getLike_count() %></td>
													</tr>
												<%}
                        }else if(notice != null){
                        	for(BoardDTO topboard : topBoards){
                        		String account = topboard.getUser_email();
														UserDAO dao = new UserDAO();
														String nicklist = dao.findNicknameByEmail(account);
														dao.close();
                        %>
                        	<tr data-board-id="<%= topboard.getId() %>" data-search-field="<%=searchField %>" date-search-word="<%=searchWord %>"
                        		data-sort-value="<%=sort %>" data-category-value="<%=category %>"	style="cursor:pointer;">
														<td><%= topboard.getId() %></td>
														<td><%= topboard.getType() %></td>
														<td><%= topboard.getTitle().length() > 10 ? topboard.getTitle().substring(0, 10) + "..." : topboard.getTitle() %></td>
														<td><%= nicklist %></td>
														<td><%= topboard.getDate() %></td>
														<td><%= topboard.getViews() %></td>
														<td><%= topboard.getLike_count() %></td>
													</tr>
                        <%}
                       	}%>
												
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
		<%@include file="/common/footer.jsp" %>
	</div>
	<script src="../resources/js/profileImage.js"></script>
	<script src="../resources/js/boardDetail.js"></script>
</body>
</html>