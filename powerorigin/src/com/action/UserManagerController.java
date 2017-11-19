package com.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public class UserManagerController extends MultiActionController {
	public ModelAndView list(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("list");
		return mav;
	}

	public ModelAndView add(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("=====================");
		ModelAndView mav = new ModelAndView("add");
		return mav;
	}

	public ModelAndView edit(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("edit");
		return mav;
	}
}
