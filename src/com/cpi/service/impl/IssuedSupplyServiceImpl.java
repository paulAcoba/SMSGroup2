package com.cpi.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.cpi.dao.IssuedSupplyDAO;
import com.cpi.entity.IssuedSupply;
import com.cpi.service.IssuedSupplyService;

public class IssuedSupplyServiceImpl implements IssuedSupplyService{

		private IssuedSupplyDAO issuedSupplyDao;

		public IssuedSupplyDAO getIssuedSupplyDao() {
			return issuedSupplyDao;
		}

		public void setIssuedSupplyDao(IssuedSupplyDAO issuedSupplyDao) {
			this.issuedSupplyDao = issuedSupplyDao;
		}
		

		public void getAllItem(HttpServletRequest request) throws SQLException{
			List<IssuedSupply> list = this.getIssuedSupplyDao().getAllItems();
			System.out.println(list);
			request.setAttribute("allItems", list);
		}
		
		public void addIssuedSupply(HttpServletRequest request) throws SQLException{
			/*Map<String, Object> params = new*/
		}
		
		public void updateIssuedSupply(HttpServletRequest request) throws SQLException{
			
		}
		
		public void getAllIssuedSupplyById(HttpServletRequest request) throws SQLException{
			
		}
		
		public void getAllIssuedSupply(HttpServletRequest request) throws SQLException{
			
		}
		
}
