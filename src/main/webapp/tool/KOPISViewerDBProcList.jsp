<%@page import="dto.PerformDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.TheaterDAO"%>
<%@page import="dao.PerformDetailDAO"%>
<%@page import="dao.PerformDAO"%>
<%@page import="org.json.JSONObject"%>
<%@page import="tool.DBLoaderFromKOPIS"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String prfstate = request.getParameter("prfstate");
	String sortdate = request.getParameter("sortdate");
	String searchword = request.getParameter("searchword");
	String currentPage = request.getParameter("showPage");
	
	System.out.println("[KOPISViewerDBProcList] prfstate: " + prfstate);
	System.out.println("[KOPISViewerDBProcList] sortdate: " + sortdate);
	System.out.println("[KOPISViewerDBProcList] searchword: " + searchword);
	System.out.println("[KOPISViewerDBProcList] currentPage: " + currentPage);
	
	String rootPath = request.getContextPath();
	System.out.println("[KOPISViewerDBProcList] rootPath : " + rootPath);

    String realPath = application.getRealPath("/");
    System.out.println("[KOPISViewerDBProcList] realPath : " + realPath);

    
	PerformDAO perform = new PerformDAO();
	
	Object[] result = perform.getPerformList(searchword, prfstate, Integer.parseInt(currentPage), rootPath, realPath);

	 
	perform.close();
	
	JSONObject jsonResult = (JSONObject)result[0];
	JSONObject jsonData = (JSONObject)result[1];
	
	if(jsonResult.get("result") == "success"){
		System.out.println("[KOPISViewerDBProcList] jsonData success : " + jsonData.toString());
	}else{
		System.out.println("[KOPISViewerDBProcList] jsonData failed : " + jsonData.toString());
	}
	
	// 응답의 Content-Type을 JSON으로 설정
	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	
	// JSON 객체를 응답으로 출력
	response.getWriter().write(jsonData.toString());
    
%>
    