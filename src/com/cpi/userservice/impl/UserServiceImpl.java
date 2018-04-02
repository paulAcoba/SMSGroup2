package com.cpi.userservice.impl;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cpi.dao.UserDAO;
import com.cpi.entity.User;
import com.cpi.exception.AboveMaximumCharactersException;
import com.cpi.exception.BelowMinimumCharactersException;
import com.cpi.exception.DuplicateEntryException;
import com.cpi.exception.EmptyFieldException;
import com.cpi.exception.InvalidCharacterException;
import com.cpi.exception.WrongPasswordException;
import com.cpi.userservice.UserService;

public class UserServiceImpl implements UserService{
	
	private UserDAO userDAO;
	
	public UserDAO getUserDAO() {
		return userDAO;
	}
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	
	public List<User> getUser() throws SQLException {
		return userDAO.getUser();
	}
	
	public boolean checkCharacters(String string, String allowed) {
		boolean result = false;
		System.out.println(allowed);
		for(int i = 0; i < string.length(); i++) {
			if(!(allowed.indexOf(string.toLowerCase().charAt(i)) >= 0)) {
				result = true;
				break;
			}
		}
		
		return result;
	}
	
	@Override
	public void addUser(User user) throws SQLException, DuplicateEntryException, InvalidCharacterException, EmptyFieldException, AboveMaximumCharactersException {
		List<User> userList = new ArrayList<>();
		userList = this.userDAO.getUser();
		
		if(checkCharacters(user.getUserId(), "abcdefghijklmnopqrstuvwxyz_0123456789")) {
			throw new InvalidCharacterException("userId");
		}
		if(checkCharacters(user.getPassword(), "abcdefghijklmnopqrstuvwxyz0123456789")) {
			throw new InvalidCharacterException("password");
		}
		if(checkCharacters(user.getFirstName(), "abcdefghijklmnopqrstuvwxyz ")) {
			throw new InvalidCharacterException("firstName");
		}
		if(checkCharacters(user.getLastName(), "abcdefghijklmnopqrstuvwxyz ")) {
			throw new InvalidCharacterException("lastName");
		}
		if(checkCharacters(user.getMiddleInitial(), "abcdefghijklmnopqrstuvwxyz.")) {
			throw new InvalidCharacterException("middleInitial");
		}
		
		if(checkCharacters(user.getEmail(), "abcdefghijklmnopqrstuvwxyz.@0123456789")) {
			throw new InvalidCharacterException("email");
		}
		
		if("".equals(user.getUserId()) || "".equals(user.getPassword()) || "".equals(user.getFirstName()) || "".equals(user.getLastName()) || "".equals(user.getMiddleInitial()) || "".equals(user.getAccessLevel())){
			throw new EmptyFieldException();
		}
		
		if(user.getMiddleInitial().length() > 3){
			throw new AboveMaximumCharactersException();
		}
		
		for(int i = 0; i < userList.size(); i++){
			if(userList.get(i).getUserId().equals(user.getUserId())){
				throw new DuplicateEntryException("userId", userList.get(i).getUserId());
			}
		}
		this.userDAO.insertUser(user);
	}
	
	@Override
	public void updatePassword(User activeUser, User currentUser, User newUser) throws InvalidCharacterException, SQLException, WrongPasswordException, AboveMaximumCharactersException, BelowMinimumCharactersException, EmptyFieldException {
		if("".equals(currentUser.getPassword()) || "".equals(newUser.getPassword())){
			throw new EmptyFieldException();
		}
		
		if(checkCharacters(newUser.getPassword(), "abcdefghijklmnopqrstuvwxyz0123456789")) {
			throw new InvalidCharacterException("newPassword");
		}
		
		
		if(!(activeUser.getPassword().equals(currentUser.getPassword()))) {
			throw new WrongPasswordException();
		}
		
		if(newUser.getPassword().length() > 20){
			throw new AboveMaximumCharactersException();
		}
		
		if(newUser.getPassword().length() < 8){
			throw new BelowMinimumCharactersException();
		}
		
		newUser.setLastUser(newUser.getUserId());
		this.userDAO.updateUser(newUser);
		
	}
	
	@Override
	public void updateProfile(User newUser) throws SQLException, InvalidCharacterException, EmptyFieldException, AboveMaximumCharactersException {
		List<User> userList = new ArrayList<>();
		userList = this.userDAO.getUser();
		
		if(checkCharacters(newUser.getFirstName(), "abcdefghijklmnopqrstuvwxyz ")) {
			throw new InvalidCharacterException("firstName");
		}
		if(checkCharacters(newUser.getLastName(), "abcdefghijklmnopqrstuvwxyz ")) {
			throw new InvalidCharacterException("lastName");
		}
		if(checkCharacters(newUser.getMiddleInitial(), "abcdefghijklmnopqrstuvwxyz ")) {
			throw new InvalidCharacterException("middleInitial");
		}
		
		if(checkCharacters(newUser.getEmail() , "abcdefghijklmnopqrstuvwxyz.@0123456789")) {
			throw new InvalidCharacterException("email");
		}
		
		if("".equals(newUser.getFirstName()) || "".equals(newUser.getLastName()) || "".equals(newUser.getMiddleInitial())){
			throw new EmptyFieldException();
		}
		
		if(newUser.getMiddleInitial().length() > 3){
			throw new AboveMaximumCharactersException();
		}
		
		for(int i = 0; i < userList.size(); i++) {
			
			if(userList.get(i).getUserId().equals(newUser.getUserId())){
					userList.get(i).setFirstName(newUser.getFirstName());
					userList.get(i).setLastName(newUser.getLastName());
					userList.get(i).setEmail(newUser.getEmail());
					userList.get(i).setMiddleInitial(newUser.getMiddleInitial());
					userList.get(i).setLastUser(newUser.getUserId());
					
					User updatedUser = new User();
					updatedUser = userList.get(i);
					System.out.println(updatedUser.getFirstName());
					this.userDAO.updateUser(updatedUser);
					
					break;
			}
		}
	}
	
	@Override
	public void updateProfileAdmin(User newUser) throws SQLException, InvalidCharacterException, EmptyFieldException, AboveMaximumCharactersException {
		List<User> userList = new ArrayList<>();
		userList = this.userDAO.getUser();
		
		if(checkCharacters(newUser.getFirstName(), "abcdefghijklmnopqrstuvwxyz ")) {
			System.out.println("1");
			throw new InvalidCharacterException("firstName");
		}
		if(checkCharacters(newUser.getLastName(), "abcdefghijklmnopqrstuvwxyz ")) {
			System.out.println("2");
			throw new InvalidCharacterException("lastName");
		}
		if(checkCharacters(newUser.getMiddleInitial(), "abcdefghijklmnopqrstuvwxyz ")) {
			System.out.println("3");
			throw new InvalidCharacterException("middleInitial");
		}
		
		if(checkCharacters(newUser.getEmail() , "abcdefghijklmnopqrstuvwxyz.@0123456789")) {
			System.out.println("4");
			throw new InvalidCharacterException("email");
		}
		
		if("".equals(newUser.getFirstName()) || "".equals(newUser.getLastName()) || "".equals(newUser.getMiddleInitial()) || "".equals(newUser.getAccessLevel())){
			throw new EmptyFieldException();
		}
		
		if(newUser.getMiddleInitial().length() > 3){
			throw new AboveMaximumCharactersException();
		}
		
		for(int i = 0; i < userList.size(); i++) {
			
			if(userList.get(i).getUserId().equals(newUser.getUserId())){
					userList.get(i).setFirstName(newUser.getFirstName());
					userList.get(i).setLastName(newUser.getLastName());
					userList.get(i).setEmail(newUser.getEmail());
					userList.get(i).setMiddleInitial(newUser.getMiddleInitial());
					userList.get(i).setLastUser(newUser.getUserId());
					userList.get(i).setActiveTag(newUser.getActiveTag());
					userList.get(i).setAccessLevel(newUser.getAccessLevel());
					
					User updatedUser = new User();
					updatedUser = userList.get(i);
					this.userDAO.updateUser(updatedUser);
					
					break;
			}
		}
	}
	
	@Override
	public String search(String keyword) throws SQLException{
		List<User> userList = new ArrayList<>();
		userList = this.userDAO.getUser();
		
		String content = "";
		
		content = "<tr><th>User ID</th><th>First Name</th><th>Last Name</th><th>M.I.</th><th>Email</th><th>Active Tag</th><th>Access Level</th><th>Entry Date</th><th>Last Login</th><th>Last Updated By</th><th>Last Update</th></tr>";
		
		for(int i = 0; i < userList.size(); i++) {
			if(userList.get(i).getUserId().contains(keyword)){
				SimpleDateFormat sdf = new SimpleDateFormat("dd/M/yyyy");
				String lastLogin = sdf.format(userList.get(i).getLastLogin());
				String entryDate = sdf.format(userList.get(i).getEntryDate());
				String lastUpdate = sdf.format(userList.get(i).getLastUpdate());
				String email = "";
				
				if(userList.get(i).getEmail() == null) {
					email = "";
				} else {
					email = userList.get(i).getEmail();
				}
				
				
				content += "<tr .id. .class.><td>" + userList.get(i).getUserId() + "</td>" + 
						   "<td>" + userList.get(i).getFirstName() + "</td>" +
						   "<td>" + userList.get(i).getLastName() + "</td>" + 
						   "<td>" + userList.get(i).getMiddleInitial() + "</td>" + 
						   "<td>" + email + "</td>" + 
						   "<td>" + userList.get(i).getActiveTag() + "</td>" + 
						   "<td>" + userList.get(i).getAccessLevel() + "</td>" + 
						   "<td>" + entryDate + "</td>" + 
						   "<td>" + lastLogin + "</td>" + 
						   "<td>" + userList.get(i).getLastUser() + "</td>" + 
						   "<td>" + lastUpdate + "</td>" +
						   "<td hidden>" +  userList.get(i).getPassword() +
						   "</td></tr><br>";
			}
		}
		
		return content;
	}
	
	@Override
	public String getLogin(HttpServletRequest request) {

		String message = "";
		String log_user = request.getParameter("username");
		String log_pass = request.getParameter("password");

		ApplicationContext applicationContext = new ClassPathXmlApplicationContext(
				"/com/cpi/resource/applicationContext.xml");

		UserService userService = (UserService) applicationContext.getBean("userService");

		List<User> l = new ArrayList<>();

		try {
			l = userService.getUser();
			HttpSession session = request.getSession();
			int counter = session.getAttribute("sesCounter") == null ? 0 : (int) session.getAttribute("sesCounter");

			for (User e : l) {
				if ((e.getUserId().equals(log_user)) && (e.getPassword().equals(log_pass))
						&& !(e.getUserId().equals(e.getPassword()))) {
					if ("Y".equals(e.getActiveTag())) {
						if ("A".equals(e.getAccessLevel())) {
							
							counter = 0;
							session.setAttribute("sesCounter", counter);
							request.setAttribute("callSesCounter", counter);

							User myList = new User();
							myList = e;
							session.setAttribute("activeUser", myList);

							userService.updateCounter(request);

							message = "accessAdmin";
						} else {
							counter = 0;
							session.setAttribute("sesCounter", counter);
							request.setAttribute("callSesCounter", counter);
							
							User myList = new User();
							myList = e;
							session.setAttribute("activeUser", myList);
							
							userService.updateCounter(request);

							message = "accessUser";
						}

					} else {
						counter = 0;
						session.setAttribute("sesCounter", counter);
						request.setAttribute("callSesCounter", counter);
						userService.updateCounter(request);
						message = "blocked";
					}
					break;
				} else if (((e.getUserId().equals(log_user)) && !(e.getPassword().equals(log_pass))
						&& !(e.getUserId().equals(e.getPassword())))) {

					counter = Integer.parseInt(e.getCounter());
					counter = counter + 1;
					session.setAttribute("sesCounter", counter);
					System.out.println("counter: " + counter);
					request.setAttribute("callSesCounter", counter);
					userService.updateCounter(request);

					if (counter >= 3) {
						
						counter = 0;
						session.setAttribute("sesCounter", counter);
						request.setAttribute("callSesCounter", counter);
						userService.updateUser(request);
						message = "blocked";
					} else {
						counter = 0;
						session.setAttribute("sesCounter", counter);
						request.setAttribute("callSesCounter", counter);
						message = "incorrectPw";
					}

				} else if ((e.getUserId().equals(log_user)) && (e.getPassword().equals(log_pass))
						&& (e.getUserId().equals(e.getPassword()))) {
					if ((e.getActiveTag().equals("Y"))) {
						counter = 0;
						session.setAttribute("sesCounter", counter);
						request.setAttribute("callSesCounter", counter);

						User myList = new User();
						myList = e;
						session.setAttribute("activeUser", myList);

						message = "newAccount";

					} else {
						counter = 0;
						session.setAttribute("sesCounter", counter);
						request.setAttribute("callSesCounter", counter);
						message = "blocked";
					}

				} else if ((e.getUserId().equals(log_user)) && !(e.getPassword().equals(log_pass))
						&& (e.getUserId().equals(e.getPassword()))) {

					counter = Integer.parseInt(e.getCounter());
					counter = counter + 1;
					session.setAttribute("sesCounter", counter);
					System.out.println("counter: " + counter);
					request.setAttribute("callSesCounter", counter);
					if (counter >= 3) {
						
						counter = 0;
						session.setAttribute("sesCounter", counter);
						request.setAttribute("callSesCounter", counter);
						userService.updateUser(request);
						message = "blocked";
					} else {
						counter = 0;
						session.setAttribute("sesCounter", counter);
						request.setAttribute("callSesCounter", counter);
						message = "incorrectPw";
					}
				}
			}

			return message;
		} catch (SQLException e) {
			e.printStackTrace();
			return message = "";
		}
	}

	@Override
	public void updateUser(HttpServletRequest request) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("userId", request.getParameter("username"));
		params.put("activeTag", "N");
		this.getUserDAO().updateUser(params);
	}

	@Override
	public void updateCounter(HttpServletRequest request) throws SQLException {
		HttpSession session = request.getSession();
		Map<String, Object> params = new HashMap<>();
		params.put("userId", request.getParameter("username"));
		params.put("counter", session.getAttribute("sesCounter"));
		this.getUserDAO().updateCounter(params);
	}

}

