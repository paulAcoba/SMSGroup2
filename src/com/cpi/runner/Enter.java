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
		RequestDispatcher rd = request.getRequestDispatcher("UserUpdateProfilePage.jsp");
		rd.forward(request, response);

	}
}
