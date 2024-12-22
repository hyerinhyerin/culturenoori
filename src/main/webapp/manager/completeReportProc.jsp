<%@page import="dto.ReportActionView"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="dao.ReportActionDAO"%>
<%@page import="common.LoginManager"%>
<%@page import="dto.ReportActionDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// [신고처리]된 리스트를 얻어오는 프로세스
	//
	int result = 0;
	List<ReportActionView> actionInfos = null;
	
	boolean isAdmin = LoginManager.isAdmin(session);
	System.out.println("[completeReportProc] isAdmin : " + isAdmin);
	
	if (isAdmin) {
	
		ReportActionDAO dao = new ReportActionDAO();
		actionInfos = dao.getAllReportActionInfos();
		dao.close();
	// FIXME:JHK - jsonArray 사용하지 않고 있는데, 버그 없음?
// 		JSONArray jsonArray = new JSONArray();
// 		for (ReportActionDTO action : actions) {
// 			jsonArray.put(action.toJson());
// 		}
	
		result = actionInfos.size();
	}
	
	
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("result", result);
	jsonObject.put("actionInfos", actionInfos);
	
	System.out.println("[completeReportProc] result : " + jsonObject.toString());

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	response.getWriter().write(jsonObject.toString());
%>
















