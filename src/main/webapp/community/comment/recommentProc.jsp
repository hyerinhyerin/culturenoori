<%@page import="dto.UserDTO"%>
<%@page import="dao.UserDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.apache.tomcat.jakartaee.commons.compress.archivers.zip.UnicodeCommentExtraField"%>
<%@page import="dto.CommentDTO"%>
<%@page import="dao.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userEmail = request.getParameter("userEmail");
	String boardIdStr = request.getParameter("boardId");
	String parentIdStr = request.getParameter("parentCommentId");
	String content = request.getParameter("content");
	
	System.out.println("parentid-"+parentIdStr+" boardId-"+boardIdStr+" useremail-"+userEmail+" content-"+content);
	
	int parentId = Integer.parseInt(parentIdStr);
	int boardId = Integer.parseInt(boardIdStr);
	
	CommentDAO commentdao = new CommentDAO();
	CommentDTO commentdto = new CommentDTO();
	
	commentdto.setUserEmail(userEmail);
	commentdto.setContent(content);
	commentdto.setParentCommentId(parentId);
	commentdto.setBoardId(boardId);
	
	boolean result = commentdao.insertRecomment(commentdto);
	String parentNick = commentdao.getParentCommentNickname(parentId);
	int recommentId = commentdto.getId();
	commentdao.close();
	
	JSONObject jsonObject = new JSONObject();
	if(result){
		UserDAO userdao = new UserDAO();
		UserDTO user = userdao.getUserByEmail(userEmail);
		userdao.close();
		
		// TODO:JHK 프로필SVG - 답글 추가 1 -> boardDetail.js
		// : request.getContextPath()+"/resources/image/comment_profile.png";
		String imgPath = user.getImg_path() != null ? 
				request.getContextPath()+"/resources/image/profileImage/"+user.getImg_path() : "";
		
		jsonObject.put("success",true);
		jsonObject.put("nickname",user.getNickname());
		jsonObject.put("id",recommentId);
		jsonObject.put("date",new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		jsonObject.put("userEmail", userEmail);
		jsonObject.put("imgpath", imgPath);
		jsonObject.put("parentNick", parentNick);
		
		
	}else{
		jsonObject.put("success",false);
	}
	
	response.setContentType("application/json");
  response.setCharacterEncoding("UTF-8");
  response.getWriter().write(jsonObject.toString());
%>