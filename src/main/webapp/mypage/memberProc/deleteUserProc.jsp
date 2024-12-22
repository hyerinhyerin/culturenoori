<%@page import="java.io.File"%>
<%@page import="common.LoginManager"%>
<%@page import="dto.UserDTO"%>
<%@page import="org.json.JSONObject"%>
<%@page import="dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserDTO userdto = LoginManager.getUser();

// 	String email = request.getParameter("email");
	UserDAO userdao = new UserDAO();
		
	String uploadPath = application.getRealPath("/resources/image/profileImage");
	String imagePath =uploadPath + "/" + userdto.getImg_path();
	
	if(userdto.getImg_path() != null && !userdto.getImg_path().isEmpty()){
		File oldFile = new File(imagePath);
		if(oldFile.exists())
				oldFile.delete();
	}
	System.out.println("[deleteUserProc] userdto.getEmail() : " + userdto.getEmail());

	boolean result = userdao.deleteUserByEmail(userdto.getEmail());
	
	JSONObject jsonObject = new JSONObject();
	if(result){
		LoginManager.logout(session);
		jsonObject.put("result", "success");
	}else{
		jsonObject.put("result","failed");
	}
	
	userdao.close();
	System.out.println("[deleteUserProc] result : " + jsonObject.toString());

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	response.getWriter().write(jsonObject.toString());
%>