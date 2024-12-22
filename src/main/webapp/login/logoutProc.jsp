<%@page import="common.LoginManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	LoginManager.logout(session);
	response.sendRedirect("../main.jsp");
%>    