package com.cpi.servlett;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cpi.servlet.LoginService.LoginService;
import com.cpi.servlet.LoginService.impl.LoginServiceImpl;

public class LoginController extends HttpServlet{
	
private static final long serialVersionUID = 3036429910013859231L;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws IOException, ServletException{
		
		LoginService loginService = new LoginServiceImpl();
		String message = loginService.getLogin(request);
				
		if(message.equals("ok")){
			
			RequestDispatcher rd = request.getRequestDispatcher("pages/home.jsp");
			rd.forward(request, response);
			
		}
		else if(message.equals("blocked")){
			RequestDispatcher rd = request.getRequestDispatcher("pages/accountBlocked.jsp");
			rd.forward(request, response);
		}
		else{
			
			RequestDispatcher rd = request.getRequestDispatcher("pages/incorrectPw.jsp");
			rd.forward(request, response);
		}
		
		
	}

}
