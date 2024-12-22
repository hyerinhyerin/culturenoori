<%@page import="dto.ReportView"%>
<%@page import="org.json.JSONArray"%>
<%@page import="dao.ReportDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.ReportDTO"%>
<%@page import="java.util.List"%>
<%@page import="org.json.JSONObject"%>
<%@page import="common.LoginManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 	신고된 리스트를 얻어 오는 프로세스이다.
// 	신고자 닉네임, 신고된 아이템의 작성자 닉네임을 가공하여, ReportVIEW에 담아 받음
	
	int result = 0; 
	List<ReportView> reportViews = null; 

	boolean isAdmin = LoginManager.isAdmin(session);
	System.out.println("[reportListProc] isAdmin : " + isAdmin);
	
	if(isAdmin){

		ReportDAO dao = new ReportDAO();
		reportViews = dao.getAllReportViwes();
		dao.close();
		
		// FIXME:JHK - jsonArray 사용하지 않고 있는데, 버그 없음?
// 		JSONArray jsonArray = new JSONArray();
// 		for (ReportVIEW reportView : reportViews) {
// 		    jsonArray.put(reportView.toJson());
// 		} 
	
		result = reportViews.size();
	}
	
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("result", result);
	jsonObject.put("reportViews", reportViews);
	
	System.out.println("[reportListProc] result : " + jsonObject.toString());

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	response.getWriter().write(jsonObject.toString());
%>

















