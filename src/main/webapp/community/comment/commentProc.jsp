<%@page import="dto.UserDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.UserDAO"%>
<%@page import="dto.CommentDTO"%>
<%@page import="dao.CommentDAO"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userEmail = request.getParameter("userEmail");
	String commentText = request.getParameter("commentText");
	String boardIdstr = request.getParameter("boardId");
	
	if (boardIdstr == null || boardIdstr.isEmpty()) {
	    // boardId가 null이거나 비어 있을 경우 처리
	    System.out.println("[commentProc] boardId 값이 null이거나 비어있습니다.");
	    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "boardId 값이 잘못되었습니다.");
	    return;
	}

	int boardId;
	try {
	    boardId = Integer.parseInt(boardIdstr);
	} catch (NumberFormatException e) {
	    System.out.println("[commentProc] boardId 변환 중 오류 발생: " + e.getMessage());
	    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 boardId 값입니다.");
	    return;
	}
	
	System.out.println("[commentProc] userEmail : " + userEmail + " commentText : "+commentText + " boardId: "+boardIdstr);

	
	CommentDAO commentDao = new CommentDAO();
	CommentDTO comment = new CommentDTO();
	
	comment.setUserEmail(userEmail);
	comment.setContent(commentText);
	comment.setBoardId(boardId);
	
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
  String date = formatter.format(new Date());
	
	boolean result = commentDao.insertComment(comment);
	int commentId = comment.getId();
	
	System.out.println("[commentProc] commentId : " + commentId);

	commentDao.close();
	
	JSONObject jsonObject = new JSONObject();
	if(result){
		UserDAO userdao = new UserDAO();
		UserDTO user = userdao.getUserByEmail(userEmail);
		userdao.close();
	
		// TODO:JHK 프로필SVG - 댓글 추가 1 -> boardDetail.js
		// : request.getContextPath()+"/resources/image/comment_profile.png";
		String imgPath = user.getImg_path() != null ? 
				request.getContextPath()+"/resources/image/profileImage/"+user.getImg_path() :"";

		jsonObject.put("success", true);
		jsonObject.put("nickname", user.getNickname());
		jsonObject.put("useremail",userEmail);
		jsonObject.put("comment", commentText);
		jsonObject.put("date", date);
		jsonObject.put("id", commentId);
		jsonObject.put("imgpath", imgPath);
	}else{
		jsonObject.put("success", false);
	}
	
	System.out.println("[commentProc] result : " + result);

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	response.getWriter().write(jsonObject.toString());
%>