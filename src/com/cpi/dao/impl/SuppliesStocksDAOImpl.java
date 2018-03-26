package com.cpi.dao.impl;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import com.cpi.dao.SuppliesStocksDAO;
import com.cpi.entity.SuppliesStocks;
import com.ibatis.sqlmap.client.SqlMapClient;

public class SuppliesStocksDAOImpl implements SuppliesStocksDAO{

	private SqlMapClient sqlMapClient;
	
	
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}

	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	@SuppressWarnings("unchecked")
	public List<SuppliesStocks> getSuppliesStocks() throws SQLException {
		return this.getSqlMapClient().queryForList("getSuppliesStocks");
	}
	
	@SuppressWarnings("unchecked")
	public List<SuppliesStocks> getSupplies() throws SQLException {
		return this.getSqlMapClient().queryForList("getSuppliesList");
	}

	@SuppressWarnings("unchecked")
	public List<SuppliesStocks> searchSuppliesStocks(HttpServletRequest request) throws SQLException {
		
		SuppliesStocks stocks  = new SuppliesStocks();
		
		stocks.setItemName(request.getParameter("itemName"));
		
		return this.getSqlMapClient().queryForList("searchSuppliesStocks", stocks);
	}
	
	@Override
	public void insertStocks(HttpServletRequest request) throws SQLException, ParseException{
		
			try {
				this.sqlMapClient.startTransaction();
				this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
				this.sqlMapClient.startBatch();
				
				SuppliesStocks stocks = new SuppliesStocks();
				
				stocks.setIdSupply(Integer.parseInt(request.getParameter("idSupply")));
				stocks.setQty(Integer.parseInt(request.getParameter("qty")));
				stocks.setNumReference(request.getParameter("refNo"));
				stocks.setDateAdded(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dateAdded")));
				
				if (request.getParameter("datePurchased") != "") {
					stocks.setDatePurchased(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("datePurchased")));
				}
				stocks.setUser(request.getParameter("user"));
				
				this.getSqlMapClient().insert("insertStocks", stocks);
				this.getSqlMapClient().update("updateSupplies", stocks);
				this.sqlMapClient.executeBatch();
				
				request.setAttribute("insertResult", "successful");
			} catch (SQLException e) {
				
				this.sqlMapClient.getCurrentConnection().rollback();
				request.setAttribute("insertResult", "failed");
				
			} finally {
				this.sqlMapClient.getCurrentConnection().commit();
			}
	}

	@Override
	public void updateStocks(HttpServletRequest request) throws SQLException, ParseException {
		try {
			this.sqlMapClient.startTransaction();
			this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
			this.sqlMapClient.startBatch();
			
			SuppliesStocks stocks = new SuppliesStocks();
			
			stocks.setIdStock(Integer.parseInt(request.getParameter("idStock")));
			stocks.setIdSupply(Integer.parseInt(request.getParameter("idSupply")));
			stocks.setQty(Integer.parseInt(request.getParameter("qty")));
			stocks.setNumReference(request.getParameter("refNo"));
			stocks.setUser(request.getParameter("user"));
			stocks.setPrevQty(Integer.parseInt(request.getParameter("prevQty")));
			stocks.setDateAdded(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dateAdded")));
			
			if (request.getParameter("datePurchased") != "") {
				stocks.setDatePurchased(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("datePurchased")));
			}
				
			this.getSqlMapClient().update("updateStocks", stocks);
			this.getSqlMapClient().update("updateSupplies2", stocks);
			
			this.sqlMapClient.executeBatch();
			request.setAttribute("updateResult", "successful");
		} catch (Exception e) {
			this.sqlMapClient.getCurrentConnection().rollback();
			request.setAttribute("updateResult", "failed");
		} finally {
			this.sqlMapClient.getCurrentConnection().commit();
		};
	}
}
