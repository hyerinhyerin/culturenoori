<%@page import="org.json.JSONObject"%>
<%@page import="dao.BoardLikeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String boardIdStr = request.getParameter("boardId");
	String userEmail = request.getParameter("userEmail");
	int boardId = Integer.parseInt(boardIdStr);
	
	BoardLikeDAO dao = new BoardLikeDAO();
	
	boolean result=false;
	String action="";
	
// 이미 좋아요를 눌렀는지 확인
   if (dao.isClicked(boardId, userEmail)) {
       // 이미 좋아요를 눌렀다면 삭제
       result = dao.deleteBoardLike(boardId, userEmail);
       action = "unlike";
   } else {
       // 좋아요가 없으면 삽입
       result = dao.insertBoardLike(boardId, userEmail);
       action = "like";
   }
	
	dao.close();
	
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("result", result);
	jsonObject.put("action", action);
	
	System.out.println("[likeBoardProc] result : " + jsonObject.toString());

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	response.getWriter().write(jsonObject.toString());
%>