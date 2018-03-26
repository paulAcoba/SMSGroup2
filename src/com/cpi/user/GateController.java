package com.cpi.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class GateController extends HttpServlet{
	
	private static final long serialVersionUID = 6521917413972013277L;

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
			RequestDispatcher rd = request.getRequestDispatcher("UserUpdateProfilePage.jsp");
			rd.forward(request, response);
		}
		
		if("adminAddNewUser".equals(request.getParameter("gateKey"))){
			RequestDispatcher rd = request.getRequestDispatcher("AdminAddNewUserMaintenancePage.jsp");
			rd.forward(request, response);
		}
	}
}
