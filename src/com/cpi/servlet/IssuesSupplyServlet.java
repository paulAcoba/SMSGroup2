package com.cpi.servlet;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.cpi.entity.Departments;
import com.cpi.entity.IssuedSupply;
import com.cpi.entity.SuppliesMaintenance;
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
		IssuedSupplyService issuedSupply = (IssuedSupplyService) context.getBean("issueSupplyService");

		request.setAttribute("lastUser", session.getAttribute("username"));
		request.setAttribute("lastUpdate", new Date());
		
		/*if(session.isNew()){
			int counter = 0;
			session.setAttribute("counter", counter);
		}else{
			if(username!= password){
				counter = session.getAttribute("counter");
				counter++;
				session.setAttribute("counter", counter);
			}
		}*/
		
		
		
		System.out.println(request.getParameter("action") + " action");
		try{
			
			if("addData".equals(action)){
				System.out.println(request.getParameter("supplyId"));
				issuedSupply.addIssuedSupply(request);
				view = "views/issuedsupply.jsp";
				
			}else if("updateData".equals(action)){
				
				issuedSupply.updateIssuedSupply(request);
				view = "views/issuedsupply.jsp";
				
			}else if("refresh".equals(action)){
				
				List<IssuedSupply> list = new ArrayList<>();
				list = issuedSupply.getAllIssuedSupply();
				
				request.setAttribute("issuedSuppliesList", list);
				view = "peripherals/issuedSupplies/issuedSuppliesRows.jsp";
				
			}else if("issue".equals(action)){
				view = "peripherals/issuedSupplies/addIssueSupply.jsp";
			}else if("cancel".equals(action)){
				view = "views/issuedsupply.jsp";
			}else if("sels".equals(action)){
			
				
				List<SuppliesMaintenance> slist = new ArrayList<>();
				slist = issuedSupply.getAllItem();
				request.setAttribute("itemList", slist);
				
				view = "peripherals/issuedSupplies/itemSelectPopulate.jsp";
				
			}else if("depts".equals(action)){
			
				
				List<Departments> dlist = new ArrayList<>();
				dlist = issuedSupply.getAllDepartment();
				request.setAttribute("deptList", dlist);
				
				view = "peripherals/issuedSupplies/deptSelectPopulate.jsp";
				
			}
			
			/*List<IssuedSupply> list = new ArrayList<>();
			list = issuedSupply.getAllIssuedSupply();
			request.setAttribute("issuedSuppliesList", list); */
			
			/*List<SuppliesMaintenance> slist = new ArrayList<>();
			slist = issuedSupply.getAllItem();
			request.setAttribute("itemList", slist); */
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			RequestDispatcher rd = request.getRequestDispatcher(view);
			rd.forward(request, response);
		}
	}

}
