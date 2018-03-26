package com.cpi.service.login;


import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.cpi.entity.login.User;

public interface UserService {
	List<User> getUser() throws SQLException;
	public String getLogin(HttpServletRequest request);
	public void updateUser(HttpServletRequest request) throws SQLException;
}

