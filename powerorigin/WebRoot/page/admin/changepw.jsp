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
		<link rel="stylesheet" href="resources/css/reset.css" type="text/css" media="screen" />
	  
		<!-- Main Stylesheet -->
		<link rel="stylesheet" href="resources/css/main.css" type="text/css" media="screen" />
		
		<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
		<link rel="stylesheet" href="resources/css/invalid.css" type="text/css" media="screen" />	
		
		<!-- Colour Schemes
	  
		Default colour scheme is green. Uncomment prefered stylesheet to use it.
		
		<link rel="stylesheet" href="resources/css/blue.css" type="text/css" media="screen" />
		
		<link rel="stylesheet" href="resources/css/red.css" type="text/css" media="screen" />  
	 
		-->
		
		<!-- Internet Explorer Fixes Stylesheet -->
		
		<!--[if lte IE 7]>
			<link rel="stylesheet" href="resources/css/ie.css" type="text/css" media="screen" />
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
	
		<!--[if IE]><script type="text/javascript" src="resources/scripts/jquery.bgiframe.js"></script><![endif]-->

		
		<!-- Internet Explorer .png-fix -->
		
	</head>
  
	<body><div id="body-wrapper">
	
	
			<div class="content-box"><!-- Start Content Box -->
				
				<div class="content-box-header">
					
					<h3>Change Password</h3>

					<div class="clear"></div>
					
				</div> <!-- End .content-box-header -->
				
				<div class="content-box-content">
					
					<div class="tab-content default-tab" align="center" id="tab1"> <!-- This is the target div. id must match the href of this div's tab -->
					<form action="#" method="post">
						<div style="display:none" id="showerr" class="notification information png_bg">
							<div id="erreinfo">
								
							</div>
						</div>
								<p>
									<label>Old password:
										<input class="text-input small-input" type="password" id="oldpw" name="oldpassword" /> </label>
								</p>
								<p>
									<label>New Password:
										<input class="text-input small-input" type="password" id="newpwid" name="newpassword" /> </label>
								</p>
								<p>
									<label>Confirm:
										<input class="text-input small-input" type="password" id="repwid" name="repassword" /> </label>
								</p>
								<p><input type="submit" value="Submit" id="submitid"/><input type="reset" value="Reset"/></p>
					</form>
						
					</div> <!-- End #tab1 -->
					
					
				</div> <!-- End .content-box-content -->
				
			</div> <!-- End .content-box -->
			
			
			<div class="clear"></div>
			
		
			
			<!-- End Notifications -->
			
			<div id="footer">
				<small>  Copyright Your Company | Powered by jin
				</small>
			</div><!-- End #footer -->
			
		</div> <!-- End #main-content -->
		 <script type="text/javascript">
			$(document).ready(function(){
				$("#oldpw").val("");
				var regex=/^[0-9A-Za-z_]{6,15}$/;
					$("#submitid").click(function(){
						
					if($("#oldpw").val()==""){
					
						$("#showerr").show();
						$("#erreinfo").html("Old Password cannot be empty！");
						$("#oldpw").focus();
						    return false;
					}else if($("#newpwid").val()==""){
						$("#showerr").show();
						$("#erreinfo").html("New Password cannot be empty！");
							$("#newpwid").focus();
						    return false;
					}else if($("#repwid").val()==""){
						$("#showerr").show();
						$("#erreinfo").html("Confirm Password cannot be empty！！");
						$("#repwid").focus();
						    return false;
					}else if($("#repwid").val()!=$("#newpwid").val()){
						$("#showerr").show();
						$("#erreinfo").html("Old and New are not same！");
						$("#repwid").focus();
						    return false;
					}else if(!regex.exec($("#newpwid").val())){
						$("#showerr").show();
						$("#erreinfo").html("Password should consist of 6-15 numbers or characters！");
						$("#newpwid").focus();
						    return false;
					}else if(!regex.exec($("#repwid").val())){
						$("#showerr").show();
						$("#erreinfo").html("Password should consist of 6-15 numbers or characters！");
						$("#repwid").focus();
						    return false;
					}
					
					$.post("<%=path %>/changepw.do",
					{
						oldpassword:$("#oldpw").val(),
						newpassword:$("#newpwid").val()
					},function(data,textStatus){
					if(data==1){
							$("p").hide();
							$("#showerr").show();
							$("#erreinfo").html("Password changed successfuly！");
						}else{
							$("#showerr").show();
							$("#erreinfo").html("Wring old password！");
						}
						
					});
					return false;
				});
			});
				
		</script>
		
</body>
 
</html>
