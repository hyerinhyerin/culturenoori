<%@page import="dto.UserDTO"%>
<%@page import="common.LoginManager"%>
<%@page import="org.json.JSONObject"%>
<%@page import="dao.ReportDAO"%>
<%@page import="dto.ReportDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="dto.ReportType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 신고한 대상 아이템을 등록하는 프로세스이다
	
	String reason = request.getParameter("reason");	
	String type = request.getParameter("type");
	String reportedId = request.getParameter("reportedId");
	String userEmail = request.getParameter("userEmail");
	LocalDateTime date = LocalDateTime.now();
	
	if(userEmail == null || userEmail.isEmpty()){
		UserDTO user = LoginManager.getUser();
		if(user == null){
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("result", 0);

			System.out.println("[reportProc] result : " + jsonObject.toString());

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jsonObject.toString());
			return;
		}
		
		userEmail = user.getEmail();
	}
	

	System.out.println("[reportProc] reason : " + reason);
	System.out.println("[reportProc] type : " + type);
	System.out.println("[reportProc] reportedId : " + reportedId);
	System.out.println("[reportProc] userEmail : " + userEmail);
	System.out.println("[reportProc] date : " + date);
	
	ReportType reportType = ReportType.fromValue(type);
	int nReportedId = Integer.parseInt(reportedId);
	
	ReportDTO report = new ReportDTO();
	
	report.setDate(date);
	report.setReason(reason);
	report.setType(reportType);
	report.setReportedId(nReportedId);
	report.setUserEmail(userEmail);
	
	ReportDAO dao = new ReportDAO();
	int result = dao.addReport(report);
	dao.close();
	
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("result", result);
	
	System.out.println("[reportProc] result : " + jsonObject.toString());

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	response.getWriter().write(jsonObject.toString());
%>











