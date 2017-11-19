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
				
				<div class="content-box-header">
					
					<h3>water price information</h3>
					<div>
					<c:if test="${usertype==2 }">
					<a id="add" href="<%=path %>/getcompanyinfoForedit.do?id=${user.id }" target="main" >Edit individual information</a>
					</c:if>
					</div>
					<div class="clear"></div>
					
				</div> <!-- End .content-box-header -->
				
				<div class="content-box-content">
						<div id="showerr" class="notification information2 png_bg">
							<div id="erreinfo" style="text-align:center;font-size:16px; font-weight:bold">
								Username:${userinfo.username}
							</div>
							</div>
							<div class="title2">Telephone：${userinfo.phone}</div>
					<div class="tab-content default-tab" id="tab1" style="text-indent:2em;"> 
					<!-- This is the target div. id must match the href of this div's tab -->
						
						Address:${userinfo.address}
						
					</div> <!-- End #tab1 -->
					
					
				</div> <!-- End .content-box-content -->
				
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
