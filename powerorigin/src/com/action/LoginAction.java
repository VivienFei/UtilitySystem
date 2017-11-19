package com.action;

import java.io.IOException;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.java.dao.AdminDAO;
import com.java.dao.UserDAO;
import com.java.po.Admin;
import com.java.po.User;

@Controller
public class LoginAction extends MultiActionController {
	
	
	AdminDAO adminstratordao = new AdminDAO();
	UserDAO userdao = new UserDAO();

	/*
	 * users login page
	 */
	
//	@Autowired
//	@Qualifier("adminstratordao")
//	AdminDAO adminstratordao;
//	
//	@Autowired
//	@Qualifier("userdao")
//	UserDAO userdao;
//	

	
	
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		String loginname = request.getParameter("loginname");
		String password = request.getParameter("password");
		if ( loginname == null||loginname.equals("") ) {

			ModelAndView mav = new ModelAndView("admin/login");
			mav.addObject("message", "0");// Username is empty
			return mav;

		} else {
			// if it is the administor
			if (adminstratordao.findByLoginname(loginname) != null)
			{
				Admin admin = adminstratordao.findByLoginname(loginname);
				if (admin.getPassword().equals(password)) {
					ModelAndView mav = new ModelAndView("admin/index");
					request.getSession().setAttribute("user", admin);
					request.getSession().setAttribute("usertype", 0);
					// mav.addObject("user", admin);
					return mav;
				} else {
					ModelAndView mav = new ModelAndView("admin/login");
					mav.addObject("message", "2");// incorrect password
					return mav;
				}

			} 
			else if (userdao.findByLoginname(loginname) != null)
			{// if it is user
				User  user= userdao.findByLoginname(loginname);
				if (user.getPassword().equals(password)) {
					ModelAndView mav = new ModelAndView("admin/index");
					request.getSession().setAttribute("user", user);
					request.getSession().setAttribute("usertype", 1);
					//response.getWriter().print("1");
					return mav;
	 
				} else {
					//response.getWriter().print("2");// incorrect password
					ModelAndView mav = new ModelAndView("admin/login");
					mav.addObject("message", "2");// incorrect password
					return mav;
				 
				}
			}
			ModelAndView mav = new ModelAndView("admin/login");
			mav.addObject("message", "1");// Empty username
			return mav;
		}
	
	}
	/*
	 * Change passwords
	 */
	
	@RequestMapping(value = "/changepw.do", method = RequestMethod.GET)
	public ModelAndView changePassword(HttpServletRequest request,
			HttpServletResponse response) {

		try {

			if (request.getSession().getAttribute("usertype").equals(0)) {

				Admin admin = (Admin) request.getSession()
						.getAttribute("user");

				if (!(request.getParameter("oldpassword").toString().equals(admin
						.getPassword()))){
					response.getWriter().write("0");
					return null;
				}
				admin.setPassword(request.getParameter("newpassword")
						.toString());
				adminstratordao.attachDirty(admin);
				request.getSession().setAttribute("user", admin);
				response.getWriter().write("1");
			} else if (request.getSession().getAttribute("usertype").equals(1)) {

				User user = (User) request.getSession().getAttribute(
						"user");

				if (request.getParameter("oldpassword").toString() != user
						.getPassword())
					response.getWriter().write("0");

				user.setPassword(request.getParameter("newpassword")
						.toString());
				userdao.attachDirty(user);
				request.getSession().setAttribute("user", user);
				response.getWriter().write("1");
			} 
			return null;

		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

}
