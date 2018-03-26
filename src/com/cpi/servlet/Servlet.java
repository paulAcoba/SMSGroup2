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

public class Servlet extends HttpServlet {

	private static final long serialVersionUID = -3254083445269926470L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession();

		UserService userService = new UserServiceImpl();
		String message = userService.getLogin(request);
		String page = "";
		System.out.println(message);

		if (message.equals("accessAdmin")) {

			System.out.println(session.getAttribute("active"));

			User myUser = new User();
			myUser = (User) session.getAttribute("activeUser");
			System.out.println(myUser.getFirstName() + " " + myUser.getLastName());
			
			RequestDispatcher rd = request.getRequestDispatcher("pages/homeAdmin.jsp");
			rd.forward(request, response);

		} else if (message.equals("accessUser")) {

			User myUser = new User();
			myUser = (User) session.getAttribute("activeUser");
			System.out.println(myUser.getFirstName() + " " + myUser.getLastName());

			RequestDispatcher rd = request.getRequestDispatcher("pages/homeUser.jsp");
			rd.forward(request, response);

		} else if (message.equals("newAccount")) {

			User myUser = new User();
			myUser = (User) session.getAttribute("activeUser");
			System.out.println(myUser.getFirstName() + " " + myUser.getLastName());

			RequestDispatcher rd = request.getRequestDispatcher("pages/changePasswordPage.jsp");
			rd.forward(request, response);

		}else if (message.equals("blocked")) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			RequestDispatcher rd = request.getRequestDispatcher("pages/accountBlocked.jsp");
			rd.forward(request, response);

		}
		else {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			RequestDispatcher rd = request.getRequestDispatcher("pages/incorrectPw.jsp");
			rd.forward(request, response);
			
		}
	}
}
