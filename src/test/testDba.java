package test;

import java.sql.*;
import java.util.ArrayList;

public class testDba {
	public static void main(String[] args){
    	try {
        	Class.forName("oracle.jdbc.driver.OracleDriver");
            ArrayList<String> serverNames = new ArrayList<String>();
            serverNames.add("localhost");
            String portNumber = "1521";
            String sid = "TRNG";
            String url = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(LOAD_BALANCE=ON)(FAILOVER=ON)" ;
            for (String serverName : serverNames) {  
                url += "(ADDRESS=(PROTOCOL=tcp)(HOST="+serverName+")(PORT="+portNumber+"))";
            }
            url += ")(CONNECT_DATA=(SID="+sid+")))";
            String username = "sys as sysdba";
            String password = "oracle";
            // System.out.println(url); // for debugging, if you want to see the url that was built
            Connection conn = DriverManager.getConnection(url, username, password);
            System.out.println(conn);
		} catch (ClassNotFoundException a) {
			// TODO: handle exception
			System.out.println(a);
		} catch (SQLException e) {
			// TODO: handle exception
			System.out.println(e);
		}
    }
}
