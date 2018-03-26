package com.cpi.service.impl;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.cpi.dao.SuppliesStocksDAO;
import com.cpi.entity.SuppliesStocks;
import com.cpi.service.SuppliesStocksService;

public class SuppliesStocksServiceImpl implements SuppliesStocksService{
	
	private SuppliesStocksDAO suppliesStocksDAO;
	
	

	public SuppliesStocksDAO getSuppliesStocksDAO() {
		return suppliesStocksDAO;
	}

	public void setSuppliesStocksDAO(SuppliesStocksDAO suppliesStocksDAO) {
		this.suppliesStocksDAO = suppliesStocksDAO;
	}

	@Override
	public List<SuppliesStocks> getSuppliesStocks() throws SQLException {
		return suppliesStocksDAO.getSuppliesStocks();
	}
	
	@Override
	public List<SuppliesStocks> searchSuppliesStocks(HttpServletRequest request) throws SQLException {
		return suppliesStocksDAO.searchSuppliesStocks(request);
	}
	
	@Override
	public List<SuppliesStocks> getSupplies() throws SQLException {
		return suppliesStocksDAO.getSupplies();
	}
	
	@Override
	public void insertStocks(HttpServletRequest request) throws SQLException, ParseException{
		this.suppliesStocksDAO.insertStocks(request);
	}

	@Override
	public void updateStocks(HttpServletRequest request) throws SQLException, ParseException {
		this.suppliesStocksDAO.updateStocks(request);
	}
}
