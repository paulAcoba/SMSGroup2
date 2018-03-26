package com.cpi.dao;

import java.sql.SQLException;
import java.util.List;

import com.cpi.entity.User;

public interface UserDAO {
	List<User> getUser() throws SQLException;
	void insertUser(User user) throws SQLException;
	void updateUser(User user) throws SQLException;
}
