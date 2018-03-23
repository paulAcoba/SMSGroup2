package com.cpi.dao.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.cpi.dao.IssuedSupplyDAO;
import com.cpi.entity.Departments;
import com.cpi.entity.IssuedSupply;
import com.cpi.entity.SuppliesMaintenance;
import com.ibatis.sqlmap.client.SqlMapClient;

public class IssuedSupplyDAOImpl implements IssuedSupplyDAO{
	
	private SqlMapClient sqlMapClient;

	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}

	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}
	
	@SuppressWarnings("unchecked")
	public List<SuppliesMaintenance> getAllItems() throws SQLException{
		return (List<SuppliesMaintenance>) this.getSqlMapClient().queryForList("getAllItems");
	}
	
	public void addIssuedSupplies(Map<String, Object> items) throws SQLException{
		try{
			System.out.println("on here");
			this.sqlMapClient.startTransaction();
			this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
			this.sqlMapClient.startBatch();
			
			this.getSqlMapClient().update("addIssuedSupplies", items);
			
			this.sqlMapClient.executeBatch();
			this.sqlMapClient.getCurrentConnection().commit();
			
		}catch(SQLException e){
			System.out.println(e.getLocalizedMessage());
		}
		
	}
	
	public String updateIssuedSupplies(Map<String, Object> items) throws SQLException{
		
		return (String) this.getSqlMapClient().queryForObject("updateIssuedSupplies", items);
	
	}
	
	@SuppressWarnings("unchecked")
	public List<IssuedSupply> getAllIssuedSupplies() throws SQLException{
		return (List<IssuedSupply>) this.getSqlMapClient().queryForList("getAllIssuedSupplies");
	}
	
	@SuppressWarnings("unchecked")
	public List<IssuedSupply> getAllIssuedSuppliesById(String userId) throws SQLException{
		
		return (List<IssuedSupply>) this.getSqlMapClient().queryForList("getAllIssuedSupplies");
	}	
	
	@SuppressWarnings("unchecked")
	public List<Departments> getAllDepartments() throws SQLException{
		return this.getSqlMapClient().queryForList("getAllDepartments");
	}
}
