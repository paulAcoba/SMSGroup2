package com.cpi.service.impl;

import java.sql.SQLException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.cpi.dao.IssuedSupplyDAO;
import com.cpi.entity.Departments;
import com.cpi.entity.IssuedSupply;
import com.cpi.entity.SuppliesMaintenance;
import com.cpi.service.IssuedSupplyService;

public class IssuedSupplyServiceImpl implements IssuedSupplyService{

		private IssuedSupplyDAO issuedSupplyDao;

		public IssuedSupplyDAO getIssuedSupplyDao() {
			return issuedSupplyDao;
		}

		public void setIssuedSupplyDao(IssuedSupplyDAO issuedSupplyDao) {
			this.issuedSupplyDao = issuedSupplyDao;
		}
		

		public List<SuppliesMaintenance> getAllItem() throws SQLException{
			return this.getIssuedSupplyDao().getAllItems();
		}
		
		public void addIssuedSupply(HttpServletRequest request) throws SQLException{
			System.out.println("service impl");
			Map<String, Object> params = new HashMap<>();
			int newActualCount = 0;
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			int actualCounts = Integer.parseInt(request.getAttribute("actualCounts").toString());
			
			newActualCount = actualCounts - quantity;
			params.put("supplyId", request.getParameter("supplyId"));
			params.put("issueDate", request.getParameter("issueDate"));
			params.put("requestor", request.getParameter("requestor"));
			params.put("quantity", Integer.parseInt(request.getParameter("quantity")));
			params.put("deptId", request.getParameter("deptId"));
			params.put("lastUser", "paul");
			params.put("newActualCount", newActualCount);
			//params.put("lastUser", request.getAttribute("lastUser"));
			System.out.println(request.getParameter("issueDate"));
			this.getIssuedSupplyDao().addIssuedSupplies(params);
		}
		
		public void updateIssuedSupply(HttpServletRequest request) throws SQLException{
			System.out.println("service update");
			Map<String, Object> params = new HashMap<>();
			params.put("issueId", Integer.parseInt(request.getParameter("issueId")));
			params.put("supplyId", Integer.parseInt(request.getParameter("supplyId")));
			params.put("issueDate", request.getParameter("issueDate"));
			params.put("requestor", request.getParameter("requestor"));
			params.put("quantity", Integer.parseInt(request.getParameter("quantity")));
			params.put("deptId", request.getParameter("deptId"));
			params.put("lastUser", "paul");
			//params.put("lastUser", request.getAttribute("lastUser"));
			System.out.println(params.get("requestor"));
			System.out.println(params.get("quantity"));
			this.getIssuedSupplyDao().updateIssuedSupplies(params);
		}
		
		public List<IssuedSupply> getAllIssuedSupplyById(HttpServletRequest request) throws SQLException{
			String searchText = "%" + request.getParameter("searching") + "%";
			return this.getIssuedSupplyDao().getAllIssuedSuppliesById(searchText);
		}
		
		public List<IssuedSupply> getAllIssuedSupply() throws SQLException{
			return this.getIssuedSupplyDao().getAllIssuedSupplies();
		}
		
		public List<Departments> getAllDepartment() throws SQLException{
			return this.getIssuedSupplyDao().getAllDepartments();
		}
}
