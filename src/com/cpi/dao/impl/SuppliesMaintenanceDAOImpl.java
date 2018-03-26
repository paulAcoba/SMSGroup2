package com.cpi.dao.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cpi.dao.SuppliesMaintenanceDAO;
import com.cpi.entity.SuppliesMaintenance;
import com.cpi.entity.SupplyType;
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


	public void addSupplies(Map<String, Object> items) throws SQLException {
		
		this.sqlMapClient.startTransaction();
		this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
		this.sqlMapClient.startBatch();
		
		this.getSqlMapClient().update("addSupplies", items);
		
		this.sqlMapClient.executeBatch();
		this.sqlMapClient.getCurrentConnection().commit();
		/*} catch (SQLException e){
			System.out.println(e.getLocalizedMessage());
		}
	}*/
	}

	public void updateSupplies(Map<String, Object> items) throws SQLException {
		this.sqlMapClient.startTransaction();
		this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
		this.sqlMapClient.startBatch();
		
		this.getSqlMapClient().queryForObject("updateSupplies", items);
		this.sqlMapClient.executeBatch();
		this.sqlMapClient.getCurrentConnection().commit();
	
	}
	
	@SuppressWarnings("unchecked")
	public List<SupplyType> getSupplyTypeId() throws SQLException {
		return (List<SupplyType>) this.getSqlMapClient().queryForList("getSuppliesId");
	}
	
	@SuppressWarnings("unchecked")

	public List<SuppliesMaintenance> getAllSuppId(String supplyId) throws SQLException{
	
		Map<String, Object> param = new HashMap<>();
		
		param.put("supplyId", supplyId);
		return (List<SuppliesMaintenance>) this.getSqlMapClient().queryForList("getAllSuppId",param);
	}	
}
