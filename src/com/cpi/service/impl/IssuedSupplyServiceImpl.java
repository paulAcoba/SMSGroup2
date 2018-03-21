package com.cpi.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.cpi.dao.IssuedSupplyDAO;
import com.cpi.entity.IssuedSupply;
import com.cpi.service.IssuedSupplyService;

public class IssuedSupplyServiceImpl implements IssuedSupplyService{

		private IssuedSupplyDAO issuedSupplyDao;

		public IssuedSupplyDAO getIssuedSupplyDao() {
			return issuedSupplyDao;
		}

		public void setIssuedSupplyDao(IssuedSupplyDAO issuedSupplyDao) {
			this.issuedSupplyDao = issuedSupplyDao;
		}
		

		public void getAllItem(HttpServletRequest request) throws SQLException{
			List<IssuedSupply> list = this.getIssuedSupplyDao().getAllItems();
			System.out.println(list);
			String addOption = "";
			for (int i = 0; i < list.size(); i++) {
				addOption += "<option id='"+list.get(i).getSupplyId()+"' value='"+list.get(i).getSupplyId()+"'>";
				//addOption += list.get(i).getItemName();
				addOption += "</option>";
			}
			request.setAttribute("allItems", addOption);
		}
		
		public void addIssuedSupply(HttpServletRequest request) throws SQLException{
			Map<String, Object> params = new HashMap<>();
			params.put("supplyId", request.getParameter("supplyId"));
			params.put("issueDate", request.getParameter("issueDate"));
			params.put("requestor", request.getParameter("requestor"));
			params.put("quantity", request.getParameter("quantity"));
			params.put("deptId", request.getParameter("deptId"));
			params.put("lastUser", request.getAttribute("lastUser"));
			params.put("lastUpdate", request.getAttribute("lastUpdate"));
			
			this.getIssuedSupplyDao().addIssuedSupplies(params);
		}
		
		public void updateIssuedSupply(HttpServletRequest request) throws SQLException{
			Map<String, Object> params = new HashMap<>();
			params.put("issueId", request.getParameter("issueId"));
			params.put("supplyId", request.getParameter("supplyId"));
			params.put("issueDate", request.getParameter("issueDate"));
			params.put("requestor", request.getParameter("requestor"));
			params.put("quantity", request.getParameter("quantity"));
			params.put("deptId", request.getParameter("deptId"));
			params.put("lastUser", request.getAttribute("lastUser"));
			params.put("lastUpdate", request.getAttribute("lastUpdate"));
			
			this.getIssuedSupplyDao().updateIssuedSupplies(params);
		}
		
		public void getAllIssuedSupplyById(HttpServletRequest request) throws SQLException{
			
		}
		
		public void getAllIssuedSupply(HttpServletRequest request) throws SQLException{
			List<IssuedSupply> list = this.getIssuedSupplyDao().getAllIssuedSupplies();
			System.out.println(list);
			String addTr = "";
			
			for (int i = 0; i < list.size(); i++) {
				addTr += "<tr id='"+list.get(i).getIssueId()+"'>";
				addTr += "<td><a href='#'>"+list.get(i).getIssueId()+"</a></td>";
				addTr += "<td>"+list.get(i).getIssueId()+"</td>";
				addTr += "<td>"+list.get(i).getQuantity()+"</td>";
				addTr += "<td>"+list.get(i).getRequestor()+"</td>";
				addTr += "<td>"+list.get(i).getIssueId()+"</td>";
				addTr += "<td>"+list.get(i).getIssueDate()+"</td>";
				addTr += "<td>"+list.get(i).getLastUser()+"</td>";
				addTr += "<td>"+list.get(i).getLastUpdate()+"</td>";
				addTr += "</tr>";
			}
			request.setAttribute("allIssuedSupply", addTr);
		}
		
}
