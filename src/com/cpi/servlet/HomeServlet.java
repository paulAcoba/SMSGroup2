package com.cpi.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cpi.entity.User;
import com.cpi.userservice.UserService;
import com.cpi.userservice.impl.UserServiceImpl;

public class HomeServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();

		UserService userService = new UserServiceImpl();
		String page = "";
		User myUser = new User();
		myUser = (User) session.getAttribute("activeUser");
		session.setAttribute("status", "login");
		session.setAttribute("page", "pages/homeUser.jsp");
		RequestDispatcher rd = request.getRequestDispatcher("pages/homeUser.jsp");
		rd.forward(request, response);
	}
}
