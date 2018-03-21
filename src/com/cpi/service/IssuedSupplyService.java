package com.cpi.service;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

public interface IssuedSupplyService {
	public void getAllItem(HttpServletRequest request) throws SQLException;
	public void addIssuedSupply(HttpServletRequest request) throws SQLException;
	public void updateIssuedSupply(HttpServletRequest request) throws SQLException;
	public void getAllIssuedSupplyById(HttpServletRequest request) throws SQLException;
	public void getAllIssuedSupply(HttpServletRequest request) throws SQLException;
}
