package com.cpi.dao.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.cpi.dao.IssuedSupplyDAO;
import com.cpi.entity.IssuedSupply;
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
	public List<IssuedSupply> getAllItems() throws SQLException{
		return (List<IssuedSupply>) this.getSqlMapClient().queryForList("getAllIssuedSupplies");
	}
	
	public String addIssuedSupplies(Map<String, Object> items) throws SQLException{
		return (String) this.getSqlMapClient().queryForObject("addIssuedSupplies", items);
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
}
