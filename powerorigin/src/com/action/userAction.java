package com.action;



import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import util.Pager;
import util.PagerService;

import com.java.dao.AdminDAO;
import com.java.dao.PowerDAO;
import com.java.dao.UserDAO;
import com.java.dao.WaterDAO;
import com.java.po.Power;
import com.java.po.User;
import com.java.po.Water;

public class userAction extends MultiActionController {
	UserDAO userdao = new UserDAO();
	private PagerService pageservice = new PagerService();
	private Pager pager;
	/*
	 * 获得用户列表分页信息
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView list(HttpServletRequest request,
			HttpServletResponse response) throws ParseException, IOException {
		pager = pageservice.getPager(request.getParameter("currentPage"),
				request.getParameter("pagerMethod"), gettotals());
		List<User> list = new ArrayList<User>();
		list = userdao.findAll(pager.getStartRow(),pager.getPageSize());
		ModelAndView mav = new ModelAndView("user/listUser");
		mav.addObject("userlist", list);
		mav.addObject("pager", pager);
		return mav;
	}
	public int gettotals() {
		return userdao.getRows();
	}
	/*
	 * 添加用户
	 */
	public void add(HttpServletRequest request,
			HttpServletResponse response) throws ParseException, IOException {
			User  user= new User();
			user.setLoginname(request.getParameter("loginname"));
			user.setPassword(request.getParameter("password"));
			user.setAddress(request.getParameter("address"));
			user.setPhone(request.getParameter("phone"));
			if(request.getParameter("name")!=null)
				user.setUsername(request.getParameter("name"));
		if (userdao.findByLoginname(request.getParameter("loginname")) == null) {
			userdao.save(user);
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
		User  user= new User();
		// DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		user = userdao.findById(Integer.parseInt(request
				.getParameter("id")));
		user.setPassword(request.getParameter("password"));
		user.setAddress(request.getParameter("address"));
		user.setPhone(request.getParameter("phone"));
		if(request.getParameter("name")!=null)
			user.setUsername(request.getParameter("name"));
		userdao.attachDirty(user);
		request.getSession().setAttribute("user",user);
		response.getWriter().print(true);
//		response.sendRedirect("listuser.do");
	}
	
	/*
	 * 通过id获得信息跳转到编辑页面
	 */
	public ModelAndView show(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		User user = new User();
		user = userdao.findById(Integer.parseInt(request
				.getParameter("id")));
		ModelAndView mav = new ModelAndView("user/editUser");
		mav.addObject("userinfo", user);
		return mav;
	}
	
	/*
	 * 通过id获得信息
	 */
	public ModelAndView showInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		User user = new User();
		user = userdao.findById(Integer.parseInt(request
				.getParameter("id")));
		ModelAndView mav = new ModelAndView("user/showInfo");
		mav.addObject("userinfo", user);
		return mav;
	}
	/*
	 * 通过id删除信息
	 */
	public void delete(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		String id = request.getParameter("id").toString();
		userdao.delete(Integer.parseInt(id));
		response.getWriter().print("1");
	}
	
	/*
	 * 通过 登陆名获得用户信息判断用户是否存在
	 */
	public  void getInfoByLoginname(HttpServletRequest request, HttpServletResponse response)
	throws IOException {
		AdminDAO adminstratordao = new AdminDAO();
		if(userdao.findByLoginname(request.getParameter("loginname"))!=null
				|| adminstratordao.findByLoginname(request.getParameter("loginname"))!=null)
		{
			response.getWriter().print(true);
			
		}else
		response.getWriter().print(false);
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView  getAllInfo(HttpServletRequest request, HttpServletResponse response)
	throws IOException {
		PowerDAO powerdao = new PowerDAO();
		WaterDAO waterdao = new WaterDAO();
		
		User user = (User) request.getSession().getAttribute(
				"user");
		List<Power> list = new ArrayList<Power>();
		list = powerdao.findByUserId(user.getId());
		
		List<Water> list1 = new ArrayList<Water>();
		list1=waterdao.findByUserId(user.getId());
		ModelAndView mav = new ModelAndView("user/showPowerAndWatrerInfo");
		mav.addObject("powerlist", list);
		mav.addObject("waterlist", list1);
		return mav;
	}
}
