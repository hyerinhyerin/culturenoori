package listener;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletRequestEvent;
import jakarta.servlet.ServletRequestListener;

public class ListenerRequest implements ServletRequestListener {

	@Override
	public void requestDestroyed(ServletRequestEvent sre) {
		 ServletRequest request = sre.getServletRequest();
//	     System.out.println("[ListenerRequest.requestDestroyed] RequestId : " + request.getRequestId());
	}

	@Override
	public void requestInitialized(ServletRequestEvent sre) {
		 ServletRequest request = sre.getServletRequest();
//	     System.out.println("[ListenerRequest.requestInitialized] RequestId : " + request.getRequestId());
	}

}
