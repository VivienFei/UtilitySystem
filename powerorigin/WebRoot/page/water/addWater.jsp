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
		
		<title>Simpla User</title>
		
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
					
					<h3>Add water price information</h3>

					<div class="clear"></div>
					
				</div> <!-- End .content-box-header -->
				
				<div class="content-box-content">
					
					<div class="tab-content default-tab" align="center" id="tab1"> <!-- This is the target div. id must match the href of this div's tab -->
					<div style="display:none" id="showerr" class="notification information png_bg">
							<div id="erreinfo">
								<a href="<%=path %>/index.jsp"> Back to front page</a>
							</div>
							
						</div>
					<form action="#" method="post">
						
						<div id="inputjobfair">
								<p>
									<label>Loginname:
										<input class="text-input medium-input" value="" type="text" id="loginname" name="loginno" /> <span id="showloginInfo" style="color:red;"> </span></label>
									
								</p>
								<p>
									<label>Current usage:
										<input class="text-input medium-input" value="" type="text" id="nowid"  /> <span id="showpasswordInfo" style="color:red;"> </span></label>
								</p>
								<p>
									<label>Last month's usage:
										<input class="text-input medium-input"   type="text" id="lastid"  /> </label>
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
				<small>  Powered by Jin
				</small>
			</div><!-- End #footer -->
			
		</div> <!-- End #main-content -->
		 <script type="text/javascript">
			$(document).ready(function(){
			var isExist=false;
			 			$("#loginname").val("");
				 	var patrn=/^[0-9]{1,7}$/; 
					var regex=/^[0-9A-Za-z_]{6,15}$/;
					 var patrn2=/^\d+$/; 
					$("#loginname").blur(function(){
					if($("#loginname").val()=="")
						{
							$("#showloginInfo").html("Cannot be empty");
							$("#loginname").focus();
							return;
						}
						if(!regex.exec($("#loginname").val()))
						{
							$("#showloginInfo").html("Wrong foramt");
							$("#loginname").focus();
							return;
						}
					$.post("<%=path %>/getUserByLoginname.do",
					{
						loginname:$("#loginname").val()

					},function(data,textStatus){
					if(data=="false"){
						
							$("#showloginInfo").html("User does not exists");
							isExist=true;
					
						}else{
							
							$("#showloginInfo").html("User exsits");
						}
						
					});
					
					
						$.post("<%=path %>/getWaterBeforeCount.do",
					{
						loginname:$("#loginname").val()

					},function(data,textStatus){
							$("#lastid").val(data);
						
					});
					});
					
					$("#submitid").click(function(){
						if(isExist)
						{
						$("#showerr").show();
							$("#erreinfo").html("User does not exits");
							return false;
						}
					if(!regex.exec($("#loginname").val())){
					
						$("#showerr").show();
						$("#erreinfo").html("Wrong format！");
						$("#loginname").focus();
						    return false;
					}else if(!patrn2.exec($("#nowid").val())){
						$("#showerr").show();
						$("#erreinfo").html("Should not be negative！");
						$("#nowid").focus();
						    return false;
					}else if(!patrn2.exec($("#lastid").val())){
						$("#showerr").show();
						$("#erreinfo").html("Should not be negative！");
						$("#lastid").focus();
						    return false;
					}else if(eval($("#nowid").val())<eval($("#lastid").val()))
					{
						$("#showerr").show();
						$("#erreinfo").html("Should be larger than last month！");
						$("#nowid").focus();
						 return false;
					}
					
					
					$.post("<%=path %>/addWater.do",
					{
						loginname:$("#loginname").val(),
						nowid:$("#nowid").val(),
						lastid:$("#lastid").val(),
						priceid:<%=request.getParameter("moneyid") %>
					},function(data,textStatus){
					
					if(data=="true"){
							$("p").hide();
							$("#showerr").show();
							$("#erreinfo").html("Add successfully <a href='<%=path %>/page/water/addWater.jsp'> Back</a>");
						}else{
							$("#showerr").show();
							$("#erreinfo").html("Already added the user current month<a href='<%=path %>/page/water/addWater.jsp'> Back</a>");
						}
						
					});
					return false;
				});
			});
				
		</script>
		
</body>

</html>
