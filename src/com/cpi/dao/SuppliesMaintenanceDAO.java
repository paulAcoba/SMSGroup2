package com.cpi.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.cpi.entity.SuppliesMaintenance;

public interface SuppliesMaintenanceDAO {
	
	public List<SuppliesMaintenance> getAllSupplies() throws SQLException;
	public String addSupplies(Map<String, Object> items) throws SQLException;
	public String updateSupplies(Map<String, Object> items) throws SQLException;
}
