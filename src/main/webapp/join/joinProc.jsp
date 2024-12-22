<%@page import="dto.UserDTO"%>
<%@page import="dao.UserDAO"%>
<%@page import="utils.JSFunction"%>
<%@page import="common.LoginManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String new_user_emailCode = request.getParameter("emailCode");
	String savedEmailCode = LoginManager.getSession(session, LoginManager.EMAIL_CODE);
	if (!new_user_emailCode.trim().equals(savedEmailCode)) {
		JSFunction.alertBack("이메일 인증 코드가 일치하지 않습니다.", out);
	    return;
	}

    String idCheckResult = request.getParameter("idCheckResult");
	if ("0".equals(idCheckResult)) {
		JSFunction.alertBack("아이디 중복 확인을 해주세요.", out);
        return;
    }

	String new_user_password1 = request.getParameter("passwd1");
	String new_user_password2 = request.getParameter("passwd2");
	
// 	if (!new_user_password1.equals(new_user_password2)) {
// 		JSFunction.alertBack("비밀번호가 일치하지 않습니다.", out);
// 	    return;
// 	}
	
	String new_user_email = request.getParameter("email");
	String new_user_nick = request.getParameter("nick");
    
	UserDTO dto = new UserDTO();
	UserDAO dao = new UserDAO();
	
	dto.setNickname(new_user_nick);
	dto.setEmail(new_user_email);
	dto.setPassword(new_user_password1);
	
	int result = dao.insertUser(dto);
	dao.close();
	
		
	if(result == 1){
		String redirectUrl = request.getParameter("redirect");
		if(redirectUrl != null){
			JSFunction.alertLocation("회원가입이 완료되었습니다.", "../login/login.jsp?redirect="+redirectUrl, out);
		}else{
			JSFunction.alertLocation("회원가입이 완료되었습니다.", "../login/login.jsp", out);
		}
	}else{
		JSFunction.alertBack("회원가입 중 오류가 발생했습니다.", out);
	}

%>








