<%@page import="org.json.JSONObject"%>
<%@page import="tool.DBLoaderFromKOPIS"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	System.out.println("KOPISViewerAPIProcClearDB Entered~");

	DBLoaderFromKOPIS loader = DBLoaderFromKOPIS.getInstance();

	int result = loader.clearDB();
	
    
	System.out.println("clearDB result : " + result);
	
	JSONObject jsonResult = new JSONObject();
	jsonResult.put("result", result);
	
    // 응답의 Content-Type을 JSON으로 설정
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    // JSON 객체를 응답으로 출력
    response.getWriter().write(jsonResult.toString());
    
    
    
%>
    