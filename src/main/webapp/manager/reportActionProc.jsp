<%@page import="dao.ReportDAO"%>
<%@page import="org.json.JSONObject"%>
<%@page import="dao.ReportActionDAO"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="dto.ReportActionDTO"%>
<%@page import="dto.ReportStates"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 신고된 항목들을 처리하는 프로세스이다.
	String reportId = request.getParameter("reportId");
	String reason = request.getParameter("reason");
	String states = request.getParameter("states");
	
	ReportStates reportStates = ReportStates.fromValue(states);
	int nReportId = Integer.parseInt(reportId);
	LocalDateTime date = LocalDateTime.now();
	
	ReportActionDTO dto = new ReportActionDTO();
	
	dto.setDate(date);
	dto.setReason(reason);
	dto.setReport_id(nReportId);
	dto.setStates(reportStates);
	
	// ReportAction 테이블에 등록
	ReportActionDAO dao = new ReportActionDAO();
	int resultAction = dao.addReportAction(dto);
	dao.close();
	
	boolean result = (0 < resultAction);
	
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("result", result);
	
	System.out.println("[reportProc] result : " + jsonObject.toString());

	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	response.getWriter().write(jsonObject.toString());
	
%>
















