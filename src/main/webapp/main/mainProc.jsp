<%@page import="org.json.JSONObject"%>
<%@page import="dao.PerformDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String rootPath = request.getContextPath();
	System.out.println("[mainProc] rootPath : " + rootPath);

    String realPath = application.getRealPath("/");
    System.out.println("[mainProc] realPath : " + realPath);

	String perform_state 		= request.getParameter("perform_state");
 	String search_keyword 	= request.getParameter("search_keyword");
	String str_currentPage 	= request.getParameter("currentPage");
	
	int currentPage = (str_currentPage == null) ? 1 : Integer.parseInt(str_currentPage);

	System.out.println("[mainProc] perform_state : " + perform_state);
	System.out.println("[mainProc] search_keyword : " + search_keyword);
	System.out.println("[mainProc] currentPage : " + str_currentPage);
		
	PerformDAO perform = new PerformDAO();
	Object[] result = perform.getPerformList(search_keyword, perform_state, currentPage, rootPath, realPath);
	
	perform.close();
	
	JSONObject jsonResult = (JSONObject) result[0];
	JSONObject jsonData = (JSONObject) result[1];
	
	if (jsonResult.get("result") == "success") {
		System.out.println("[mainProc] jsonData success : " + jsonData.toString());
	} else {
		System.out.println("[mainProc] jsonData failed : " + jsonData.toString());
	}
	
	// 응답의 Content-Type을 JSON으로 설정
	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	
	// JSON 객체를 응답으로 출력
	response.getWriter().write(jsonData.toString());
%>




















