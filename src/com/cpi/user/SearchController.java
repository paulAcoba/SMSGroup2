package com.cpi.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cpi.userservice.UserService;

public class SearchController extends HttpServlet {

	private static final long serialVersionUID = 1652980547383307620L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		doGet(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String content = "";
		String keyword = request.getParameter("keyword");
		try {
			ApplicationContext applicationContext = new ClassPathXmlApplicationContext("/com/cpi/resources/applicationContext.xml");
			UserService userService = (UserService) applicationContext.getBean("userService");
			content = userService.search(keyword);
			request.setAttribute("content", content);
		} catch(Exception e) {
			
		} finally {
			RequestDispatcher rd = request.getRequestDispatcher("TablePage.jsp");
			rd.forward(request, response);
		}
	}
}
