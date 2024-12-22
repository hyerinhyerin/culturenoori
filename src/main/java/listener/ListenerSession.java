package listener;

import jakarta.servlet.ServletRequest;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

public class ListenerSession implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		String session = se.toString();
	    System.out.println("[ListenerSession.sessionCreated] session : " + session);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		String session = se.toString();
	    System.out.println("[ListenerSession.sessionDestroyed] session : " + session);
	}
	
	

}
