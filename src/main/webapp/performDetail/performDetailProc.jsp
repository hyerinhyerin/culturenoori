<%@page import="org.json.JSONObject"%>
<%@page import="dao.TheaterDAO"%>
<%@page import="dao.PerformDetailDAO"%>
<%@page import="dao.PerformDAO"%>
<%@page import="dto.TheaterDTO"%>
<%@page import="dto.PerformDetailDTO"%>
<%@page import="dto.PerformDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String detailId = request.getParameter("id");
	System.out.println("[performDetail] detailId : " + detailId);

	String tab = request.getParameter("tab");
	System.out.println("[performDetail] tab : " + tab);


	String rootPath = request.getContextPath();
	System.out.println("[performDetail] rootPath : " + rootPath);
	
	String realPath = application.getRealPath("/");
	System.out.println("[performDetail] realPath : " + realPath);
	
	PerformDTO perform = null;
	PerformDetailDTO detail = null;
	TheaterDTO theater = null;
	float starRate = 0;
	
	// perform
	{
		PerformDAO dao = new PerformDAO();
		perform = dao.getPerform(detailId, rootPath, realPath); 
		dao.close();
	}
	// detail
	if(perform != null){
		PerformDetailDAO dao = new PerformDetailDAO();
		detail = dao.getDetail(detailId, rootPath, realPath); 
		starRate = dao.getAverageRateById(detailId);
		dao.close();
	}
	// theater
	if(detail != null){
		TheaterDAO dao = new TheaterDAO();
		theater = dao.getTheater(detail.getTheater_id());
		dao.close();
	}	

	System.out.println("[performDetail] perform : " + perform.toString());
	System.out.println("[performDetail] detail : " + detail.toString());
	System.out.println("[performDetail] theater : " + theater.toString());
	
	System.out.println("[performDetail] perform : " + perform.toJSONObject());
	System.out.println("[performDetail] detail : " + detail.toJSONObject());
	System.out.println("[performDetail] theater : " + theater.toJSONObject());
	
	System.out.println("[performDetail] getReservation_link : " + detail.getReservation_link());
	System.out.println("[performDetail] starRate : " + starRate);
	
	// 다른 jsp와의 공유를 위해 자바스크립트 글로벌 변수에 등록하기 위해 json만든다.
	JSONObject theaterJson = theater.toJSONObject();
	
	
	// 정리 필요
	// 세션 스토리지에 저장할까?
	session.setAttribute("perform", perform);
	session.setAttribute("detail", detail);
	session.setAttribute("theater", theater);
	session.setAttribute("detailId", detailId);
	
	session.setAttribute("theaterId", theater.getId());
	session.setAttribute("starRate", starRate);
	
	String storyImgPath = detail.getImg_path();
	System.err.println("[performDetail] storyImgPath~~ : " + storyImgPath);
	String[] array = storyImgPath.split(",");
	for(String img : array){
		System.err.println("[performDetail] array~~ : " + img);
		session.setAttribute("storyImgPath", img);
// 		session.setAttribute(arg0, arg1)
	}
	
// 	String storyImgPath = null;
// 		if(detail.getImg_path() == null){
// 			String img = null;
// 			storyImgPath = perform.getImg_path();
// 			session.setAttribute("storyImgPath", img);
// 		} else{
// 			storyImgPath = detail.getImg_path();
// 			System.err.println("[performDetail] storyImgPath~~ : " + storyImgPath);
// 			String[] array = storyImgPath.split(",");
// 			for(String img : array){
// 				System.err.println("[performDetail] array~~ : " + img);
// 				session.setAttribute("storyImgPath", img);
// 	//	 		session.setAttribute(arg0, arg1)
// 		}
// 	}
	
	// change tab
// 	tab;
	
%>
    