<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="dto.PerformDTO"%>

<%!
// 연도 및 월 설정 함수
public Calendar setCalendar(String strYear, String strMonth) {
    int year, month;
    Calendar cal = Calendar.getInstance();

    if (strYear != null && strMonth != null) {
        year = Integer.parseInt(strYear);
        month = Integer.parseInt(strMonth);
    } else {
        year = cal.get(Calendar.YEAR);
        month = cal.get(Calendar.MONTH) + 1;
    }

    cal.set(year, month - 1, 1);
    return cal;
}

// 달력 HTML 생성 함수
public String generateCalendarHtml(int startDay, int lastDay, Map<Integer, List<PerformDTO>> dayInPerformList) {
    StringBuilder calendarHtml = new StringBuilder();
    calendarHtml.append("<table class='table table-bordered w-100'>");
    calendarHtml.append(
        "<thead class='thead-dark'><tr><th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th></tr></thead>");
    calendarHtml.append("<tbody><tr>");

    for (int i = 1; i < startDay; i++) {
        calendarHtml.append("<td></td>");
    }

    for (int day = 1; day <= lastDay; day++) {
        List<PerformDTO> performs = dayInPerformList.get(day);
        boolean hasPerform = performs != null && !performs.isEmpty();
        String tdClass = hasPerform ? " class='perform-day'" : "";
        calendarHtml.append("<td id='day-" + day + "'" + tdClass + " onclick='showDetails(" + day + ")'>");
        calendarHtml.append(day);

        if (hasPerform) {
            calendarHtml.append("<div class='event-indicator'>•</div>");
        }

        calendarHtml.append("</td>");

        if ((startDay + day - 1) % 7 == 0) {
            calendarHtml.append("</tr><tr>");
        }
    }

    calendarHtml.append("</tr></tbody>");
    calendarHtml.append("</table>");

    return calendarHtml.toString();
}

// 공연 정보를 JSON으로 변환하는 함수
public JSONObject generatePerformListJson(Map<Integer, List<PerformDTO>> dayInPerformList) {
    JSONObject dailyPerformList = new JSONObject();

    for (Map.Entry<Integer, List<PerformDTO>> entry : dayInPerformList.entrySet()) {
        JSONArray performArray = new JSONArray();
        for (PerformDTO dto : entry.getValue()) {
            JSONObject performInfo = new JSONObject();
            performInfo.put("name", dto.getName());
            performInfo.put("detailId", dto.getPerform_Detail_id());
            performArray.put(performInfo);
        }
        dailyPerformList.put(String.valueOf(entry.getKey()), performArray);
    }

    return dailyPerformList;
}
%>
