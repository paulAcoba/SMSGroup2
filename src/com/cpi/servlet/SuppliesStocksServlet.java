package com.cpi.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cpi.entity.SuppliesStocks;
import com.cpi.service.SuppliesStocksService;

public class SuppliesStocksServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		try {
			@SuppressWarnings("resource")
			ApplicationContext applicationContext = new ClassPathXmlApplicationContext("/com/cpi/resource/applicationContext.xml");
			
			SuppliesStocksService suppliesStocksService = (SuppliesStocksService)applicationContext.getBean("suppliesStocksService");
			
			List<SuppliesStocks> stocks = new ArrayList<>();
			stocks = suppliesStocksService.getSuppliesStocks();
			
			request.setAttribute("suppliesStocks", stocks);

		} catch (Exception e) {
			System.out.println(e);
		}finally{
			RequestDispatcher dispatcher = request.getRequestDispatcher("/suppliesStocksMain.jsp");
			dispatcher.forward(request, response);
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		String action = request.getParameter("action");
		String view = "";
		List<SuppliesStocks> stocks = new ArrayList<>();
		List<SuppliesStocks> supplies = new ArrayList<>();
		
		try {
			
			@SuppressWarnings("resource")
			ApplicationContext applicationContext = new ClassPathXmlApplicationContext("/com/cpi/resource/applicationContext.xml");
			SuppliesStocksService suppliesStocksService = (SuppliesStocksService)applicationContext.getBean("suppliesStocksService");
			
			if (action.equals("updateStock")) {
				
				suppliesStocksService.updateStocks(request);
				
				stocks = suppliesStocksService.getSuppliesStocks();
				request.setAttribute("suppliesStocks", stocks);
				
				view = "/suppliesStocksMain.jsp";
				
			} else if (action.equals("initInsert")) {
				
				supplies = suppliesStocksService.getSupplies();
				request.setAttribute("supplies", supplies);
				
				view = "/addStocks.jsp";
				
			} else if (action.equals("insertStock")) {
				
				// insert stocks in Stocks Table and update the actual count in Supplies table based on supply_id
				suppliesStocksService.insertStocks(request);
				
				supplies = suppliesStocksService.getSupplies();
				request.setAttribute("supplies", supplies);
				
				view = "/addStocks.jsp";
				
			} else if (action.equals("search")) {
				
				stocks = suppliesStocksService.searchSuppliesStocks(request);
				request.setAttribute("suppliesStocks", stocks);
				
				view = "/suppliesStocksMain.jsp";
				
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally{
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
		}
	}
}
