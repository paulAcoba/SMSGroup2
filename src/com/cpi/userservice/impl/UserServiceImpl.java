package com.cpi.userservice.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cpi.dao.UserDAO;
import com.cpi.entity.User;
import com.cpi.exception.DuplicateEntryException;
import com.cpi.exception.InvalidCharacterException;
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
	public void addUser(User user) throws SQLException, DuplicateEntryException, InvalidCharacterException {
		List<User> userList = new ArrayList<>();
		userList = this.userDAO.getUser();
		String serviceResponse = "";
		
		for(int i = 0; i < userList.size(); i++){
			if(userList.get(i).getUserId().equals(user.getUserId())){
				throw new DuplicateEntryException();
			} else if(user.getUserId().indexOf(" ") >= 0){
				throw new InvalidCharacterException("userId");
			} else {
			}
				this.userDAO.insertUser(user);
		}
	}	
}
