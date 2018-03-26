package com.cpi.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.cpi.entity.SuppliesMaintenance;
import com.cpi.entity.SupplyType;

public interface SuppliesMaintenanceDAO {
	
	public List<SuppliesMaintenance> getAllSupplies() throws SQLException;
	public void addSupplies(Map<String, Object> items) throws SQLException;
	public void updateSupplies(Map<String, Object> items) throws SQLException;
	public List<SupplyType> getSupplyTypeId()throws SQLException;
	public List<SuppliesMaintenance> getAllSuppId(String supplyId) throws SQLException; 
}
