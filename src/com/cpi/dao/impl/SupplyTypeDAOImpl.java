package com.cpi.dao.impl;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.cpi.dao.SupplyTypeDAO;
import com.cpi.entity.SupplyType;
import com.cpi.entity.User;
import com.cpi.exceptions.NoSupplyTypeIdFound;
import com.ibatis.sqlmap.client.SqlMapClient;

public class SupplyTypeDAOImpl implements SupplyTypeDAO {

	private SqlMapClient sqlMapClient;

	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}

	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	@SuppressWarnings("unchecked")
	public List<SupplyType> getSupplyType() throws SQLException {
			return this.getSqlMapClient().queryForList("getSupplyType");
		
	}

	@SuppressWarnings({ "unchecked" })
	@Override
	public List<SupplyType> searchSupplyType(HttpServletRequest req) throws SQLException, NoSupplyTypeIdFound {
		String supplyTypeId= req.getParameter("supplyTypeId");
		List<SupplyType> list = new ArrayList<>();
		Map<String, Object> param = new HashMap<>();
		try {
			
			param.put("supplyTypeId", supplyTypeId);
				list=this.getSqlMapClient().queryForList("searchSupplyType",supplyTypeId);
		} catch (SQLException e) {
			System.out.println(e.getLocalizedMessage());
		}
		return list;
	}

	
	@Override
	public void insertSupplyType(HttpServletRequest req) throws SQLException {
		this.sqlMapClient.startTransaction();
		this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
		this.sqlMapClient.startBatch();
		Date date = new Date();
		String dateFormatted = new SimpleDateFormat("MM/dd/yyyy").format(date);
		String supplyTypeId = req.getParameter("supplyTypeId");
		String supplyTypeName= req.getParameter("supplyTypeName");
		
		HttpSession session = req.getSession();
		User activeUser = new User();
		activeUser = (User) session.getAttribute("activeUser");
		String lastUser= activeUser.getUserId();
		
		SupplyType sup = new SupplyType();
		
		sup.setLastUser(lastUser);
		sup.setSupplyTypeId(Integer.parseInt(supplyTypeId));
		sup.setTypeName(supplyTypeName);
		sup.setEntryDate(dateFormatted); 
		sup.setLastUpdate(dateFormatted);
		 

		this.getSqlMapClient().insert("insertSupplyType", sup);

		this.sqlMapClient.executeBatch();
		this.sqlMapClient.getCurrentConnection().commit();
	}

	@Override
	public void deleteSupplyType() throws SQLException {
		this.sqlMapClient.startTransaction();
		this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
		this.sqlMapClient.startBatch();

		SupplyType sup = new SupplyType();

		this.getSqlMapClient().delete("deleteSupplyType", sup);

		this.sqlMapClient.executeBatch();
		this.sqlMapClient.getCurrentConnection().commit();

	}

	@Override
	public void updateSupplyType(HttpServletRequest req) throws SQLException {
		this.sqlMapClient.startTransaction();
		this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
		this.sqlMapClient.startBatch();
		
		HttpSession session = req.getSession();
		User activeUser = new User();
		activeUser = (User) session.getAttribute("activeUser");
		String lastUser= activeUser.getUserId();
		
		
		
		

		String supplyTypeId= req.getParameter("supplyTypeId");
		String supplyTypeName= req.getParameter("supplyTypeName");
		Map<String,Object> params = new HashMap<>();
		
		params.put("typeId", supplyTypeId);
		params.put("typeName", supplyTypeName);
		params.put("lastUser", lastUser);

		this.getSqlMapClient().update("updateSupplyType", params);

		this.sqlMapClient.executeBatch();
		this.sqlMapClient.getCurrentConnection().commit();

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<SupplyType> getMaxSupplyTypeId() throws SQLException {
		return this.getSqlMapClient().queryForList("getMaxSupplyType");
	}



}
