package com.cpi.service;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

public interface SuppliesMaintenanceService {

	public void getAllSupplies(HttpServletRequest request) throws SQLException;

	public void addSupplies(HttpServletRequest request) throws SQLException;

	public void updateSupplies(HttpServletRequest request) throws SQLException;

}
