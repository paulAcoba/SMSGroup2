package com.cpi.servlet;

import java.io.IOException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cpi.service.IssuedSupplyService;

public class IssuesSupplyServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		String action = request.getParameter("action");
		String view = "";
		HttpSession session = request.getSession();
		
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("/com/cpi/resource/applicationContext.xml");
		IssuedSupplyService issuedSupply = (IssuedSupplyService) context.getBean("issuedSupply");

		request.setAttribute("lastUser", session.getAttribute("username"));
		request.setAttribute("lastUpdate", new Date());
		try{
			if("addData".equals(action)){
				issuedSupply.addIssuedSupply(request);
				view = "views/issuedsupply.jsp";
				
			}else if("updateData".equals(action)){
				
				issuedSupply.updateIssuedSupply(request);
				view = "views/issuedsupply.jsp";
				
			}else if("refresh".equals(action)){
				
				issuedSupply.getAllIssuedSupply(request);
				view = "views/issuedsupply.jsp";
				//view =request.getAttribute("allIssuedSupply").toString();
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			RequestDispatcher rd = request.getRequestDispatcher(view);
			rd.forward(request, response);
		}
	}

}
