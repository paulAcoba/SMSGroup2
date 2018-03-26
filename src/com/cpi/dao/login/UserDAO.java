package com.cpi.dao.login;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.cpi.entity.login.User;

public interface UserDAO {
	List<User> getUser() throws SQLException;
	public void updateUser(Map<String, Object> params) throws SQLException;
}
