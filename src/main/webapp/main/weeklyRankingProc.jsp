<%@page import="dto.PerformCardDTO"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="dto.PerformDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.PerformDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String rootPath = request.getContextPath();
    System.out.println("[weeklyRankingProc] rootPath : " + rootPath);

    String realPath = application.getRealPath("/");
    System.out.println("[weeklyRankingProc] realPath : " + realPath);

    List<PerformCardDTO> weeklyRankList = null;
    {
    	PerformDAO dao_weekly = new PerformDAO();
    	weeklyRankList = dao_weekly.getWeeklyRankList(rootPath, realPath); 
    	dao_weekly.close();
    }

    JSONArray weeklyRankListJson = new JSONArray();
    for (PerformCardDTO dto : weeklyRankList) {
    	weeklyRankListJson.put(dto.toJson());
    }

    System.out.println("weeklyRankListJson : " + weeklyRankListJson);
    %>    