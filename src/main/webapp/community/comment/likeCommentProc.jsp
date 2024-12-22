<%@page import="org.json.JSONObject"%>
<%@page import="dto.CommentLikeDTO"%>
<%@page import="dao.CommentLikeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String commentIdStr = request.getParameter("commentId");
	String userEmail = request.getParameter("userEmail");
	
	JSONObject jsonResponse = new JSONObject();
	
	
	if(commentIdStr != null && userEmail != null){
		int commentId = Integer.parseInt(commentIdStr);
		CommentLikeDAO likedao = new CommentLikeDAO();
		CommentLikeDTO likedto = new CommentLikeDTO();
		
		likedto.setCommentId(commentId);
		likedto.setUserEmail(userEmail);
		
		boolean isLiked = likedao.isLiked(commentId, userEmail);
		
		if(isLiked){
			boolean result = likedao.deleteLike(likedto);
			jsonResponse.put("result", true);
			jsonResponse.put("action", "unlike");
			
			System.out.println("[likeCommentProc] unlike : " + result);

		}else{
			boolean result = likedao.insertLike(likedto);
			jsonResponse.put("result", true);
			jsonResponse.put("action", "like");
			
			System.out.println("[likeCommentProc] like : " + result);

		}
		likedao.close();
	}else{
		jsonResponse.put("result", false);
	}
	
	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	response.getWriter().write(jsonResponse.toString());

%>