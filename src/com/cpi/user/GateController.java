package com.cpi.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cpi.entity.User;

public class GateController extends HttpServlet{
	
	private static final long serialVersionUID = 6521917413972013277L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession();
		User activeUser = new User();
		activeUser = (User) session.getAttribute("activeUser");
		request.setAttribute("userId", activeUser.getUserId());
		request.setAttribute("password", activeUser.getPassword());
		request.setAttribute("firstName", activeUser.getFirstName());
		request.setAttribute("lastName", activeUser.getLastName());
		request.setAttribute("middleInitial", activeUser.getMiddleInitial());
		request.setAttribute("email", activeUser.getEmail());
		System.out.println(activeUser.getUserId() + "-userid");
		System.out.println(activeUser.getPassword() + "-password");
		System.out.println(activeUser.getFirstName() + "-first name");
		System.out.println(activeUser.getLastName() + "-last");
		System.out.println(activeUser.getMiddleInitial() + "-mid");
		System.out.println(activeUser.getEmail() + "-email");
		RequestDispatcher rd = request.getRequestDispatcher("UserUpdateProfilePage.jsp");
		rd.forward(request, response);
		
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession();
		
		if("adminUserListing".equals(request.getParameter("gateKey"))){
			RequestDispatcher rd = request.getRequestDispatcher("AdminUserListingPage.jsp");
			rd.forward(request, response);
		}
		
		if("updatePassword".equals(request.getParameter("gateKey"))){
			RequestDispatcher rd = request.getRequestDispatcher("UserChangePasswordProfilePage.jsp");
			rd.forward(request, response);
		}
		
		if("userUpdateProfile".equals(request.getParameter("gateKey"))){
			User activeUser = new User();
			activeUser = (User) session.getAttribute("activeUser");
			request.setAttribute("userId", activeUser.getUserId());
			request.setAttribute("password", activeUser.getPassword());
			request.setAttribute("firstName", activeUser.getFirstName());
			request.setAttribute("lastName", activeUser.getLastName());
			request.setAttribute("middleInitial", activeUser.getMiddleInitial());
			request.setAttribute("email", activeUser.getEmail());
			
			RequestDispatcher rd = request.getRequestDispatcher("UserUpdateProfilePage.jsp");
			rd.forward(request, response);
		}
		
		if("adminAddNewUser".equals(request.getParameter("gateKey"))){
			RequestDispatcher rd = request.getRequestDispatcher("AdminAddNewUserMaintenancePage.jsp");
			rd.forward(request, response);
		}
	}
}
