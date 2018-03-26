package com.cpi.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.cpi.entity.SupplyType;
import com.cpi.exceptions.NoSupplyTypeIdFound;

public interface SupplyTypeService {
	List<SupplyType> getSupplyType() throws SQLException;
	List<SupplyType> getMaxSupplyTypeId(HttpServletRequest req) throws SQLException;
	List<SupplyType> searchSupplyType(HttpServletRequest req) throws SQLException, NoSupplyTypeIdFound;
	void insertSupplyType(HttpServletRequest req) throws SQLException;
	void deleteSupplyType() throws SQLException;
	void updateSupplyType(HttpServletRequest req) throws SQLException;
}
