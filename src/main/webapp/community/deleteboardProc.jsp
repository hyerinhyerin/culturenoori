<%@page import="java.io.IOException"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.io.File"%>
<%@page import="dto.BoardDTO"%>
<%@page import="dao.NoticeDAO"%>
<%@page import="org.json.JSONObject"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String idStr = request.getParameter("id");
	String isNoticeStr = request.getParameter("isNotice");
	
	boolean isNotice = Boolean.parseBoolean(isNoticeStr);
	boolean result = false;
	
	if (idStr != null) {
	  int id = Integer.parseInt(idStr);
		String imgPaths = null;
	  
	  if (isNotice) {
	    // 공지사항 삭제 처리
	    NoticeDAO noticeDAO = new NoticeDAO();
	    result = noticeDAO.deleteNotice(id); // 공지사항 삭제 메서드 호출
	    noticeDAO.close();
	  } else {
	    // 게시글 삭제 처리
	    BoardDAO boardDAO = new BoardDAO();
	    BoardDTO boardImgdto = boardDAO.getBoardById(id);
	    imgPaths = boardImgdto.getImg_path();
	    result = boardDAO.deleteBoard(id); // 게시글 삭제 메서드 호출
	    boardDAO.close();
	  }
	  
	  //image delete
	  if(imgPaths != null && !imgPaths.isEmpty()){
		  String[] imgArray = imgPaths.split(",");
		  for(String imgName : imgArray){
			  String filePath = getServletContext().getRealPath("") + "/resources/image/boardImage/"+imgName.trim();
			  File fileTodelete = new File(filePath);
			  if(fileTodelete.exists()){
				  try{
					  Files.delete(fileTodelete.toPath());
					  System.out.println("Deleted image: " + fileTodelete.getAbsolutePath());
				  }catch(IOException e){
					  e.printStackTrace();
				  }
			  }
		  }
	  }
	}
  
  JSONObject jsonObject = new JSONObject();
	jsonObject.put("result", result);
	
	System.out.println("[deleteboard] result : " + jsonObject.toString());

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	response.getWriter().write(jsonObject.toString());
%>