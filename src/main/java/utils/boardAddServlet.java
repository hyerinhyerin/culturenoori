package utils;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import common.CNPath;
import dao.BoardDAO;
import dao.NoticeDAO;
import dto.BoardDTO;
import dto.NoticeDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/boardAddServlet")
@MultipartConfig
public class boardAddServlet extends HttpServlet{
	private static final String UPLOAD_DIR = CNPath.IMG_ROOT + "boardImage";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		//user form data
		String title = request.getParameter("boardTitle");
        String category = request.getParameter("boardCategory");
        String content = request.getParameter("contentText");
        String account = request.getParameter("account");
        String boardId = request.getParameter("boardId");
        String noticeId = request.getParameter("noticeId");
        String noticPriority = request.getParameter("noticPriority");
		
		List<String> fileNames = new ArrayList<>(); //파일명 받을 리스트
		String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
		
		File uploadDir = new File(uploadPath);
		if(!uploadDir.exists()) {
			uploadDir.mkdirs();
		}
		
		for(Part part : request.getParts()) {
			String fileName = getFileName(part); //하단에 작성
			if(fileName != null && !fileName.isEmpty()) {
				
				String fileExt = fileName.substring(fileName.lastIndexOf("."));
				String newFileName = UUID.randomUUID().toString()+fileExt;
				
				part.write(uploadPath+ File.separator + newFileName);
				fileNames.add(newFileName);
			}
		}
		String allFileNames = String.join(",", fileNames); //쉼표로 구분해서 문자형으로 저장함
		
		java.util.Date utilDate = new java.util.Date();
        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
        
        //notice, board process
        if ("공지사항".equals(category)) {
            // 공지사항 처리
            NoticeDAO noticeDAO = new NoticeDAO();
            NoticeDTO noticeDTO = new NoticeDTO();
            noticeDTO.setTitle(title);
            noticeDTO.setDate(sqlDate);
            noticeDTO.setContents(content);
            noticeDTO.setPriority(Integer.parseInt(noticPriority));

            if (noticeId == null || noticeId.isEmpty()) {
                // 공지사항 등록
                int result = noticeDAO.insertNotice(noticeDTO);
                if (result > 0) {
                    response.sendRedirect(request.getContextPath() + "/community/boardList.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/community/boardList.jsp");
                }
            } else {
                // 공지사항 수정
                noticeDTO.setId(Integer.parseInt(noticeId));
                boolean result = noticeDAO.updateNotice(noticeDTO);
                if (result) {
                    response.sendRedirect(request.getContextPath() + "/community/boardDetail.jsp?noticeId=" + noticeId + "&sort=lastest&category=all&searchField=title&searchWord=");
          	      	System.out.println("NoticeUpdate success!!");

                } else {
                    response.sendRedirect(request.getContextPath() + "/community/boardAdd.jsp?noticeId=" + noticeId);
          	      	System.out.println("NoticeUpdate failed!!");
                }
            }
            noticeDAO.close();
        } else {
            // 일반 게시글 처리
            BoardDAO boardDAO = new BoardDAO();
            BoardDTO boardDTO = new BoardDTO();
            boardDTO.setTitle(title);
            boardDTO.setDate(sqlDate);
            boardDTO.setType(category);
            boardDTO.setContents(content);
            boardDTO.setUser_email(account);
            boardDTO.setImg_path(allFileNames);

            if (boardId == null || boardId.isEmpty()) {
                // 글 등록 (Insert)
                int result = boardDAO.insertBoard(boardDTO);
                if (result > 0) {
                    // 파일 처리 후 DB 업데이트
//                    boardDTO.setId(result);
//                    boardDTO.setImg_path(allFileNames); // 파일 이름을 DB에 저장
//                    boardDAO.updateBoard(boardDTO);
                    response.sendRedirect(request.getContextPath() + "/community/boardList.jsp");
            		System.out.println("BoardAdd success!!");

                } else {
                    response.sendRedirect(request.getContextPath() + "/community/boardList.jsp");
            		System.out.println("BoardAdd failed!!");
                }
            } else {
                // 글 수정 (Update)
                int id = Integer.parseInt(boardId);
                boardDTO.setId(id);
                
                BoardDTO bimagedto = boardDAO.getBoardById(id);
                String existingImagePaths = bimagedto.getImg_path();
                
                if(existingImagePaths != null) {
                	String[] existingImages = existingImagePaths.split(",");
                	for (String imageName : existingImages) {
                        File fileToDelete = new File(getServletContext().getRealPath("") + "/" + UPLOAD_DIR + "/" + imageName);
                        if (fileToDelete.exists()) {
                            if (fileToDelete.delete()) {
                                System.out.println("Deleted file: " + imageName);
                            } else {
                                System.out.println("Failed to delete file: " + imageName);
                            }
                        }
                    }
                }
                
                boolean result = boardDAO.updateBoard(boardDTO);
                if (result) {
                    response.sendRedirect(request.getContextPath() + "/community/boardDetail.jsp?boardId=" + boardId + "&sort=lastest&category=all&searchField=title&searchWord=");
            		System.out.println("BoardUpdate success!!");
                } else {
                    response.sendRedirect(request.getContextPath() + "/community/boardAdd.jsp?boardId=" + boardId);
            		System.out.println("BoardUpdate failed!!");
                }
            }
            boardDAO.close();
        }
	}
	
	
	private String getFileName(Part part) {
		String contentDisposition = part.getHeader("content-disposition");
		//content-disposition 헤더 내용
		//form-data; name="file"; filename="example.txt"

		for(String token : contentDisposition.split(";")) {
			if(token.trim().startsWith("filename")) {
				return token.substring(token.indexOf('=')+2, token.length()-1);
				//filename=" 까지 자르고 마지막 "도 잘라서 파일명만 반환
			}
		}
		return null;
	}
	

}
