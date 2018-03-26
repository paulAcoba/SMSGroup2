package com.cpi.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.cpi.entity.Departments;
import com.cpi.entity.IssuedSupply;
import com.cpi.entity.SuppliesMaintenance;

public interface IssuedSupplyService {
	public List<SuppliesMaintenance> getAllItem() throws SQLException;
	public List<Departments> getAllDepartment() throws SQLException;
	public void addIssuedSupply(HttpServletRequest request) throws SQLException;
	public void updateIssuedSupply(HttpServletRequest request) throws SQLException;
	public List<IssuedSupply> getAllIssuedSupplyById(HttpServletRequest request) throws SQLException;
	public List<IssuedSupply> getAllIssuedSupply() throws SQLException;
}
