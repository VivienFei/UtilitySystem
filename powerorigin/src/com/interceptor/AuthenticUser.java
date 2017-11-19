package com.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.java.po.Admin;
import com.java.po.User;



/**
 * 拦截需要登录的页面
 */
public class AuthenticUser implements HandlerInterceptor {

	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
	}

	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		String path = request.getContextPath();
		String uri = request.getRequestURI();
		// System.out.println("uri--preHandle"+uri);
		
		HttpSession session = (HttpSession) request.getSession();
		User user = (User) request.getSession().getAttribute("user");
		Admin admin=(Admin)request.getSession().getAttribute("admin");
		
		if (uri.equals("/power/login.do") || uri.equals("/power")) {
			return true;
		} else if (user == null||admin==null) {
			response.sendRedirect(request.getContextPath() + "/login.do");
			return false;
		} else {
			return true;
		}
	}
}
