<%@page import="org.json.JSONObject"%>
<%@page import="tool.DBLoaderFromKOPIS"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String detailId = request.getParameter("id");
	
	DBLoaderFromKOPIS loader = DBLoaderFromKOPIS.getInstance();
	
	JSONObject jsonResult = loader.getJsonDetailFromKOPIS(detailId);
	
    // 응답의 Content-Type을 JSON으로 설정
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    // JSON 객체를 응답으로 출력
    response.getWriter().write(jsonResult.toString());
%>