package com.cpi.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cpi.entity.SuppliesMaintenance;
import com.cpi.entity.SupplyType;
import com.cpi.entity.User;
import com.cpi.service.SuppliesMaintenanceService;

public class SuppliesMaintenanceServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub]
		try{
			String action = request.getParameter("action");
			String a = "";

			@SuppressWarnings("resource")
			ApplicationContext context = new ClassPathXmlApplicationContext("/com/cpi/resource/applicationContext.xml");
			SuppliesMaintenanceService supplies = (SuppliesMaintenanceService) context
					.getBean("suppliesMaintenanceService");
			
			List<SupplyType> lists = new ArrayList<>();
			List<SuppliesMaintenance> list = new ArrayList<>();
			
			lists = supplies.getSupplyTypeID();
			list = supplies.getAllSupplies();
			
			RequestDispatcher rd = request.getRequestDispatcher("peripherals/populateAll.jsp");
			rd.forward(request, response);
		}catch(Exception e){
			
		}
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String action = request.getParameter("action");
		String a = "";
		HttpSession session = request.getSession();

		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("/com/cpi/resource/applicationContext.xml");
		SuppliesMaintenanceService supplies = (SuppliesMaintenanceService) context
				.getBean("suppliesMaintenanceService");

		List<SupplyType> lists = new ArrayList<>();
		List<SuppliesMaintenance> list = new ArrayList<>();

		

		
	
		
	
	/*	User activeUser = new User();
		activeUser = (User) session.getAttribute("activeUser");
		
		
		request.setAttribute("lastUser", activeUser.getUserId());
		System.out.println(activeUser.getUserId());*/
		request.setAttribute("lastUpdate", new Date());
		String searchId = "";
		searchId = request.getParameter("search");

		try {
			lists = supplies.getSupplyTypeID();
			list = supplies.getAllSupplies();
			if ("showSupply".equals(action)) {

				System.out.println("ichan");

				a = "peripherals/addSupplies.jsp";

			} else if ("id".equals(action)) {

				a = "peripherals/populateSupplyTypeId.jsp";

			} else if ("addSupply".equals(action)) {

				supplies.addSupplies(request);
				request.setAttribute("message", "Supplies Added!");
				a = "views/suppliesmaintenance.jsp";

			} else if ("populate".equals(action)) {

				a = "peripherals/populateAll.jsp";
			} else if ("cancel".equals(action)) {

				a = "views/suppliesmaintenance.jsp";

			} else if ("save".equals(action)) {

				supplies.updateSupplies(request);
				//request.setAttribute("message", "Supplies Updated!");
				a = "views/suppliesmaintenance.jsp";
				

			} else if ("search".equals(action)) {
				if (searchId.length() <= 0 || searchId.equals(null)) {
					list = supplies.getAllSuppId(request);
				} else {
					//System.out.println(searchId);
					list = supplies.getAllSuppId(request);
				}
				for (int i = 0; i < list.size(); i++) {
					System.out.println(list.get(i).getSupplyId());
				}
				a = "peripherals/populateAll.jsp";

			} else {
				a = "views/suppliesmaintenance.jsp";
			}

			request.setAttribute("supType", lists);

			// list = supplies.getAllSupplies();
			request.setAttribute("allItems", list);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			RequestDispatcher rd = request.getRequestDispatcher(a);
			rd.forward(request, response);
		}
	}
}
