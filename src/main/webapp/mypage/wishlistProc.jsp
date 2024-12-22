<%@page import="dto.ViewPerformDTO"%>
<%@page import="dao.ViewPerformDAO"%>
<%@page import="dto.UserDTO"%>
<%@page import="common.LoginManager"%>
<%@page import="dao.PerformDetailDAO"%>
<%@page import="dao.PerformDAO"%>
<%@page import="dto.TheaterDTO"%>
<%@page import="dto.PerformDetailDTO"%>
<%@page import="dto.PerformDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.WishDAO"%>
<%@page import="dto.WishDTO"%>
<%@page import="common.JDBConnect"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.List"%>

<%

	JDBConnect jdbc = new JDBConnect();
	Connection conn = jdbc.conn;
	UserDTO user = LoginManager.getUser();
	
	String userEmail = user.getEmail();
	System.out.println("[wishlistProc] userEmail : " + userEmail);
	
	String detailId = request.getParameter("perform_detail_id");
	System.out.println("[wishlistProc] performId : " + detailId);

	String rootPath = request.getContextPath();
	System.out.println("[performDetail] rootPath : " + rootPath);
	
	boolean like = Boolean.parseBoolean(request.getParameter("like"));
	
	PerformDTO perform = null;
	PerformDetailDTO detail = null;

    try {
        // JDBConnect 클래스를 사용하여 데이터베이스 연결
        
        WishDAO wishDAO = new WishDAO(conn);
        WishDTO wishDTO = new WishDTO();
        wishDTO.setUser_email(userEmail);
        wishDTO.setPerform_detail_id(detailId);

        if (like) {
            // 좋아요 추가
            wishDAO.addWish(wishDTO);
            out.print("좋아요 추가 완료");
        } else {
            // 좋아요 제거
            wishDAO.removeWish(wishDTO);
            out.print("좋아요 제거 완료");
        }

        // 데이터베이스 연결 종료
        jdbc.close();
    } catch (SQLException e) {
        e.printStackTrace();
        out.print("오류 발생: " + e.getMessage());
    }
	
	//JSON 활용해보기 도전
	List<ViewPerformDTO> myWishList = null;
	{
		ViewPerformDAO dao_wish = new ViewPerformDAO();
		myWishList = dao_wish.getWishList(userEmail, rootPath);
		dao_wish.close();
// 		PerformDAO dao_wish = new PerformDAO();
// 		myWishList = dao_wish.getWishList(userEmail, rootPath);
// 		dao_wish.close();
	}
	
	JSONArray myWishListJson = new JSONArray();
	for(ViewPerformDTO dto : myWishList){
		myWishListJson.put(dto.toJSONObject());
	}
	
	System.out.println("myWishListJson : " + myWishListJson);

	//1개 값만 가져오기
    // request에서 user_email과 perform_id, 좋아요 여부(like)를 가져옴
    
// 	TheaterDTO theater = null;
	//wishlist 목록 표현하기 위해 perform과 detail dao를 가져옴
	
	// detail
// 	if(perform != null){
// 		PerformDetailDAO dao = new PerformDetailDAO();
// 		detail = dao.getDetail(detailId, rootPath);
// 		dao.close();
// 	}
	
// 	System.out.println("[performDetail] perform : " + perform.toString());
// 	System.out.println("[performDetail] detail : " + detail.toString());
	
// 	System.out.println("[performDetail] perform : " + perform.toJSONObject());
// 	System.out.println("[performDetail] detail : " + detail.toJSONObject());
	
// 	session.setAttribute("perform", perform);
// 	session.setAttribute("detail", detail);
// 	session.setAttribute("detailId", detailId);
	
// 	String storyImgPath = detail.getImg_path();
// 	System.err.println("[performDetail] storyImgPath~~ : " + storyImgPath);
// 	String[] array = storyImgPath.split(",");
// 	for(String img : array){
// 		System.err.println("[performDetail] array~~ : " + img);
// 		session.setAttribute("storyImgPath", img);
// 	}
%>
