package com.cpi.dao;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.cpi.entity.SupplyType;
import com.cpi.exceptions.NoSupplyTypeIdFound;

public interface SupplyTypeDAO {
	List<SupplyType> getSupplyType() throws SQLException;
	List<SupplyType> getMaxSupplyTypeId() throws SQLException;
	List<SupplyType> searchSupplyType(HttpServletRequest req) throws SQLException, NoSupplyTypeIdFound;
	void insertSupplyType(HttpServletRequest req) throws SQLException;
	void deleteSupplyType() throws SQLException;
	void updateSupplyType(HttpServletRequest req) throws SQLException;
}
