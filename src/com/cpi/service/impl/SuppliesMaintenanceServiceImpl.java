package com.cpi.service.impl;

import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.cpi.dao.SuppliesMaintenanceDAO;

import com.cpi.entity.SuppliesMaintenance;
import com.cpi.service.SuppliesMaintenanceService;;

public class SuppliesMaintenanceServiceImpl implements SuppliesMaintenanceService {

	private SuppliesMaintenanceDAO SuppliesMaintenanceDao;

	public SuppliesMaintenanceDAO getSuppliesMaintenanceDao() {
		return SuppliesMaintenanceDao;
	}

	public void setSuppliesMaintenanceDao(SuppliesMaintenanceDAO suppliesMaintenanceDao) {
		SuppliesMaintenanceDao = suppliesMaintenanceDao;
	}

	public void getAllSupplies(HttpServletRequest request) throws SQLException {
		List<SuppliesMaintenance> list = this.getSuppliesMaintenanceDao().getAllSupplies();
		String supp = "";
		
		for (int i = 0; i < list.size(); i++) {
			
			supp += "<tr id='" + list.get(i).getSupplyId()+ "'>";
			supp += "<td><a href='#'>" + list.get(i).getSupplyId()+ "</a></td>";
			supp += "<td>"+list.get(i).getSupplyId()+"</td>";
			supp += "<td>"+list.get(i).getSupplyType()+"</td>";
			supp += "<td>"+list.get(i).getItemName()+"</td>";
			supp += "<td>"+list.get(i).getItemUnit()+"</td>";
			supp += "<td>"+list.get(i).getObseleteTag()+"</td>";
			supp += "<td>"+list.get(i).getLocation()+"</td>";
			supp += "<td>"+list.get(i).getReorderLevel()+"</td>";
			supp += "<td>"+list.get(i).getActualCount()+"</td>";
			supp += "<td>"+list.get(i).getDateAdded()+"</td>";
			supp += "<td>"+list.get(i).getLastUser()+"</td>";
			supp += "<td>"+list.get(i).getLastUpdate()+"</td>";
		}
		request.setAttribute("allSupplies", supp);
		
		
	}

	public void addSupplies(HttpServletRequest request) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("supplyId", request.getParameter("supplyId"));
		params.put("supplyType", request.getParameter("supplyType"));
		params.put("itemName", request.getParameter("itemName"));
		params.put("itemUnit", request.getParameter("itemUnit"));
		params.put("obseleteTag", request.getParameter("obseleteTag"));
		params.put("location", request.getParameter("location"));
		params.put("reorderLevel", request.getParameter("reorderLevel"));
		params.put("remarks", request.getParameter("remarks"));
		params.put("actualCount", request.getParameter("actualCount"));
		params.put("dateAdded", request.getParameter("dateAdded"));
		params.put("lastUser", request.getParameter("lastUser"));
		params.put("lastUpdate", request.getParameter("lastUpdate"));

		this.getSuppliesMaintenanceDao().addSupplies(params);

	}

	public void updateSupplies(HttpServletRequest request) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("supplyId", request.getParameter("supplyId"));
		params.put("supplyType", request.getParameter("supplyType"));
		params.put("itemName", request.getParameter("itemName"));
		params.put("itemUnit", request.getParameter("itemUnit"));
		params.put("obseleteTag", request.getParameter("obseleteTag"));
		params.put("location", request.getParameter("location"));
		params.put("reorderLevel", request.getParameter("reorderLevel"));
		params.put("remarks", request.getParameter("remarks"));
		params.put("actualCount", request.getParameter("actualCount"));
		params.put("dateAdded", request.getParameter("dateAdded"));
		params.put("lastUser", request.getParameter("lastUser"));
		params.put("lastUpdate", request.getParameter("lastUpdate"));

		this.getSuppliesMaintenanceDao().updateSupplies(params);

	}

}

