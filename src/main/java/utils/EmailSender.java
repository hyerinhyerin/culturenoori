package utils;

import java.util.Properties;
import java.util.UUID;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import common.LoginManager;
import jakarta.servlet.http.HttpSession;

public class EmailSender {
	
	private String host = "smtp.gmail.com";
	private String senderEmail = "ascent920@gmail.com";
	private String senderEmailAppPw = "kzkr jwyw dmpw sgnv"; // 비번 숨기기

    public boolean send(HttpSession httpSession, String new_user_email) {

    	// 세션 설정
	    Properties props = new Properties();

	    props.put("mail.smtp.host", host);
	    props.put("mail.smtp.auth", "true");
	    props.put("mail.smtp.port", "465");
	    props.put("mail.smtp.socketFactory.port", "465");
	    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

	    Session mail_session = Session.getInstance(props, new javax.mail.Authenticator() {
	        protected PasswordAuthentication getPasswordAuthentication() {
	            return new PasswordAuthentication(senderEmail, senderEmailAppPw);
	        }
	    });

	    // 이메일 메시지 작성
	    try {
	    	// 인증 코드 생성
	    	String emailCode = UUID.randomUUID().toString().substring(0, 6);
	    	
	        MimeMessage message = new MimeMessage(mail_session);
	        message.setFrom(new InternetAddress(senderEmail));
	        message.addRecipient(Message.RecipientType.TO, new InternetAddress(new_user_email));
	        
	        message.setSubject("이메일 인증 코드");
	        message.setText("인증 코드는 " + emailCode + " 입니다.");

	        // 이메일 전송
	        Transport.send(message);

	        // 세션에 저장
			LoginManager.addSession(httpSession, LoginManager.EMAIL_CODE, emailCode);
			
			return true;
	        
	    } catch (MessagingException e) {
	        e.printStackTrace();
	    }
	    
		return false;		
	}
}
