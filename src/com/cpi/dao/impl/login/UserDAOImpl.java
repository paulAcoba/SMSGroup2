package com.cpi.dao.impl.login;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.cpi.dao.login.UserDAO;
import com.cpi.entity.login.User;
import com.ibatis.sqlmap.client.SqlMapClient;

public class UserDAOImpl implements UserDAO{
	
private SqlMapClient sqlMapClient;
	
	public SqlMapClient getSqlMapClient(){
		return sqlMapClient;
	}
	
	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}
	
	@SuppressWarnings("unchecked")
	public List<User> getUser() throws SQLException {
		return this.getSqlMapClient().queryForList("getUser");
	}
	
	@Override
	public void updateUser(Map<String, Object> params) throws SQLException {
		try{
			this.sqlMapClient.startTransaction();
			this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
			this.sqlMapClient.startBatch();

			this.sqlMapClient.update("updateUser", params);
			this.sqlMapClient.executeBatch();
			this.sqlMapClient.getCurrentConnection().commit();
		}
		catch (SQLException e){
			this.sqlMapClient.getCurrentConnection().rollback();
			throw e;
		}
		finally{
			this.sqlMapClient.endTransaction();
		}
		
	}
	
}
