<%@page import="common.LoginManager"%>
<%@page import="dao.UserDAO"%>
<%@page import="dto.UserDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getMethod().equalsIgnoreCase("post")){
		String uploadPath = application.getRealPath("/resources/image/profileImage");
		File uploadDir = new File(uploadPath);
		if(!uploadDir.exists()) uploadDir.mkdir(); //경로 없으면 만들어라
		
		MultipartRequest multi=null;
		
		try {
		    multi = new MultipartRequest(request, uploadPath, 10 * 1024 * 1024, "UTF-8");
		} catch (Exception e) {
		    e.printStackTrace(); // 예외 메시지 출력
		}
		
		String isDefaultImage = multi.getParameter("isDefaultImage");
		String nickname = multi.getParameter("username");
		String password = multi.getParameter("password");
		String email = multi.getParameter("email");
		String profileUpload = multi.getFilesystemName("profileUpload");
		
		
		System.out.println("[memberProc] profileUpload-"+profileUpload);
		System.out.println("[memberProc] isDefaultImage-"+isDefaultImage);
		System.out.println("Upload Path: " + uploadPath);

		UserDTO user = LoginManager.getUser(); //session info userdto
		UserDTO userdto = new UserDTO(); //dao update version userdto
		userdto.setNickname(nickname);
		userdto.setPassword(password);
		userdto.setEmail(email);
		
		String newFileName=null;
		
		if("true".equals(isDefaultImage)){
			String currentImagePath= user.getImg_path();
			System.out.println("[editmemberProc] currentImagePath- "+currentImagePath);
			if(currentImagePath != null && !currentImagePath.isEmpty()){
				File oldFile = new File(uploadPath+"/"+currentImagePath);
				if(oldFile.exists())
						oldFile.delete();
			}
			userdto.setImg_path(null);
			user.setImg_path(null);
		}else if(profileUpload != null){
			String fileExt = profileUpload.substring(profileUpload.lastIndexOf(".")); //확장자 추출
			
			newFileName = email+fileExt;
			
			File oldFile = new File(uploadPath + "/"+profileUpload);
			File newFile = new File(uploadPath + "/"+newFileName);
			
			if(user.getImg_path() != null){
				File beforeFile = new File(uploadPath + "/" + user.getImg_path());
				if(beforeFile.exists())
					beforeFile.delete();
			}

			oldFile.renameTo(newFile);
			
			System.out.println("[editmemberProc] newFileName-"+newFileName);
			
			userdto.setImg_path(newFileName);
			user.setImg_path(newFileName);
		}else{
			userdto.setImg_path(user.getImg_path());
		}
		
		UserDAO userdao = new UserDAO();
		boolean result = userdao.updateUser(userdto);
		
		userdao.close();
		
		//세션에 다시 유저 정보 저장?
		
		if(result){
			//변경 완료되면 세션 정보도 수정하기
			user.setNickname(nickname);
			user.setPassword(password);
			user.setEmail(email);
			
			LoginManager.updateUser(user);
			
			System.out.println("[editmemberProc] updateSuccess");
			response.sendRedirect("../member.jsp");
		}else{
			System.out.println("[editmemberProc] update failed");
			response.sendRedirect("../member.jsp");
		}
	}
%>