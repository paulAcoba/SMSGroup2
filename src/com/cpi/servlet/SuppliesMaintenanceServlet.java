package com.cpi.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cpi.service.SuppliesMaintenanceService;

public class SuppliesMaintenanceServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String action = request.getParameter("action");
		String a = "";

		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("/com/cpi/resource/applicationContext.xml");
		SuppliesMaintenanceService supplies = (SuppliesMaintenanceService) context.getBean("suppliesMaintenanceService");

		try {
			if ("addSupply".equals(action)) {
				supplies.addSupplies(request);
				a = "views/suppliesmaintenance.jsp";
			} else if ("updateSupply".equals(action)) {
				supplies.updateSupplies(request);
				a = "views/suppliesmaintenance.jsp";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			RequestDispatcher rd = request.getRequestDispatcher(a);
			rd.forward(request, response);
		}
	}
}
