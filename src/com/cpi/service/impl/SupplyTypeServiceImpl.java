package com.cpi.service.impl;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.cpi.dao.SupplyTypeDAO;
import com.cpi.entity.SupplyType;
import com.cpi.exceptions.NoSupplyTypeIdFound;
import com.cpi.service.SupplyTypeService;

public class SupplyTypeServiceImpl implements SupplyTypeService {

	private SupplyTypeDAO supplyTypeDAO;

	public SupplyTypeDAO getSupplyTypeDAO() {
		return supplyTypeDAO;
	}

	public void setsupplyTypeDAO(SupplyTypeDAO supplyTypeDAO) {
		this.supplyTypeDAO = supplyTypeDAO;
	}

	public List<SupplyType> getSupplyType() throws SQLException {
		return supplyTypeDAO.getSupplyType();
	}

	@Override
	public List<SupplyType> searchSupplyType(HttpServletRequest req) throws SQLException, NoSupplyTypeIdFound {
		System.out.println("sdfds");
		return supplyTypeDAO.searchSupplyType(req);
	}
	@Override
	public void insertSupplyType(HttpServletRequest req) throws SQLException {
		this.supplyTypeDAO.insertSupplyType(req);
	}

	@Override
	public void deleteSupplyType() throws SQLException {
		this.supplyTypeDAO.deleteSupplyType();

	}

	@Override
	public void updateSupplyType(HttpServletRequest req) throws SQLException {
		this.supplyTypeDAO.updateSupplyType(req);
	}

	@Override
	public List<SupplyType> getMaxSupplyTypeId(HttpServletRequest req) throws SQLException {
		return supplyTypeDAO.getSupplyType();
	}

	

}
