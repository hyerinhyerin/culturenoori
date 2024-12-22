<%@page import="dao.UserDAO"%>
<%@page import="org.json.JSONObject"%>
<%@page import="utils.EmailSender"%>
<%@page import="common.LoginManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, javax.mail.*, javax.mail.internet.*" %>
<%
	String account = request.getParameter("account");

	UserDAO dao = new UserDAO();
	//있는 계정인지 먼저 확인
	Object[] isUser = dao.checkAccount(account);
	JSONObject userJson = (JSONObject)isUser[0];
	
	String accountStatus = userJson.getString("result");
	
	boolean emailResult=false;  //인증번호 전송 유무
	boolean accountResult = false; //계정 유무

	if("already".equals(accountStatus)){
		accountResult = true;
		//들어온 계정이 이메일인지 확인
		boolean isEmail = LoginManager.isEmail(account);
		//이메일이라면 바로 인증번호 전송 단계로
		if(isEmail){
			emailResult = (new EmailSender().send(session, account));
		}else{
			String user_email = dao.findEmailByNickname(account);
			System.out.println("user_email by nickname: " + user_email);
			emailResult = (new EmailSender().send(session, user_email));
		}
	}else{
		System.out.println("[login>sendEmailProc] 계정 없음");
	}

	dao.close();

	
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("accountResult", accountResult);
	jsonObject.put("emailResult", emailResult);
	
	
	System.out.println("[sendEmailProc] result : " + jsonObject.toString());
	
    // 응답의 Content-Type을 JSON으로 설정
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    // JSON 객체를 응답으로 출력
    response.getWriter().write(jsonObject.toString());
    
%>
