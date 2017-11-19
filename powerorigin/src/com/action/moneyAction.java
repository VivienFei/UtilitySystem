package com.action;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.java.dao.MoneyDAO;
import com.java.po.Money;

public class moneyAction extends MultiActionController {
	MoneyDAO moneydao=new MoneyDAO();
	/*
	 * 添加水电费价格
	 */
	public void add(HttpServletRequest request,
			HttpServletResponse response) throws ParseException, IOException {
			Money  money= new Money();
			Double powerprice = Double.parseDouble(request.getParameter("powerprice"));
			Double waterprice = Double.parseDouble(request.getParameter("waterprice"));
			System.out.println("powerprice:" + powerprice + "------waterprice:" + waterprice);
			if(request.getParameter("powerprice")!=null){
				money.setPowerprice(powerprice);
			}
			if(request.getParameter("waterprice")!=null){
				money.setWaterprice(waterprice);
			}
			money.setTime(new Date());
			money.setIsactive(0);
			SimpleDateFormat format = new SimpleDateFormat("yyyyMM");
			String nowdate=format.format(new Date());
			if(moneydao.findByProperty(nowdate).size()>0)
			{
				response.getWriter().print(1);
			}
			else
			{
				try{
					moneydao.save(money);
					response.getWriter().print(true);
				}catch(RuntimeException e)
				{
					response.getWriter().print(false);
				}
			}
	}
	
	/*
	 * 获得水电费列表
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView list(HttpServletRequest request,
			HttpServletResponse response) throws ParseException, IOException {
		List<Money> list = new ArrayList<Money>();
		list = moneydao.findAll();
		for(Money m : list){
			System.out.println("电费：" + m.getPowerprice() + "------------" + "水费：" + m.getWaterprice());
		}
		ModelAndView mav = new ModelAndView("money/listMoney");
		mav.addObject("moneylist", list);
		return mav;
	}
	
	/*
	 * 通过id获得编辑信息
	 */
	public ModelAndView edit(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Money  money= new Money();
		money =moneydao.findById(Integer.parseInt(request
				.getParameter("id")));
		ModelAndView mav = new ModelAndView("money/editInfo");
		mav.addObject("moneyinfo", money);
		return mav;
	}
	 
	/*
	 * 更新信息
	 */
	public void update(HttpServletRequest request, HttpServletResponse response)
			throws ParseException, IOException {
		Money  money= new Money();
		Double powerprice = Double.parseDouble(request.getParameter("powerprice"));
		Double waterprice = Double.parseDouble(request.getParameter("waterprice"));
		System.out.println("powerprice:" + powerprice + "------waterprice:" + waterprice);
		money = moneydao.findById(Integer.parseInt(request
				.getParameter("id")));
		if(request.getParameter("powerprice")!=null)
			money.setPowerprice(powerprice);
			if(request.getParameter("waterprice")!=null)
			money.setWaterprice(waterprice);
			
		try{
			moneydao.attachDirty(money);
			response.getWriter().print(true);
		}catch(RuntimeException e)
		{
			response.getWriter().print(false);
		}
		
	}
	
	/*
	 * 通过id删除信息
	 */
	public void delete(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		String id = request.getParameter("id").toString();
		moneydao.delete(Integer.parseInt(id));
		response.getWriter().print(true);
	}
}

