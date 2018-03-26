package com.cpi.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cpi.entity.SupplyType;
import com.cpi.exceptions.NoSupplyTypeIdFound;
import com.cpi.service.SupplyTypeService;

public class SupplyTypeServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3254083445269926470L;

	@SuppressWarnings("resource")
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String page = "supplyTypes.jsp";
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext(
				"/com/cpi/resource/applicationContext.xml");

		SupplyTypeService supplyTypeService = (SupplyTypeService) applicationContext.getBean("supplyTypeService");

		try {
			int maxId = 0;

			List<SupplyType> l = new ArrayList<>();
			String action = req.getParameter("action");
			l = supplyTypeService.getSupplyType();

			List<SupplyType> maxSupplyTypeId = new ArrayList<>();
			maxSupplyTypeId = supplyTypeService.getMaxSupplyTypeId(req);
			for (SupplyType m : maxSupplyTypeId) {
				maxId = m.getSupplyTypeId();
			}

			req.setAttribute("maxSupplyTypeId", maxId + 1);
			req.setAttribute("suppliesType", l);

			if ("save".equals(action)) {
				supplyTypeService.insertSupplyType(req);
			} else if ("cancel".equals(action)) {
				page = "manageSupplyTypes.jsp";
			} else if ("actionAddNewSupply".equals(action)) {
				page = "supplyTypes.jsp";
			} else if ("updateSupplyType".equals(action)) {
				
				supplyTypeService.updateSupplyType(req);
				List<SupplyType> n = new ArrayList<>();
				n = supplyTypeService.getSupplyType();

				req.setAttribute("suppliesType", n);
				page = "pages/refreshUpdateSupplyTypeTable.jsp";
			} else if ("search".equals(action)) {
				if (req.getParameter("supplyTypeId").equals("")) {
					req.setAttribute("suppliesType", l);
					page = "pages/selectAllSupplyTypeTable.jsp";
				} else {
					List<SupplyType> search = new ArrayList<>();
					search = supplyTypeService.searchSupplyType(req);

					req.setAttribute("suppliesTypeSearch", search);
					page = "pages/searchSupplyTypeTable.jsp";
				}
			}  else {
				req.setAttribute("suppliesType", l);
			}

		} catch (SQLException e) {

		} catch (NoSupplyTypeIdFound n) {

		} finally {

			RequestDispatcher rd = req.getRequestDispatcher(page);
			rd.forward(req, res);
		}
	}
}
