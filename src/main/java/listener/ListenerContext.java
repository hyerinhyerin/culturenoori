package listener;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;

public class ListenerContext implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		
		ServletContext context = sce.getServletContext();
		System.out.println("[ListenerContext.contextDestroyed] ~~Stop : ");
		System.out.println("[ListenerContext.contextDestroyed] ServletContextName : " + context.getServletContextName());

	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext context = sce.getServletContext();
		System.out.println("[ListenerContext.contextInitialized] Start~~ : ");
		System.out.println("[ListenerContext.contextInitialized] ServletContextName : " + context.getServletContextName());
		System.out.println("[ListenerContext.contextInitialized] RealPath : " + context.getRealPath(null));
	}

	
}
