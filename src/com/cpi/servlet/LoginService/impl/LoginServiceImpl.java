package com.cpi.servlet.LoginService.impl;

import javax.servlet.http.HttpServletRequest;

import com.cpi.servlet.LoginService.LoginService;
import com.cpi.servlet.entity.Login;


public class LoginServiceImpl implements LoginService{

	@Override
	public String getLogin(HttpServletRequest request) {

		String message = "";
		
		
		int counter = 0;
		
		String log_user = request.getParameter("username");
		String log_pass = request.getParameter("password");
		
		if((log_user.equals("admin")) && (log_pass.equals("123456"))){
			message = "ok";
			counter = 0;
		}
		else{
			counter += 1;
			if(counter >= 3){
				System.out.println("asd");
				message = "blocked";
			}
		}


		return message;
	}
}
