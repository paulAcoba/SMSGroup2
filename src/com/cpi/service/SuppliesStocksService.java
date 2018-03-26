package com.cpi.service;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.cpi.entity.SuppliesStocks;

public interface SuppliesStocksService {
	List<SuppliesStocks> getSuppliesStocks() throws SQLException;
	List<SuppliesStocks> getSupplies() throws SQLException;
	List<SuppliesStocks> searchSuppliesStocks(HttpServletRequest request) throws SQLException;
	void insertStocks(HttpServletRequest request) throws SQLException, ParseException;
	void updateStocks(HttpServletRequest request) throws SQLException, ParseException;
}
