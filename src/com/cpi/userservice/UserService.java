package com.cpi.userservice;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.cpi.entity.User;
import com.cpi.exception.AboveMaximumCharactersException;
import com.cpi.exception.BelowMinimumCharactersException;
import com.cpi.exception.DuplicateEntryException;
import com.cpi.exception.EmptyFieldException;
import com.cpi.exception.InvalidCharacterException;
import com.cpi.exception.WrongPasswordException;

public interface UserService {
	List<User> getUser() throws SQLException;
	void addUser(User user) throws SQLException, DuplicateEntryException, InvalidCharacterException, EmptyFieldException;
	public void updatePassword(User activeUser, User currentUser, User newUser) throws SQLException, WrongPasswordException, AboveMaximumCharactersException, BelowMinimumCharactersException,EmptyFieldException;
	public void updateProfile(User newUser) throws SQLException, InvalidCharacterException,EmptyFieldException;
	public void updateProfileAdmin(User newUser) throws SQLException, InvalidCharacterException,EmptyFieldException;
	public String search(String keyword) throws SQLException;
	public String getLogin(HttpServletRequest request);
	public void updateUser(HttpServletRequest request) throws SQLException;
}
