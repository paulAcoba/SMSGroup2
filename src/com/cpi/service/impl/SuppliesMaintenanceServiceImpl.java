package com.cpi.service.impl;

import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.cpi.dao.SuppliesMaintenanceDAO;

import com.cpi.entity.SuppliesMaintenance;

import com.cpi.entity.SupplyType;
import com.cpi.service.SuppliesMaintenanceService;;

public class SuppliesMaintenanceServiceImpl implements SuppliesMaintenanceService {

	private SuppliesMaintenanceDAO SuppliesMaintenanceDao;

	public SuppliesMaintenanceDAO getSuppliesMaintenanceDao() {
		return SuppliesMaintenanceDao;
	}

	public void setSuppliesMaintenanceDao(SuppliesMaintenanceDAO suppliesMaintenanceDao) {
		SuppliesMaintenanceDao = suppliesMaintenanceDao;
	}

	public void getSuppliesTypeId(HttpServletRequest request) throws SQLException {
/*
		List<SuppliesMaintenance> list = this.getSuppliesMaintenanceDao().getSupplyTypeId();
		String typeid = "";

		for (int i = 0; i < list.size(); i++) {
			typeid += "<option id='" + list.get(i).getSupplyType() + "' value='" + list.get(i).getSupplyType() + "'>";
			 typeid += list.get(i).getType(); 
			typeid += "</option>";
		}

		request.setAttribute("allItems", typeid);*/
	}
	public List<SupplyType> getSupplyTypeID() throws SQLException {
		return this.getSuppliesMaintenanceDao().getSupplyTypeId();

	}


	public List<SuppliesMaintenance> getAllSupplies() throws SQLException {
		return this.getSuppliesMaintenanceDao().getAllSupplies();

	}

	public void addSupplies(HttpServletRequest request) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("supplyId", request.getParameter("supplyId"));
		params.put("supplyType", request.getParameter("supplyType"));
		params.put("itemName", request.getParameter("itemName"));
		params.put("itemUnit", request.getParameter("itemUnit"));
		params.put("obsoleteTag", request.getParameter("obsoleteTag"));
		params.put("location", request.getParameter("location"));
		params.put("reorderLevel", request.getParameter("reorderLevel"));
		params.put("remarks", request.getParameter("remarks"));
		params.put("actualCount", request.getParameter("actualCount"));
		params.put("dateAdded", request.getParameter("dateAdded"));
		params.put("lastUser", request.getAttribute("lastUser"));
		params.put("lastUpdate", request.getParameter("lastUpdate"));
	
		this.getSuppliesMaintenanceDao().addSupplies(params);

	}

	public void updateSupplies(HttpServletRequest request) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("supplyId", request.getParameter("supplyId"));
		//params.put("supplyType", request.getParameter("supplyType"));
		params.put("itemName", request.getParameter("itemName"));
		params.put("itemUnit", request.getParameter("itemUnit"));
		params.put("obsoleteTag", request.getParameter("obsoleteTag"));
		params.put("location", request.getParameter("location"));
		params.put("reorderLevel", request.getParameter("reorderLevel"));
		params.put("remarks", request.getParameter("remarks"));
		params.put("actualCount", request.getParameter("actualCount"));
		//params.put("dateAdded", request.getParameter("dateAdded"));
		//params.put("lastUser", request.getParameter("lastUser"));
		//params.put("lastUpdate", request.getParameter("lastUpdate"));

		this.getSuppliesMaintenanceDao().updateSupplies(params);

	}

	public List<SuppliesMaintenance> getAllSuppId(HttpServletRequest request) throws SQLException{
		String searchId = "%" + request.getParameter("search") + "%";
		return this.getSuppliesMaintenanceDao().getAllSuppId(searchId);
	}

}
