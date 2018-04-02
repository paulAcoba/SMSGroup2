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

import com.cpi.entity.User;
import com.cpi.exception.AboveMaximumCharactersException;
import com.cpi.exception.BelowMinimumCharactersException;
import com.cpi.exception.EmptyFieldException;
import com.cpi.exception.InvalidCharacterException;
import com.cpi.exception.WrongPasswordException;
import com.cpi.userservice.UserService;

public class UpdatePasswordController extends HttpServlet{

	private static final long serialVersionUID = 8688541986644975084L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		doPost(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession();
		User activeUser = new User();
		User currentUser = new User();
		User newUser = new User();
		activeUser = (User)session.getAttribute("activeUser");
		currentUser.setPassword(request.getParameter("currentPassword"));
		newUser.setAccessLevel(activeUser.getAccessLevel());
		newUser.setActiveTag(activeUser.getAccessLevel());
		newUser.setEmail(activeUser.getEmail());
		newUser.setFirstName(activeUser.getFirstName());
		newUser.setLastName(activeUser.getLastName());
		newUser.setLastUser(activeUser.getUserId());
		newUser.setMiddleInitial(activeUser.getMiddleInitial());
		newUser.setUserId(activeUser.getUserId());
		newUser.setPassword(request.getParameter("newPassword"));
		String page = "";
		if(activeUser.getAccessLevel().equals("U")) {
			page = "UserUpdateProfilePage.jsp";
			request.setAttribute("userType", "user");
			session.setAttribute("accessLevel", "U");
		} else if(activeUser.getAccessLevel().equals("A")) {
			page = "AdminUserListingPage.jsp";
			request.setAttribute("userType", "admin");
			session.setAttribute("accessLevel", "A");
		}
		
		
		try {
			ApplicationContext applicationContext = new ClassPathXmlApplicationContext("/com/cpi/resources/applicationContext.xml");
			UserService userService = (UserService) applicationContext.getBean("userService");
			userService.updatePassword(activeUser, currentUser, newUser);
			
			
			
		} catch(InvalidCharacterException e) {
			request.setAttribute("serviceResponse", "invalidCharacter");
			request.setAttribute("errorField", e.getErrorField());
			RequestDispatcher rd = request.getRequestDispatcher("UserChangePasswordProfilePage.jsp");
			rd.forward(request, response);
			
		}  catch(EmptyFieldException e){
			request.setAttribute("serviceResponse", "emptyField");
			RequestDispatcher rd = request.getRequestDispatcher("UserChangePasswordProfilePage.jsp");
			rd.forward(request, response);
			
		} catch(WrongPasswordException e) {
			newUser.setPassword(activeUser.getPassword());
			request.setAttribute("serviceResponse", "wrongPassword");
			
			RequestDispatcher rd = request.getRequestDispatcher("UserChangePasswordProfilePage.jsp");
			rd.forward(request, response);
			
		} catch(AboveMaximumCharactersException e) {
			newUser.setPassword(activeUser.getPassword());
			request.setAttribute("serviceResponse", "aboveMaximumCharacters");
			RequestDispatcher rd = request.getRequestDispatcher("UserChangePasswordProfilePage.jsp");
			rd.forward(request, response);
			
		} catch(BelowMinimumCharactersException e) {
			newUser.setPassword(activeUser.getPassword());
			request.setAttribute("serviceResponse", "belowMinimumCharacters");
			RequestDispatcher rd = request.getRequestDispatcher("UserChangePasswordProfilePage.jsp");
			rd.forward(request, response);
			
		} catch(SQLException e) {
			newUser.setPassword(activeUser.getPassword());
			request.setAttribute("serviceResponse", "SQLException");
			RequestDispatcher rd = request.getRequestDispatcher("UserChangePasswordProfilePage.jsp");
			rd.forward(request, response);
			
		} finally {
			
			newUser.setAccessLevel(activeUser.getAccessLevel());
			newUser.setActiveTag(activeUser.getActiveTag());
			newUser.setEmail(activeUser.getEmail());
			newUser.setFirstName(activeUser.getFirstName());
			newUser.setLastName(activeUser.getLastName());
			newUser.setLastUser(activeUser.getUserId());
			newUser.setMiddleInitial(activeUser.getMiddleInitial());
			newUser.setUserId(activeUser.getUserId());
			newUser.setPassword(request.getParameter("newPassword"));
			
			request.setAttribute("userId", activeUser.getUserId());
			request.setAttribute("password", activeUser.getPassword());
			request.setAttribute("firstName", activeUser.getFirstName());
			request.setAttribute("lastName", activeUser.getLastName());
			request.setAttribute("middleInitial", activeUser.getMiddleInitial());
			request.setAttribute("email", activeUser.getEmail());
			session.setAttribute("activeUser", newUser);
			request.setAttribute("serviceResponse", "okay");
			session.setAttribute("accessLevel", newUser.getAccessLevel());
			RequestDispatcher rd = request.getRequestDispatcher("pages/homeUser.jsp");
			rd.forward(request, response);
		}
	}
}
