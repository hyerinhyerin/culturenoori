<%@page import="org.json.JSONObject"%>
<%@page import="dto.PerformDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="dao.PerformDAO"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>

<%@ include file="./calendarUtils.jsp"%>

<%
String strYear = request.getParameter("year");
String strMonth = request.getParameter("month");

Calendar cal = setCalendar(strYear, strMonth);

int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH) + 1;
int startDay = cal.get(Calendar.DAY_OF_WEEK);
int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

System.out.println("[calendarProcChangeMonth] year : " + year);
System.out.println("[calendarProcChangeMonth] month : " + month);



// model과 통신
PerformDAO dao = new PerformDAO();
Map<Integer, List<PerformDTO>> dayInPerformList = dao.getListinMonth(year, month);
dao.close();


//달력 HTML 생성
String calendarHtml = generateCalendarHtml(startDay, lastDay, dayInPerformList);

//공연 정보를 JSON으로 변환
JSONObject dailyPerformList = generatePerformListJson(dayInPerformList);



// JSON 응답 생성
JSONObject jsonResponse = new JSONObject();

jsonResponse.put("year", year);
jsonResponse.put("month", month);
jsonResponse.put("calendarHtml", calendarHtml);
jsonResponse.put("dailyPerformList", dailyPerformList);

// 응답의 Content-Type을 JSON으로 설정
// JSON 객체를 응답으로 출력
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write(jsonResponse.toString());


%>















