<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.XML"%>
<%@page import="tool.DBLoaderFromKOPIS"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String param_startday = request.getParameter("startday");
String param_endday = request.getParameter("endday");
String cpage = request.getParameter("page");
String rows = request.getParameter("numOfpage");
String param_shcate = request.getParameter("shcate");

SimpleDateFormat fmtOri = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmtTarget = new SimpleDateFormat("yyyyMMdd");

String stdate = fmtTarget.format(fmtOri.parse(param_startday));
String eddate = fmtTarget.format(fmtOri.parse(param_endday));

String uri = "&stdate=" + stdate + "&eddate=" + eddate + "&shcate=" + param_shcate + "&rows=" + rows + "&cpage="
		+ cpage;

DBLoaderFromKOPIS loader = DBLoaderFromKOPIS.getInstance();

JSONObject jsonResult = loader.getJsonPerformListFromKOPIS(uri);

JSONArray db = jsonResult.getJSONObject("dbs").getJSONArray("db");

System.out.println("[KOPISViewerAPIProcList] jsonResult length : " + db.length());

// 응답의 Content-Type을 JSON으로 설정
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

// JSON 객체를 응답으로 출력
response.getWriter().write(jsonResult.toString());
%>










