<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		<title>Simpla Admin</title>
		
		<!--                       CSS                       -->
	  
		<!-- Reset Stylesheet -->
		<link rel="stylesheet" href="<%=path %>/page/admin/resources/css/reset.css" type="text/css" media="screen" />
	
		<!-- Main Stylesheet -->
		<link rel="stylesheet" href="<%=path %>/page/admin/resources/css/main.css" type="text/css" media="screen" />
		
		<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
		<link rel="stylesheet" href="<%=path %>/page/admin/resources/css/invalid.css" type="text/css" media="screen" />	
		

		
	<!--                       Javascripts                       -->
	  
		<!-- jQuery -->
		<script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/jquery-1.3.2.min.js"></script>
		
		<!-- jQuery Configuration -->
		<script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/simpla.jquery.configuration.js"></script>
		
		<!-- Facebox jQuery Plugin -->
		<script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/facebox.js"></script>
		
		<!-- jQuery WYSIWYG Plugin -->
		<script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/jquery.wysiwyg.js"></script>
	
		<!--[if IE]><script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/jquery.bgiframe.js"></script><![endif]-->
		
	</head>
  
	<body>
	
	<div id="body-wrapper">
	 
		
			<div id="main-content">
	
			<div class="content-box"><!-- Start Content Box -->
				
				<div class="content-box-header" >
					
					<h3>Water and Electricity Price Information</h3>
					<div style="text-align:right">
					</div>
					<div class="clear"></div>
					
				</div> <!-- End .content-box-header -->
				
				<div class="content-box-content">
						<div style="display:none" id="showerr" class="notification information png_bg">
							<div id="erreinfo">
								
							</div>
							</div>
					<div class="tab-content default-tab" id="tab1"> 
					<!-- This is the target div. id must match the href of this div's tab -->
						
						<table width="100%">
							
							<thead>
								<tr>
								   <th>Num</th>
								   <th>Username</th>
								   <th>Tele</th>
								    <th>Added time</th>
								   <th>Current month's usage(gallon)</th>
								   <th>Should pay</th>
								     <th>Unit price</th>
								    <th>Payment status</th>
								</tr>
								
							</thead>
						 
							
							<tbody>
							<tr>
								<td colspan="8" style=" text-align:center;">
								<h4><span>Electricity Information:</span></h4>
								</td>
								</tr>
							<% int i=1; %>
							<c:forEach items="${powerlist}" var="item" >

								<tr>
									
									<td><%=i++ %></td>
									<td>${item.user.username }</td>
									<td>${item.user.phone }</td>
									<td><fmt:formatDate value="${item.time }" pattern="yyyy-MM-dd " /> </td>
									<td>${item.count }</td>
									<!--  <td>${(item.count-item.beforecount)*item.price.powerprice }</td>-->
									<td><fmt:formatNumber value="${(item.count-item.beforecount)*item.price.powerprice}" pattern="#.0#"/></td>
									<td>${item.price.powerprice }</td>
									<td> <c:if test="${item.status=='N' }">
										
										<span class="noactive" data-value="${item.id}" >
										<a href="#"   title="NOT Pay YET">Not Pay Yet</a>
										</span>
										</c:if>
										<c:if test="${item.status=='Y' }">
										Paid
										</c:if>
									</td>
								</tr>
							
					 </c:forEach>
								<tr>
								<td colspan="8" style=" text-align:center;">
								<h4><span>Water inforamtion:</span></h4>
								</td>
								</tr>
								
								<% int j=1; %>
							<c:forEach items="${waterlist}" var="item" >

								<tr>
									
									<td><%=j++ %></td>
									<td>${item.user.username }</td>
									<td>${item.user.phone }</td>
									<td><fmt:formatDate value="${item.time }" pattern="yyyy-MM-dd " /> </td>
									<td>${item.count }</td>
									<!-- <td>${(item.count-item.beforecount)*item.price.waterprice }</td> -->
									<td><fmt:formatNumber value="${(item.count-item.beforecount)*item.price.waterprice}" pattern="#.0#"/></td>
									<td>${item.price.waterprice }</td>
									<td> <c:if test="${item.status=='N' }">
										
										<span class="noactive" data-value="${item.id}" >
										<a href="#"   title="Not pay yet">Not pay yet</a>
										</span>
										</c:if>
										<c:if test="${item.status=='Y' }">
										Paid
										</c:if>
									</td>
								</tr>
							
					 </c:forEach>
							</tbody>
							
						</table>
						
					</div> <!-- End #tab1 -->
					
					
				</div> <!-- End .content-box-content -->
				<div class="pagestyle">
					
						 [<a href="<%=path %>/listUser.do?currentPage=${pager.currentPage}&pagerMethod=first">Front page</a>]
						 [<a href="<%=path %>/listUser.do?currentPage=${pager.currentPage}&pagerMethod=previous">Pre</a>]
					Total[ ${pager.currentPage}/<b>${pager.totalPages }</b>]page
						 [<a href="<%=path %>/listUser.do?currentPage=${pager.currentPage}&pagerMethod=next">Next</a>]
						  [<a href="<%=path %>/listUser.do?currentPage=${pager.currentPage}&pagerMethod=last">End</a>]
					</div>
					<div class="clear"></div>
			</div> <!-- End .content-box -->
			</div>
			
			<div class="clear"></div>

			<!-- End Notifications -->
			
			<div id="footer">
				<small>  Powered by Jin
				</small>
			</div><!-- End #footer -->
			
		</div> <!-- End #main-content -->
		
</body>
 
</html>
