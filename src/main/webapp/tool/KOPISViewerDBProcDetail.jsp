<%@page import="dto.TheaterDTO"%>
<%@page import="dao.TheaterDAO"%>
<%@page import="dto.PerformDetailDTO"%>
<%@page import="dao.PerformDetailDAO"%>
<%@page import="dto.PerformDTO"%>
<%@page import="dao.PerformDAO"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String detailId = request.getParameter("id");

	System.out.println("[KOPISViewerDBProcDetail] detailId : " + detailId);
	
	String rootPath = request.getContextPath();
	System.out.println("[KOPISViewerDBProcList] rootPath : " + rootPath);

	String realPath = application.getRealPath("/");
	System.out.println("[KOPISViewerDBProcList] realPath : " + realPath);

	
	PerformDTO perform = null;
	PerformDetailDTO detail = null;
	TheaterDTO theater = null;
	
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
		dao.close();
	}
	
	// theater
	if(detail != null){
		TheaterDAO dao = new TheaterDAO();
		theater = dao.getTheater(detail.getTheater_id());
		dao.close();
	}	

	JSONObject jsonRoot = new JSONObject();
	JSONObject jsonResult = new JSONObject();
	
	if(perform != null && detail != null && theater != null){
		
		System.out.println("[KOPISViewerDBProcDetail] perform : " + perform.toJSONObject());
		System.out.println("[KOPISViewerDBProcDetail] detail : " + detail.toJSONObject());
		System.out.println("[KOPISViewerDBProcDetail] theater : " + theater.toJSONObject());

		JSONObject jsonData = new JSONObject();

		jsonData.put("perform", perform.toJSONObject());
		jsonData.put("detail", detail.toJSONObject());
		jsonData.put("theater", theater.toJSONObject());
		
		jsonRoot.put("jsonData", jsonData);

		jsonResult.put("result", "success");
	}else{
		jsonResult.put("result", "failed");
	}

	jsonRoot.put("jsonResult", jsonResult);

	// 응답의 Content-Type을 JSON으로 설정
	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	// JSON 객체를 응답으로 출력
	response.getWriter().write(jsonRoot.toString());
	
	
%>