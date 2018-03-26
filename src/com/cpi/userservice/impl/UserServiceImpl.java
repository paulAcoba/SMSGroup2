package com.cpi.userservice.impl;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;

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
	
	@Override
	public void addUser(User user) throws SQLException, DuplicateEntryException, InvalidCharacterException, EmptyFieldException {
		List<User> userList = new ArrayList<>();
		userList = this.userDAO.getUser();
		
		if(user.getUserId().indexOf(" ") >= 0){
			throw new InvalidCharacterException("userId");
		}
		
		if("".equals(user.getUserId()) || "".equals(user.getPassword()) || "".equals(user.getFirstName()) || "".equals(user.getLastName()) || "".equals(user.getMiddleInitial()) || "".equals(user.getAccessLevel())){
			throw new EmptyFieldException();
		}
		
		for(int i = 0; i < userList.size(); i++){
			if(userList.get(i).getUserId().equals(user.getUserId())){
				throw new DuplicateEntryException("userId", userList.get(i).getUserId());
			}
		}
		this.userDAO.insertUser(user);
	}
	
	@Override
	public void updatePassword(User activeUser, User currentUser, User newUser) throws SQLException, WrongPasswordException, AboveMaximumCharactersException, BelowMinimumCharactersException, EmptyFieldException {
		if("".equals(currentUser.getPassword()) || "".equals(newUser.getPassword())){
			throw new EmptyFieldException();
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
	public void updateProfile(User newUser) throws SQLException, InvalidCharacterException, EmptyFieldException {
		List<User> userList = new ArrayList<>();
		userList = this.userDAO.getUser();
		
		if("".equals(newUser.getFirstName()) || "".equals(newUser.getLastName()) || "".equals(newUser.getMiddleInitial())){
			throw new EmptyFieldException();
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
	public void updateProfileAdmin(User newUser) throws SQLException, InvalidCharacterException, EmptyFieldException {
		List<User> userList = new ArrayList<>();
		userList = this.userDAO.getUser();
		
		if("".equals(newUser.getFirstName()) || "".equals(newUser.getLastName()) || "".equals(newUser.getMiddleInitial()) || "".equals(newUser.getAccessLevel())){
			throw new EmptyFieldException();
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
	public User enter(User user) throws SQLException, WrongPasswordException {
		List<User> userList = new ArrayList<>();
		userList = this.userDAO.getUser();
		
		for(int i = 0; i < userList.size(); i++) {
			if(userList.get(i).getUserId().equals(user.getUserId())) {
				user = userList.get(i);
				break;
			}
		}
		return user;
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
}
