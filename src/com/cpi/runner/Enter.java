package com.cpi.runner;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cpi.entity.User;
import com.cpi.userservice.UserService;

public class Enter extends HttpServlet {

	private static final long serialVersionUID = 7133900998157275120L;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		String page = "";
		HttpSession session = request.getSession();
		//session.setAttribute("userId", request.getParameter("userId"));
		
		User user = new User();
		user.setUserId(request.getParameter("userId"));
		
		try {
			ApplicationContext applicationContext = new ClassPathXmlApplicationContext("/com/cpi/resources/applicationContext.xml");
			UserService userService = (UserService) applicationContext.getBean("userService");
			user = userService.enter(user);
			session.setAttribute("activeUser", user);
			
			if(user.getAccessLevel().equals("U")) {
				page = "UserUpdateProfilePage.jsp";
			} else if(user.getAccessLevel().equals("A")) {
				page = "AdminUserListingPage.jsp";
			} else {
				page = "Runner.jsp";
			}
			
		} catch(Exception e) {
			
		} finally {
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}
}
