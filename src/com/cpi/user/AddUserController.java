package com.cpi.user;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cpi.dao.UserDAO;
import com.cpi.dao.impl.UserDAOImpl;
import com.cpi.entity.User;
import com.cpi.exception.AboveMaximumCharactersException;
import com.cpi.exception.DuplicateEntryException;
import com.cpi.exception.EmptyFieldException;
import com.cpi.exception.InvalidCharacterException;
import com.cpi.userservice.UserService;

public class AddUserController extends HttpServlet{

	private static final long serialVersionUID = -8159071533580115675L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		doPost(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession();
		User activeUser = new User();
		activeUser = (User)session.getAttribute("activeUser");
		User user = new User();
		
		user.setUserId(request.getParameter("userId"));
		user.setPassword(request.getParameter("password"));
		user.setFirstName(request.getParameter("firstName"));
		user.setLastName(request.getParameter("lastName"));
		user.setMiddleInitial(request.getParameter("middleInitial"));
		user.setEmail(request.getParameter("email"));
		user.setActiveTag(request.getParameter("activeTag"));
		user.setAccessLevel(request.getParameter("accessLevel"));
		user.setLastUser(activeUser.getUserId());
		

		try{
			ApplicationContext applicationContext = new ClassPathXmlApplicationContext("/com/cpi/resources/applicationContext.xml");
			UserService userService = (UserService) applicationContext.getBean("userService");
			userService.addUser(user);
			
		} catch(AboveMaximumCharactersException e) {
			request.setAttribute("serviceResponse", "aboveMaximumCharacters");
			RequestDispatcher rd = request.getRequestDispatcher("AdminAddNewUserMaintenancePage.jsp");
			rd.forward(request, response);
			
		} catch(DuplicateEntryException e){
			request.setAttribute("serviceResponse", "duplicateEntry");
			request.setAttribute("errorField", e.getErrorField());
			request.setAttribute("errorValue", e.getErrorValue());
			RequestDispatcher rd = request.getRequestDispatcher("AdminAddNewUserMaintenancePage.jsp");
			rd.forward(request, response);
			
		} catch(InvalidCharacterException e) {
			request.setAttribute("serviceResponse", "invalidCharacter");
			request.setAttribute("errorField", e.getErrorField());
			RequestDispatcher rd = request.getRequestDispatcher("AdminAddNewUserMaintenancePage.jsp");
			rd.forward(request, response);
			
		} catch(EmptyFieldException e) {
			request.setAttribute("serviceResponse", "emptyField");
			RequestDispatcher rd = request.getRequestDispatcher("AdminAddNewUserMaintenancePage.jsp");
			rd.forward(request, response);
			
		} catch(SQLException e) {
			request.setAttribute("serviceResponse", "SQLException");
			RequestDispatcher rd = request.getRequestDispatcher("AdminAddNewUserMaintenancePage.jsp");
			rd.forward(request, response);
			
		} finally {
			request.setAttribute("serviceResponse", "okay");
			RequestDispatcher rd = request.getRequestDispatcher("AdminUserListingPage.jsp");
			rd.forward(request, response);
			
		}
		 
		
	}
}
