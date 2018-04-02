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

import com.cpi.entity.Departments;
import com.cpi.entity.IssuedSupply;
import com.cpi.entity.SuppliesMaintenance;
import com.cpi.entity.User;
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
		int quantity =0 ;
		
		List<IssuedSupply> list = new ArrayList<>();
		List<Departments> dlist = new ArrayList<>();
		List<SuppliesMaintenance> slist = new ArrayList<>();
		
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("/com/cpi/resource/applicationContext.xml");
		IssuedSupplyService issuedSupply = (IssuedSupplyService) context.getBean("issueSupplyService");
		User user = new User();
		user = (User) session.getAttribute("activeUser");
		request.setAttribute("lastUser",user.getUserId());
		request.setAttribute("lastUpdate", new Date());
		session.setAttribute("status","login");
		System.out.println(request.getParameter("action") + " action");
		
		try{
			list = issuedSupply.getAllIssuedSupply();
			slist = issuedSupply.getAllItem();
			dlist = issuedSupply.getAllDepartment();

			String searchText = "";
			searchText = request.getParameter("searching");
			
			if("sels".equals(action)){
			
				view = "peripherals/issuedSupplies/itemSelectPopulate.jsp";
				
			}else if("depts".equals(action)){
				
				
				view = "peripherals/issuedSupplies/deptSelectPopulate.jsp";
				
			}else if("refresh".equals(action)){
				
				view = "peripherals/issuedSupplies/issuedSuppliesRows.jsp";
				
			}else if("issue".equals(action)){
				view = "peripherals/issuedSupplies/addIssueSupply.jsp";
			}else if("cancel".equals(action)){
				view = "views/issuedsupply.jsp";
			}else if("toIssuePage".equals(action)){
				view = "views/issuedsupply.jsp";
			}else if("addData".equals(action)){
				System.out.println(request.getParameter("supplyId"));

				quantity = Integer.parseInt(request.getParameter("quantity"));
				System.out.println(slist);
				for(int i = 0; i<slist.size();i++){
					if(slist.get(i).getSupplyId().toString().equals(request.getParameter("supplyId"))){
						System.out.println(slist.get(i).getItemName());
						request.setAttribute("itemNames", slist.get(i).getItemName());
						request.setAttribute("actualCounts", slist.get(i).getActualCount());
						request.setAttribute("reorderLevels", slist.get(i).getReorderLevel());
					}else{
						System.out.println(slist.get(i).getSupplyId());
					}
				}
				
				int actualCounts = 0;
				actualCounts = Integer.parseInt(request.getAttribute("actualCounts").toString());
				int reorderLevels = 0;
				reorderLevels = Integer.parseInt(request.getAttribute("reorderLevels").toString());
				String alertMsg = "";
					if(actualCounts >= quantity){
						System.out.println("AC > Q");

						issuedSupply.addIssuedSupply(request);

						alertMsg ="Request Issued.";
						if(actualCounts <= reorderLevels){
							String msg = "";
							if(actualCounts < reorderLevels) msg = "below"; 
							else msg="equal";
							
							alertMsg += "\nThe actual count of the item "+request.getAttribute("itemNames")+ " is " + msg + " the reorder level";
						}
					}else{
						alertMsg = request.getAttribute("itemNames")+ " only has " + actualCounts + ", which is below the requested number of items.";
					}
				
				request.setAttribute("message", alertMsg);
				System.out.println(request.getAttribute("message") + "-message");
				view = "peripherals/issuedSupplies/addIssueSupply.jsp";
				
				
			}else if("updateData".equals(action)){
				System.out.println("in update");
				issuedSupply.updateIssuedSupply(request);
				view = "views/issuedsupply.jsp";
				
			}else if("search".equals(action)){
				if(searchText.length() <=0 || searchText.equals(null)){
					list = issuedSupply.getAllIssuedSupply();
				}else{
					System.out.println(searchText);
					list = issuedSupply.getAllIssuedSupplyById(request);
				}
				for(int i = 0; i < list.size();i++){
					System.out.println(list.get(i).getIssueId());
				}
				view = "peripherals/issuedSupplies/issuedSuppliesRows.jsp";
			}
			
			/*List<IssuedSupply> list = new ArrayList<>();
			list = issuedSupply.getAllIssuedSupply();
			request.setAttribute("issuedSuppliesList", list); */
			
			/*List<SuppliesMaintenance> slist = new ArrayList<>();
			slist = issuedSupply.getAllItem();
			request.setAttribute("itemList", slist); */
			
			request.setAttribute("itemLists", slist);
			request.setAttribute("deptList", dlist);
			request.setAttribute("issuedSuppliesList", list);
			System.out.println(view);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			RequestDispatcher rd = request.getRequestDispatcher(view);
			rd.forward(request, response);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String view = "";
		view = "views/issuedsupply.jsp";
		request.setAttribute("message", "");
		RequestDispatcher rd = request.getRequestDispatcher(view);
		rd.forward(request, response);
		
		
	}
}
