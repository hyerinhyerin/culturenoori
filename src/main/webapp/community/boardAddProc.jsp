<%@page import="java.io.IOException"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="dto.NoticeDTO"%>
<%@page import="dao.NoticeDAO"%>
<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@page import="common.LoginManager"%>
<%@page import="dao.UserDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
boolean isAdmin = LoginManager.isAdmin(session);
  
  
  //이미지 처리 경로
  String uploadPath = application.getRealPath("/resources/image/boardImage");
  File uploadDir = new File(uploadPath);
  if(!uploadDir.exists()){
	  uploadDir.mkdirs();
  }
  int maxPostSize = 10*1024*1024; //10MB
  
  MultipartRequest multi = new MultipartRequest(request, uploadPath, maxPostSize, "UTF-8", new DefaultFileRenamePolicy());

  
  String title = multi.getParameter("boardTitle");
  String category = multi.getParameter("boardCategory");
  String content = multi.getParameter("contentText");
  String account = multi.getParameter("account");
  String boardId = multi.getParameter("boardId");
  String noticeId = multi.getParameter("noticeId");
  String noticPriority = multi.getParameter("noticPriority");

   // 값 확인 (콘솔에 출력)
   System.out.println("title - " + title);
   System.out.println("category - " + category);
   System.out.println("content - " + content);
   System.out.println("account - " + account);
    


	// 현재 날짜
	java.util.Date utilDate = new java.util.Date();
	java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime()); // java.util.Date를 java.sql.Date로 변환




		
	if(category.equals("공지사항")){
		NoticeDAO noticedao = new NoticeDAO();
		NoticeDTO noticedto = new NoticeDTO();
		
		noticedto.setTitle(title);
		noticedto.setDate(sqlDate);
		noticedto.setContents(content);
		noticedto.setPriority(Integer.parseInt(noticPriority));
		
		if(noticeId == null || noticeId.isEmpty()){
			int result = noticedao.insertNotice(noticedto);
			if(result > 0){
				response.sendRedirect("./boardList.jsp");
				System.out.println("NoticeAdd success!!");
      } else {
         response.sendRedirect("./boardList.jsp");
         System.out.println("NoticeAdd failed");
      }
		}else{
	//공지사항 수정
			noticedto.setId(Integer.parseInt(noticeId));
			boolean result = noticedao.updateNotice(noticedto);
			if(result){
				response.sendRedirect("boardDetail.jsp?noticeId=" + noticeId+"&sort=lastest&category=all&searchField=title&searchWord="); // 수정 후 상세 페이지로 이동
	      System.out.println("NoticeUpdate success!!");
			}else{
         response.sendRedirect("boardAdd.jsp?noticeId=" + noticeId); // 수정 실패 시 글 수정 페이지로 이동
         System.out.println("NoticeUpdate failed");
      }
		}
		noticedao.close();
	}else{
		//유저 글 관리
		BoardDAO boarddao = new BoardDAO();
	  BoardDTO boarddto = new BoardDTO();
	  
	  boarddto.setTitle(title);
	  boarddto.setDate(sqlDate);
	  boarddto.setType(category);
	  boarddto.setContents(content);
	  boarddto.setUser_email(account);
// 	  boarddto.setImg_path(imgFiles.toString());
	  
	  if (boardId == null || boardId.isEmpty()) {
	    // 글 등록 (Insert)
	    int result = boarddao.insertBoard(boarddto);
			// 결과에 따른 처리
			if (result > 0) {
				int newboardId = result;
				String boardFolder = "board"+newboardId;
				String newuploadPath = uploadPath+File.separator+boardFolder;
				
		
				File newUploadDir = new File(newuploadPath);
				if (!newUploadDir.exists()) {
			    if (newUploadDir.mkdirs()) {
				        System.out.println("Directory created: " + newUploadDir.getAbsolutePath());
			    } else {
				        System.out.println("Failed to create directory: " + newUploadDir.getAbsolutePath());
			    }
				}

		System.out.println("New upload path: " + newuploadPath);
// 				MultipartRequest multiUpload= new MultipartRequest(request, newuploadPath, maxPostSize, "UTF-8", new DefaultFileRenamePolicy());
		Enumeration<?> files = multi.getFileNames();
//			 	System.out.println("Number of files uploaded: " + Collections.list(files).size());
// 				files = multi.getFileNames();

					System.out.println("files - "+files);
					System.out.println("filename - "+multi.getFilesystemName("contentImage[]"));

		int filecount = 0;
		while(files.hasMoreElements()){
			String contentImage = (String)files.nextElement();
			System.out.println("contentImage - "+contentImage);
			String fileName = multi.getFilesystemName(contentImage);
			System.out.println("fileName - "+ fileName);
			
			if (fileName != null) {
				File uploadedFile = new File(newuploadPath, fileName); //고유 번호 폴더로
				File originalFile = multi.getFile(contentImage); //서버에 임시로 저장되어 있던 위치

				if (originalFile != null && originalFile.renameTo(uploadedFile)) {
					System.out.println("File saved to :" + uploadedFile.getAbsolutePath());
					filecount++;
				} else {
					System.out.println("Failed to save file: " + fileName);
				}

				System.out.println("uploaded File: " + fileName);
			} else {
				System.out.println("no file uploaded: " + contentImage);
			}
		}
		System.out.println("Number of files uploaded: " + filecount);

		//db 이미지 필드 경로 업데이트
		boarddto.setId(result);
		boarddto.setImg_path(boardFolder);
		boarddao.updateBoard(boarddto);

		response.sendRedirect("./boardList.jsp");
		System.out.println("BoardAdd success!!");
	} else {
		response.sendRedirect("./boardList.jsp");
		System.out.println("BoardAdd failed");
	}
		} else {
	// 글 수정 (Update)
	int id = Integer.parseInt(boardId);
	boarddto.setId(id);
	boolean result = boarddao.updateBoard(boarddto);
	if (result) {
		response.sendRedirect("boardDetail.jsp?boardId=" + boardId
				+ "&sort=lastest&category=all&searchField=title&searchWord="); // 수정 후 상세 페이지로 이동
		System.out.println("BoardUpdate success!!");
	} else {
		response.sendRedirect("boardAdd.jsp?boardId=" + boardId); // 수정 후 상세 페이지로 이동
		System.out.println("BoardUpdate failed");
	}
	boarddao.close();
		}
	}
%>
