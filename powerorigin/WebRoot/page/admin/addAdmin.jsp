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
		<link rel="stylesheet" href="<%=path %>/page/admin/resources/css/main.css" type="text/css" media="screen" />
		
		<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
		<link rel="stylesheet" href="<%=path %>/page/admin/resources/css/invalid.css" type="text/css" media="screen" />	

		
	<!--                       Javascripts                       -->
	<script type="text/javascript" src="<%=path %>/page/js/calendar.js"></script>
	
	  
		<!-- jQuery -->
		<script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/jquery-1.3.2.min.js"></script>
		
		<!-- jQuery Configuration -->
		<script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/simpla.jquery.configuration.js"></script>
		
		<!-- Facebox jQuery Plugin -->
		<script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/facebox.js"></script>
		
		<!-- jQuery WYSIWYG Plugin -->
		<script type="text/javascript" src="<%=path %>/page/admin/resources/scripts/jquery.wysiwyg.js"></script>
	
		
	</head>
  
	<body><div id="body-wrapper">
	
	
			<div class="content-box"><!-- Start Content Box -->
				
				<div class="content-box-header">
					
					<h3>Add adm</h3>

					<div class="clear"></div>
					
				</div> <!-- End .content-box-header -->
				
				<div class="content-box-content">
					
					<div class="tab-content default-tab" align="center" id="tab1"> <!-- This is the target div. id must match the href of this div's tab -->
					<div style="display:none" id="showerr" class="notification information png_bg">
							<div id="erreinfo">
								<a href="<%=path %>/index.jsp"> Back to FrontPage</a>
							</div>
							
						</div>
					<form action="#" method="post">
						
						<div id="inputjobfair">
								<p>
									<label>LoginName:
										<input class="text-input medium-input" type="text" id="loginname" name="adminno" /> </label>
								</p>
								<p>
									<label>Password:
										<input class="text-input medium-input" type="password" id="password"  /> </label>
								</p>
								<p>
									<label>UserName:
										<input class="text-input medium-input"   type="text" id="comname"  /> </label>
								</p>
						
								<p style="text-align:center">
									<input type="submit" value="Submit" id="submitid"/>
									<input type="reset" value="Reset"/>
								</p>
						</div>
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
				$("#loginname").val("");
				$("#password").val("");
				 var patrn=/^[0-9]{1,7}$/; 
					var regex=/^[0-9A-Za-z_]{6,15}$/;
					$("#submitid").click(function(){
						
					if(!regex.exec($("#loginname").val())){
					
						$("#showerr").show();
						$("#erreinfo").html("Wrong Loginname should consist of 6-15 in numbers or characters！");
						$("#loginname").focus();
						    return false;
					}else if(!regex.exec($("#password").val())){
						$("#showerr").show();
						$("#erreinfo").html("Password should consist of 6-15 in numbers or characters！！");
						$("#password").focus();
						    return false;
					}
					
					$.post("<%=path %>/addAdmin.do",
					{
						loginname:$("#loginname").val(),
						password:$("#password").val(),
						name:$("#comname").val()
						
					},function(data,textStatus){
					
					if(data=="true"){
							$("p").hide();
							$("#showerr").show();
							$("#erreinfo").html("Add Successfully！<a href='<%=path %>/listAdmin.do'> Back to the List</a>");
						}else{
							$("#showerr").show();
							$("#erreinfo").html("Fail to add！user exist!<a href='<%=path %>/listAdmin.do'> Back to the front page</a>");
						}
						
					});
					return false;
				});
			});
				
		</script>
		
</body>
 
</html>
