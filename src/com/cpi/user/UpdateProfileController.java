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
import com.cpi.exception.EmptyFieldException;
import com.cpi.exception.InvalidCharacterException;
import com.cpi.userservice.UserService;

public class UpdateProfileController extends HttpServlet{

	private static final long serialVersionUID = 4269975976201580589L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		doPost(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession();
		String page="";
		User newUser = new User();
		User activeUser = new User();
		activeUser = (User)session.getAttribute("activeUser");
		
		newUser.setUserId(request.getParameter("userId"));
		newUser.setPassword(request.getParameter("password"));
		newUser.setFirstName(request.getParameter("firstName"));
		newUser.setLastName(request.getParameter("lastName"));
		newUser.setMiddleInitial(request.getParameter("middleInitial"));
		newUser.setEmail(request.getParameter("email"));
		newUser.setAccessLevel(request.getParameter("accessLevel"));
		newUser.setActiveTag(request.getParameter("activeTag"));
		
		try {
			ApplicationContext applicationContext = new ClassPathXmlApplicationContext("/com/cpi/resources/applicationContext.xml");
			UserService userService = (UserService) applicationContext.getBean("userService");
			
			if(request.getParameter("userType").equals("user")) {
				User activeUser2 = new User();
				activeUser2 = (User)session.getAttribute("activeUser");
				request.setAttribute("userId", activeUser2.getUserId());
				request.setAttribute("password", activeUser2.getPassword());
				request.setAttribute("firstName", activeUser2.getFirstName());
				request.setAttribute("lastName", activeUser2.getLastName());
				request.setAttribute("middleInitial", activeUser2.getMiddleInitial());
				request.setAttribute("email", activeUser2.getEmail());
				newUser.setUserId(activeUser.getUserId());
				page = "UserUpdateProfilePage.jsp";
				userService.updateProfile(newUser);
				session.setAttribute("activeUser", newUser);
				activeUser2 = newUser;
				request.setAttribute("userId", activeUser2.getUserId());
				request.setAttribute("password", activeUser2.getPassword());
				request.setAttribute("firstName", activeUser2.getFirstName());
				request.setAttribute("lastName", activeUser2.getLastName());
				request.setAttribute("middleInitial", activeUser2.getMiddleInitial());
				request.setAttribute("email", activeUser2.getEmail());
				
			} else if(request.getParameter("userType").equals("admin")) {
				newUser.setUserId(request.getParameter("userId"));
				page = "AdminUserListingPage.jsp";
				userService.updateProfileAdmin(newUser);
				
			}
			
			
		}  catch(AboveMaximumCharactersException e) {
			newUser.setPassword(activeUser.getPassword());
			request.setAttribute("serviceResponse", "aboveMaximumCharacters");
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		} catch(InvalidCharacterException e) {
			request.setAttribute("serviceResponse", "invalidCharacter");
			request.setAttribute("errorField", e.getErrorField());
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		} catch(EmptyFieldException e) {
			request.setAttribute("serviceResponse", "emptyField");
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		} catch(SQLException e) {
			request.setAttribute("serviceResponse", "SQLException");
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);

		} finally {
			request.setAttribute("serviceResponse", "okay");
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}
}
