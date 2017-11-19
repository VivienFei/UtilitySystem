package com.action;



import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.java.dao.AdminDAO;
import com.java.dao.UserDAO;
import com.java.po.Admin;

public class adminAction extends MultiActionController {
	AdminDAO adminstratordao = new AdminDAO();
	UserDAO userdao = new UserDAO();
	/*
	 * 获得管理员列表
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView list(HttpServletRequest request,
			HttpServletResponse response) throws ParseException, IOException {
		List<Admin> list = new ArrayList<Admin>();
		list = adminstratordao.findAll();
		ModelAndView mav = new ModelAndView("admin/listAdmin");
		mav.addObject("adminlist", list);
		return mav;
	}
	
	/*
	 * 添加得管理员
	 */
	public void add(HttpServletRequest request,
			HttpServletResponse response) throws ParseException, IOException {
			Admin  admin= new Admin();
			admin.setLoginname(request.getParameter("loginname"));
			admin.setPassword(request.getParameter("password"));
			if(request.getParameter("name")!=null)
			admin.setUsername(request.getParameter("name"));
		if (adminstratordao.findByLoginname(request.getParameter("loginname")) ==null &&
				userdao.findByLoginname(request.getParameter("loginname"))==null) {
			adminstratordao.save(admin);
			response.getWriter().print(true);
		} else {
			response.getWriter().print(false);

		}
	}
	
	/*
	 * 更新信息
	 */
	public void update(HttpServletRequest request, HttpServletResponse response)
			throws ParseException, IOException {
		Admin admin = new Admin();
		// DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		admin = adminstratordao.findById(Integer.parseInt(request
				.getParameter("id")));
		admin.setLoginname(request.getParameter("loginname"));
		admin.setPassword(request.getParameter("password"));
		if(request.getParameter("name")!=null)
			admin.setUsername(request.getParameter("name"));
		adminstratordao.attachDirty(admin);
		response.getWriter().print(true);
//		response.sendRedirect("listAdmin.do");
	}
	
	/*
	 * 通过id获得信息
	 */
	public ModelAndView show(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Admin admin = new Admin();
		admin = adminstratordao.findById(Integer.parseInt(request
				.getParameter("id")));
		ModelAndView mav = new ModelAndView("admin/editAdmin");
		mav.addObject("admininfo", admin);
		return mav;
	}
	
	/*
	 * 通过id删除信息
	 */
	public void delete(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		String id = request.getParameter("id").toString();
		adminstratordao.delete(Integer.parseInt(id));
		response.getWriter().print("1");
	}
}
