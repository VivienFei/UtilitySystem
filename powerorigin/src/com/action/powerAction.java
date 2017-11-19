package com.action;



import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import util.Pager;
import util.PagerService;

import com.java.dao.AdminDAO;
import com.java.dao.MoneyDAO;
import com.java.dao.UserDAO;
import com.java.dao.PowerDAO;
import com.java.po.Admin;
import com.java.po.Money;
import com.java.po.User;
import com.java.po.Power;
import com.java.po.Water;

public class powerAction extends MultiActionController {
	PowerDAO powerdao = new PowerDAO();
	MoneyDAO moneydao=new MoneyDAO();
	UserDAO userdao = new UserDAO();
	private PagerService pageservice = new PagerService();
	private Pager pager;
	/*
	 * 获得水费列表
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView list(HttpServletRequest request,
			HttpServletResponse response) throws ParseException, IOException {
		List<Power> list = new ArrayList<Power>();
		pager = pageservice.getPager(request.getParameter("currentPage"),
				request.getParameter("pagerMethod"), gettotals());
		list = powerdao.findAll(pager.getStartRow(),pager.getPageSize());
		Money money=moneydao.findLastById();
		ModelAndView mav = new ModelAndView("power/listPower");
		mav.addObject("powerlist", list);
		mav.addObject("money",money);
		mav.addObject("pager", pager);
		return mav;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView  findInfoByUid(HttpServletRequest request,
			HttpServletResponse response) throws ParseException, IOException {
		List<Power> list = new ArrayList<Power>();
		list = powerdao.findByUseid( request.getParameter("uids"));
		Money money=moneydao.findLastById();
		ModelAndView mav = new ModelAndView("power/listPower");
		mav.addObject("powerlist", list);
		mav.addObject("money",money);
		return mav;
	}
	public int gettotals() {
		return powerdao.getRows();
	}
	/*
	 * 添加水费
	 */
	public void add(HttpServletRequest request,
			HttpServletResponse response) throws ParseException, IOException {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMM");
		String nowdate=format.format(new Date());
		if(powerdao.findByLoginname(request.getParameter("loginname"),nowdate).size()>0)
			
			response.getWriter().print(false);
		else
		{
			
	
			Power  power= new Power();
			power.setBeforecount(Integer.parseInt(request.getParameter("lastid")));
			power.setCount(Integer.parseInt(request.getParameter("nowid")));
			Money  money= new Money();
			if(request.getParameter("priceid")!=null)
			money=moneydao.findById(Integer.parseInt(request.getParameter("priceid")));
			else
				money=moneydao.findLastById();	
			power.setPrice(money);
			User  user= new User();
			user=userdao.findByLoginname(request.getParameter("loginname"));
			power.setTime(new Date());
			power.setUser(user);
			power.setStatus("N");
			powerdao.save(power);
			response.getWriter().print(true);
		}
	}
	
	/*
	 * 更新信息
	 */
	public void update(HttpServletRequest request, HttpServletResponse response)
			throws ParseException, IOException {
		Power  power= new Power();
		// DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		power = powerdao.findById(Integer.parseInt(request
				.getParameter("id")));
		power.setBeforecount(Integer.parseInt(request.getParameter("lastid")));
		power.setCount(Integer.parseInt(request.getParameter("nowid")));
		power.setStatus("N");
		powerdao.attachDirty(power);
		response.getWriter().print(true);
//		response.sendRedirect("listAdmin.do");
	}
	
	/*
	 * 通过loginname获得用户上月读数
	 */
	public void getBeforeCount(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Power  power= powerdao.findByUserLoginname(request.getParameter("loginname"));
		if(power!=null)
		response.getWriter().print(power.getCount());
		else
			response.getWriter().print(0);
	}
	/*
	 * 通过id获得信息
	 */
	public ModelAndView show(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Power  power= new Power();
		power = powerdao.findById(Integer.parseInt(request
				.getParameter("id")));
		ModelAndView mav = new ModelAndView("power/editPower");
		mav.addObject("powerinfo", power);
		return mav;
	}
	
	/*
	 * 通过id获得信息
	 */
	public ModelAndView showInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Power  power= new Power();
		power = powerdao.findById(Integer.parseInt(request
				.getParameter("id")));
		ModelAndView mav = new ModelAndView("power/showInfo");
		mav.addObject("powerinfo", power);
		return mav;
	}
	
	
	
	/*
	 * 通过id删除信息
	 */
	public void delete(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		String id = request.getParameter("id").toString();
		powerdao.delete(Integer.parseInt(id));
		response.getWriter().print(true);
	}
	
	/*
	 * 电费缴存
	 */
	public void review(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		Power  power= new Power();
		power = powerdao.findById(Integer.parseInt(request
				.getParameter("id")));
		power.setStatus("Y");
		Money money=moneydao.findById(power.getPrice().getId());
		money.setIsactive(0);
		try{
			powerdao.attachDirty(power);
			moneydao.attachDirty(money);
			response.getWriter().print(true);
		}catch(RuntimeException re){
			response.getWriter().print(false);
		}
		
	}
	
	/*
	 * 导出报表
	 */

	@SuppressWarnings("unchecked")
	public void exportInfo(HttpServletRequest request, HttpServletResponse response)
			throws IOException{
		try{
			List<Power> list = new ArrayList<Power>();
			list=powerdao.findAll();
			String name="User's Electricity Usage Detail Excel";
			//open file
			String filename=name+".xls";
			File file=new File(filename);
			WritableWorkbook book=
				Workbook.createWorkbook(file);
			WritableSheet sheet=book.createSheet("Firstpage",0);
			
		      sheet.mergeCells(0,0,5,0);
		       sheet.setRowView(0,500);
			   
		       sheet.setColumnView(0, 20); // 设置列的宽度
			   sheet.setColumnView(1, 20); // 设置列的宽度
			   sheet.setColumnView(2, 25); // 设置列的宽度
			   sheet.setColumnView(3, 15); // 设置列的宽度
			   sheet.setColumnView(4, 15); // 设置列的宽度
			   sheet.setColumnView(5, 25); // 设置列的宽度
			   sheet.setRowView(1, 500); // 设置行的高度
		       
			   /**
			    * 定义单元格样式
			    */
			    WritableFont wf = new WritableFont(WritableFont.ARIAL, 15,
			    WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,
			    jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色
			    WritableCellFormat wcf = new WritableCellFormat(wf); // 单元格定义
			    wcf.setBackground(jxl.format.Colour.YELLOW); // 设置单元格的背景颜色
			    wcf.setAlignment(jxl.format.Alignment.CENTRE); // 设置对齐方式
			    //定义正文字体
			    WritableFont wf1 = new WritableFont(WritableFont.ARIAL, 13,
					    WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,
					    jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色
					    WritableCellFormat wcf1 = new WritableCellFormat(wf1); // 单元格定义
					    wcf1.setAlignment(jxl.format.Alignment.CENTRE); // 设置对齐方式
					    //定义正文字体
					    WritableFont wf2 = new WritableFont(WritableFont.ARIAL, 10,
							    WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE
							    ); // 定义格式 字体 下划线 斜体 粗体 颜色
							    WritableCellFormat wcf2= new WritableCellFormat(wf2); // 单元格定义
							    wcf2.setAlignment(jxl.format.Alignment.CENTRE); // 设置对齐方式
			    /**
			    * 使用样式的单元格
			    */
			    sheet.addCell(new Label(0, 0, name, wcf)); // 普通的带有定义格式的单元格
			    sheet.addCell(new Label(0, 1, "Username",wcf1));
			    sheet.addCell(new Label(1, 1, "Telephone",wcf1));
			    sheet.addCell(new Label(2, 1, "Current Month's Usage(watts)）",wcf1));
			    sheet.addCell(new Label(3, 1, "Should Pay",wcf1));
			    sheet.addCell(new Label(4, 1, "Payment Status",wcf1));
			    sheet.addCell(new Label(5, 1, "Added Time",wcf1));
			    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			    if(list.size()!=0){
			    	Iterator<Power> alllist= list.iterator();//迭代器，java自带方法
			    	int row=2;
			    	int i=1;
			    	while(alllist.hasNext())
			    	{
			    		Power power= alllist.next();
			    		sheet.setRowView(row, 300); // 设置行的高度
			    		sheet.addCell(new Label(0, row, power.getUser().getUsername(),wcf2));
			    		sheet.addCell(new Label(1, row, power.getUser().getPhone(),wcf2));
			    		sheet.addCell(new jxl.write.Number(2,row,(int)(power.getCount()-power.getBeforecount()),wcf2));
			    		sheet.addCell(new jxl.write.Number(3,row,(power.getCount()-power.getBeforecount())*power.getPrice().getPowerprice(),wcf2));
			    		String isFund="Not paid";
			    		if(power.getStatus().equals("Y"))
			    			isFund="Paid";
			    		sheet.addCell(new Label(4,row,isFund,wcf2));
			    		sheet.addCell(new Label(5,row,format.format(power.getTime()),wcf2));
			    		i++;
			    		row++;
			    	}
			    	}else{
			    		sheet.mergeCells(0,3,4,3);//合并单元格
			    		sheet.setRowView(3, 1000); // 设置行的高度
			    		sheet.addCell(new Label(0, 3, "No information！！", wcf1)); // 普通的带有定义格式的单元格
			    	}
			    
			/*生成一个保存数字的单元格
		　　必须使用Number的完整包路径，否则有语法歧义
		　　单元格位置是第二列，第一行，值为789.123*/
			//jxl.write.Number number = new jxl.write.Number(3,2,789.123);
			//sheet.addCell(number);
		//写入数据并关闭文件
		book.write();
		book.close();
		  FileInputStream f = new FileInputStream(file);//读入流
	        byte[] fb = new byte[f.available()];//字节数组
	        f.read(fb);
	        //跳出对话框
	        response.setHeader("Content-disposition", "attachment; filename="+new String(filename.getBytes("gb2312"),"iso8859-1"));
	        ByteArrayInputStream bais = new ByteArrayInputStream(fb);//字节数组读入流
	        int b;
	        while ((b = bais.read()) != -1 ) {
	        	response.getOutputStream().write(b);
	         
	        }
	        response.getOutputStream().flush();//清空输出流
	        response.getOutputStream().close();

		}catch(Exception e)
		{
			System.out.println(e);
}
	}
}
