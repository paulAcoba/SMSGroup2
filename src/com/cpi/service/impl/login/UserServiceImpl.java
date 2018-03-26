package com.cpi.service.impl.login;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cpi.dao.login.UserDAO;
import com.cpi.entity.login.User;
import com.cpi.service.login.UserService;

public class UserServiceImpl implements UserService {

	private UserDAO userDAO;

	public UserDAO getUserDAO() {
		return userDAO;
	}

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	public List<User> getUser() throws SQLException {
		return userDAO.getUser();
	}

	@Override
	public String getLogin(HttpServletRequest request) {

		String message = "";
		String log_user = request.getParameter("username");
		String log_pass = request.getParameter("password");

		ApplicationContext applicationContext = new ClassPathXmlApplicationContext(
				"/com/cpi/resource/applicationContext.xml");

		UserService userService = (UserService) applicationContext.getBean("userService");

		List<User> l = new ArrayList<>();

		String test = log_user;
		// System.out.println(log_user);
		try {
			l = userService.getUser();
			HttpSession session = request.getSession();
			int counter = session.getAttribute("sesCounter") == null ? 0 : (int) session.getAttribute("sesCounter");

			for (User e : l) {
				if ((e.getUserId().equals(log_user)) && (e.getPassword().equals(log_pass))
						&& !(e.getUserId().equals(e.getPassword()))) {
					if ("Y".equals(e.getActiveTag())) {
						if ("A".equals(e.getAccessLevel())) {
							List detailsList = new ArrayList();

							detailsList.add(e.getUserId());
							detailsList.add(e.getPassword());
							detailsList.add(e.getFirstName());
							detailsList.add(e.getLastName());
							detailsList.add(e.getMiddleInitial());
							detailsList.add(e.getEmail());
							detailsList.add(e.getActiveTag());
							detailsList.add(e.getAccessLevel());
							detailsList.add(e.getEntryDate());
							detailsList.add(e.getLastLogin());
							detailsList.add(e.getLastUser());

							session.setAttribute("active", detailsList);

							/*
							 * User myList = new User(); myList = e;
							 * session.setAttribute("activeUser", myList);
							 */

							message = "accessAdmin";
						} else {
							List detailsList = new ArrayList();

							detailsList.add(e.getUserId());
							detailsList.add(e.getPassword());
							detailsList.add(e.getFirstName());
							detailsList.add(e.getLastName());
							detailsList.add(e.getMiddleInitial());
							detailsList.add(e.getEmail());
							detailsList.add(e.getActiveTag());
							detailsList.add(e.getAccessLevel());
							detailsList.add(e.getEntryDate());
							detailsList.add(e.getLastLogin());
							detailsList.add(e.getLastUser());

							session.setAttribute("active", detailsList);

							message = "accessUser";
						}

					} else {
						message = "blocked";
					}
					break;
				}else if (((e.getUserId().equals(log_user)) && !(e.getPassword().equals(log_pass))
						&& !(e.getUserId().equals(e.getPassword())))) {
					System.out.println("test for not same");
					counter = counter + 1;
					session.setAttribute("sesCounter", counter);
					System.out.println("counter: " + counter);
					request.setAttribute("callSesCounter", counter);

					if (counter >= 3) {

						counter = 0;
						session.setAttribute("sesCounter", counter);
						request.setAttribute("callSesCounter", counter);
						message = "blocked";
						userService.updateUser(request);
					} else {
						message = "incorrectPw";
					}

				} else if ((e.getUserId().equals(log_user)) && (e.getPassword().equals(log_pass))
						&& (e.getUserId().equals(e.getPassword()))) {
					if((e.getActiveTag().equals("Y"))){
						List detailsList = new ArrayList();

						detailsList.add(e.getUserId());
						detailsList.add(e.getPassword());
						detailsList.add(e.getFirstName());
						detailsList.add(e.getLastName());
						detailsList.add(e.getMiddleInitial());
						detailsList.add(e.getEmail());
						detailsList.add(e.getActiveTag());
						detailsList.add(e.getAccessLevel());
						detailsList.add(e.getEntryDate());
						detailsList.add(e.getLastLogin());
						detailsList.add(e.getLastUser());

						session.setAttribute("active", detailsList);
						message = "newAccount";
						
					}
					else{
						message = "blocked";
					}
					
				} else if((e.getUserId().equals(log_user)) && !(e.getPassword().equals(log_pass))
						&& (e.getUserId().equals(e.getPassword()))){
					
					System.out.println("test for same");
					counter = counter + 1;
					session.setAttribute("sesCounter", counter);
					System.out.println("counter: " + counter);
					request.setAttribute("callSesCounter", counter);

					if (counter >= 3) {

						counter = 0;
						session.setAttribute("sesCounter", counter);
						request.setAttribute("callSesCounter", counter);
						message = "blocked";
						userService.updateUser(request);
					} else {
						message = "incorrectPw";
					}
				}
				/*else if (!(e.getUserId().equals(log_user)) && !(e.getPassword().equals(log_pass)) && !(e.getUserId().equals(e.getPassword()))) || (!(e.getUserId().equals(log_user)) && (e.getPassword().equals(log_pass)) && !(e.getUserId().equals(e.getPassword()))) || (!(e.getUserId().equals(log_user)) && !(e.getPassword().equals(log_pass)) && !(e.getUserId().equals(e.getPassword()))) || (!(e.getUserId().equals(log_user)) && (e.getPassword().equals(log_pass)) && (e.getUserId().equals(e.getPassword())))){
					counter = 0;
					session.setAttribute("sesCounter", counter);
					request.setAttribute("callSesCounter", counter);
				}*/
			}
			return message;
		} catch (SQLException e) {
			e.printStackTrace();
			return message = "";
		}
	}

	@Override
	public void updateUser(HttpServletRequest request) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("userId", request.getParameter("username"));
		params.put("activeTag", "N");
		this.getUserDAO().updateUser(params);
	}

}
