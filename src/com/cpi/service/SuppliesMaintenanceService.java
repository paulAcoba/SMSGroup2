package com.cpi.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.cpi.entity.SuppliesMaintenance;
import com.cpi.entity.SupplyType;

public interface SuppliesMaintenanceService {

	public List<SuppliesMaintenance> getAllSupplies() throws SQLException;

	public void addSupplies(HttpServletRequest request) throws SQLException;

	public void updateSupplies(HttpServletRequest request) throws SQLException;

	public List<SupplyType> getSupplyTypeID() throws SQLException;

	public List<SuppliesMaintenance> getAllSuppId(HttpServletRequest request) throws SQLException;

}
