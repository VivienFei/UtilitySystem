<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
		
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		<title>Simpla Admin</title>
		
		<!--                       CSS                       -->
	  
		<!-- Reset Stylesheet -->
		<link rel="stylesheet" href="<%=path %>/page/admin/resources/css/reset.css" type="text/css" media="screen" />
	  
		<!-- Main Stylesheet -->
		<link rel="stylesheet" href="<%=path %>/page/admin/resources/css/style.css" type="text/css" media="screen" />
		
		<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
		<link rel="stylesheet" href="<%=path %>/page/admin/resources/css/invalid.css" type="text/css" media="screen" />	
		
		<!-- Colour Schemes
	  
		Default colour scheme is green. Uncomment prefered stylesheet to use it.
		
		<link rel="stylesheet" href="<%=path %>/page/admin/resources/css/blue.css" type="text/css" media="screen" />
		
		<link rel="stylesheet" href="<%=path %>/page/admin/resources/css/red.css" type="text/css" media="screen" />  
	 
		-->
		
		<!-- Internet Explorer Fixes Stylesheet -->
		
		<!--[if lte IE 7]>
			<link rel="stylesheet" href="<%=path %>/page/admin/resources/css/ie.css" type="text/css" media="screen" />
		<![endif]-->
		
		<!--                       Javascripts                       -->
  
		<!-- jQuery -->
		<script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/jquery-1.3.2.min.js"></script>
		
		<!-- jQuery Configuration -->
		<script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/simpla.jquery.configuration.js"></script>
		
		<!-- Facebox jQuery Plugin -->
		<script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/facebox.js"></script>
		
		<!-- jQuery WYSIWYG Plugin -->
		<script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/jquery.wysiwyg.js"></script>
		
		<!-- jQuery Datepicker Plugin -->
		<script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/jquery.datePicker.js"></script>
		<script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/jquery.date.js"></script>
		<!--[if IE]><script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/jquery.bgiframe.js"></script><![endif]-->

		
		<!-- Internet Explorer .png-fix -->
		
		<!--[if IE 6]>
			<script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/DD_belatedPNG_0.0.7a.js"></script>
			<script type="text/javascript">
				DD_belatedPNG.fix('.png_bg, img, li');
			</script>
		<![endif]-->
		
	</head>
  
	<body><div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->
		
		<div id="sidebar"><div id="sidebar-wrapper"> <!-- Sidebar with logo and menu -->
			
			<h1 id="sidebar-title"><a href="#">Simpla Admin</a></h1>
		  
			
			<!-- Sidebar Profile links -->
			<div id="profile-links">
				Hello,<c:if test="${usertype==0}" >Admin：<a href="#" title="Edit your profile">${user.username}</a></c:if>
				<c:if test="${usertype==1}" >User：<a href="#" title="Edit your profile">${user.username}</a></c:if>
				
				<br />
				<br />
				<a href="./main.jsp" target=main title="View the Site">Back to front page</a> | 
				<a  onclick="if (confirm('Sure to exit？')) return true; else return false;" href="./login.jsp" target=_top title="Sign Out">Log out</a>
			</div>        
			
			<ul id="main-nav">  <!-- Accordion Menu -->
				
				<li>
					<a href="#" class="nav-top-item no-submenu"> <!-- Add the class "no-submenu" to menu items with no sub menu -->
						Turn off the navigation
					</a>       
				</li>
				<c:if test="${usertype==0}" >
				<li> 
					<a href="#" class="nav-top-item current"> <!-- Add the class "current" to current menu item -->
						DataManagement
					</a>
					<ul>
					
						<li><a target="main" href="<%=path %>/getAllMoneyInfo.do">Water and Power Price</a></li>
						<li><a target="main" href="<%=path %>/listUser.do">Users Information</a></li> <!-- Add class "current" to sub menu items also -->
						<li><a target="main" href="<%=path %>/listWater.do">Water Management</a></li>
						<li><a target="main" href="<%=path %>/listPower.do">Power Management</a></li>
						<li><a target="main" href="<%=path %>/listAdmin.do">Manage Admin</a></li>
						
						
					</ul>
				</li>
				</c:if>
				<li>
					<a href="#" class="nav-top-item " >
						Individual Information
					</a>
					<ul>
						
						<li><a target="main" href="<%=path %>/page/admin/changepw.jsp">Change Password</a></li>
						<c:if test="${usertype==1}" >
						<li><a target="main" href="<%=path %>/getAllMoneyAndPowerInfo.do">Water and electricity information query</a></li>
						<li><a target="main" href="<%=path %>/page/user/editUserSelf.jsp">Individual Information</a></li>
						</c:if>
					</ul>
				</li>
				 
				
			</ul> <!-- End #main-nav -->
			
			
			
		</div></div> <!-- End #sidebar -->
		 <script type="text/javascript">
			$(document).ready(function(){
			$('li > a').click(function(){
			
				if($(this).hasClass("current")){
					$(this).removeClass("current");
				}else{
					$('li > a').removeClass("current");
					$(this).addClass("current");
				}
			}
			);
			});
			</script>
			
</body>
  

</html>