package com.cpi.userservice;

import java.sql.SQLException;
import java.util.List;

import com.cpi.entity.User;
import com.cpi.exception.DuplicateEntryException;
import com.cpi.exception.InvalidCharacterException;

public interface UserService {
	void addUser(User user) throws SQLException, DuplicateEntryException, InvalidCharacterException;
}
