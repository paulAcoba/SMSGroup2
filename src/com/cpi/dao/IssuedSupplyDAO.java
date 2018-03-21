package com.cpi.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.cpi.entity.IssuedSupply;
import com.cpi.entity.SuppliesMaintenance;

public interface IssuedSupplyDAO {
	public List<SuppliesMaintenance> getAllItems() throws SQLException;//this will populate the item names
	public String addIssuedSupplies(Map<String, Object> items) throws SQLException; //this will add data to db
	public String updateIssuedSupplies(Map<String, Object> items) throws SQLException; //this will update the selected data
	public List<IssuedSupply> getAllIssuedSuppliesById(String userId) throws SQLException; //this will get issued supply by the logged in ID
	public List<IssuedSupply> getAllIssuedSupplies() throws SQLException;//this will get all issued supplies
}
