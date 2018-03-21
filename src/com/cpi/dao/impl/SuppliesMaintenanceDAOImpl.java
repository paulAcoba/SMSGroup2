package com.cpi.dao.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.cpi.dao.SuppliesMaintenanceDAO;
import com.cpi.entity.SuppliesMaintenance;
import com.ibatis.sqlmap.client.SqlMapClient;


public class SuppliesMaintenanceDAOImpl implements SuppliesMaintenanceDAO{
	
	private SqlMapClient sqlMapClient;
	
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}

	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}
	
	@SuppressWarnings("unchecked")
	public List<SuppliesMaintenance> getAllSupplies() throws SQLException {
		return (List<SuppliesMaintenance>) this.getSqlMapClient().queryForList("getAllSupplies");
	}


	public String addSupplies(Map<String, Object> items) throws SQLException {
		return (String) this.getSqlMapClient().queryForObject("addSupplies", items);
	}


	public String updateSupplies(Map<String, Object> items) throws SQLException {
		return (String) this.getSqlMapClient().queryForObject("updateSupplies", items);
	}
}
