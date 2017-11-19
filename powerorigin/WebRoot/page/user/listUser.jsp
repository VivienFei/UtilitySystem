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
					
					<h3>User Information</h3>
					<div >
					<c:if test="${usertype==0 }">
						<a id="add" href="#">Add User</a>
					</c:if>
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
							
								   <th>Loginname</th>
								   <th>Username</th>
								   <th>Address</th>
								   <th>TELEPHONE</th>
								 <c:if test="${usertype==0 }">
								   <th style="width:40px">Manipulate</th>
								   </c:if>
								</tr>
								
							</thead>
						 
							
							<tbody>
							<c:forEach items="${userlist}" var="item" >

								<tr>
									
									<td><a href="<%=path %>/showUserInfo.do?id=${item.id }" title="${item.username }">${item.loginname }</a></td>
									<td>${item.username }</td>
									<td>${item.address}</td>
									<td>${item.phone }</td>
									 <c:if test="${usertype==0 }">
									<td>
										<!-- Icons -->
										 <a href="<%=path %>/getUserEdit.do?id=${item.id }" title="Edit"><img src="<%=path %>/page/admin/resources/images/icons/pencil.png" alt="Edit" /></a>
										 <a href="#" class="Deletea" data-value="${item.id}" >
										 	<img src="<%=path %>/page/admin/resources/images/icons/cross.png" alt="Delete" />
										 </a> 
										</td>
										</c:if>
								</tr>
					 </c:forEach>
								
							</tbody>
							
						</table>
						
					</div> <!-- End #tab1 -->
					
					
				</div> <!-- End .content-box-content -->
				<div class="pagestyle">
					
						 [<a href="<%=path %>/listUser.do?currentPage=${pager.currentPage}&pagerMethod=first">Front pate</a>]
						 [<a href="<%=path %>/listUser.do?currentPage=${pager.currentPage}&pagerMethod=previous">Pre</a>]
					Total[ ${pager.currentPage}/<b>${pager.totalPages }</b>]pages
						 [<a href="<%=path %>/listUser.do?currentPage=${pager.currentPage}&pagerMethod=next">Next</a>]
						  [<a href="<%=path %>/listUser.do?currentPage=${pager.currentPage}&pagerMethod=last">End</a>]
					</div>
					<div class="clear"></div>
			</div> <!-- End .content-box -->
			</div>
			
			<div class="clear"></div>

			<!-- End Notifications -->
			
			<div id="footer">
				<small>  Powered by jin
				</small>
			</div><!-- End #footer -->
			
		</div> <!-- End #main-content -->
		<script type="text/javascript">
			$(document).ready(function(){
				//$("tbody>tr:even").addClass("alt-rows");
				$("#add").click(function(){
				
					window.location.href="<%=path %>/page/user/addUser.jsp";
				});
				$(".Deletea").click(function(){
					var tmpid=$(this).attr("data-value");
					$.post("<%=path %>/deleteUser.do",
					{
						id:$(this).attr("data-value")
					},function(data,textStatus){
					if(data==1){
				
							$("#erreinfo").html("Delete！");
							$("tr:has(a[data-value="+tmpid+"])").remove();
							
							$("#showerr").show();
							$("#showerr").slideUp(3000);
						}
						
					});
				});
			 
			});
	</script>
		
</body>
 

</html>
