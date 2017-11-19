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
					
					<h3>Manage Water Price</h3>
						<div style="float:left; margin:0 px; height:20px; padding:0 px" >
					<form method="post" action="<%=path %>/findWaterInfoByUid.do">
						<p>
							<label>Userid:
							<input name="uids" type=text id="userid" />
								<input type="submit" id="ack1"/>
							</label>
							
					</p>
					
					</form> 
					  	</div>
					<div style="text-align:right">
					<a href="<%=path %>/exportWaterInfo.do">Export excel</a>
					&nbsp;&nbsp;
					<c:if test="${usertype==0 }">
					<a id="add" href="<%=path %>/page/water/addWater.jsp?moneyid=${money.id}">Add water price information</a>
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
							
								   <th>Num</th>
								   <th>Username</th>
								   <th>Loginname</th>
								   <th>Tele</th>
								    <th>Added time</th>
								   <th>Current Month's usage（gallon）</th>
								   <th>Should pay</th>
								     <th>Unit price</th>
								    <th>Payment status</th>
								   <c:if test="${usertype==0 }">
								   <th style="width:40px">Manipulate</th>
								   </c:if>
								</tr>
								
							</thead>
						 
							
							<tbody>
							<% int i=1; %>
							<c:choose>
							<c:when  test="${waterlist.isEmpty() }">
								<tr>
									<td colspan="10">
										<span style="color: red;font-weight: bold">No payment record！</span>
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${waterlist}" var="item" >

								<tr>
									
									<td><%=i++ %></td>
									<td>${item.user.username }</td>
									<td>${item.user.loginname }</td>
									<td>${item.user.phone }</td>
									<td><fmt:formatDate value="${item.time }" pattern="yyyy-MM-dd " /> </td>
									<td>${item.count-item.beforecount}</td>
									<!-- <td>${(item.count-item.beforecount)*(item.price.waterprice) }</td> -->
									<td><fmt:formatNumber value="${(item.count-item.beforecount)*(item.price.waterprice)}" pattern="#.0#"/></td>
									<td>${item.price.waterprice}</td>
									<td> <c:if test="${item.status=='N' }">
										
										<span class="noactive" data-values="${item.id}" >
										<a href="#"   title="Not pay yet">Not pay yet</a>
										</span>
										</c:if>
										<c:if test="${item.status=='Y' }">
										Already Paid
										</c:if>
									</td>
									<c:if test="${usertype==0 }">
									<td>
										<!-- Icons -->
										 <a href="<%=path %>/getWaterfoForedit.do?id=${item.id }" title="Edit"><img src="<%=path %>/page/admin/resources/images/icons/pencil.png" alt="Edit" /></a>
										<c:if test="${item.status=='N' }">
										 <a href="#" class="Deletea" data-value="${item.id}" >
										 	<img src="<%=path %>/page/admin/resources/images/icons/cross.png" alt="Delete" />
										 </a> 
										 </c:if>
									</td>
									</c:if>
								</tr>
					 <c:if test="${usertype==0 }" >
						<c:if test="${item.status=='N' }" >
							<tr>
								<td colspan="10">
								<div>
									Should Pay:<input class="payment" value="<fmt:formatNumber value="${(item.count-item.beforecount)*(item.price.waterprice)}" pattern="#.0#"/>" disabled="disabled" type="text" />
									Actual Pay:<input class="acpayment" type="text" />
				
									<span style="color:red;">  </span>
								</div>
								</td>
							</tr>
						</c:if>
						</c:if>
						
					 </c:forEach>
							</c:otherwise>
							</c:choose>
							
								
							</tbody>
							
						</table>
						
					</div> <!-- End #tab1 -->
					
					
				</div> <!-- End .content-box-content -->
				<div class="pagestyle">
					
						 [<a href="<%=path %>/listUser.do?currentPage=${pager.currentPage}&pagerMethod=first">FrontPage</a>]
						 [<a href="<%=path %>/listUser.do?currentPage=${pager.currentPage}&pagerMethod=previous">Pre</a>]
					total[ ${pager.currentPage}/<b>${pager.totalPages }</b>]pages
						 [<a href="<%=path %>/listUser.do?currentPage=${pager.currentPage}&pagerMethod=next">Next</a>]
						  [<a href="<%=path %>/listUser.do?currentPage=${pager.currentPage}&pagerMethod=last">End</a>]
					</div>
					<div class="clear"></div>
			</div> <!-- End .content-box -->
			</div>
			
			<div class="clear"></div>

			<!-- End Notifications -->
			
			<div id="footer">
				<small> <!-- Remove this notice or replace it with whatever you want -->
						&#169; Copyright Your Company | Powered by KSKJ
				</small>
			</div><!-- End #footer -->
			
		</div> <!-- End #main-content -->
		<script type="text/javascript">
			function accMul(arg1,arg2){ 
			    var m=0,s1=arg1.toString(),s2=arg2.toString(); 
			    try{m+=s1.split(".")[1].length}catch(e){} 
			    try{m+=s2.split(".")[1].length}catch(e){} 
			    return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m) 
			}
			function accAdd(arg1,arg2){ 
			    var r1,r2,m;
			    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
			    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
			    m=Math.pow(10,Math.max(r1,r2));
			    return (accMul(arg1,m)+accMul(arg2,m))/m; 
			}
		
			$(document).ready(function(){
		 
			var trhide;
			 var patrn=/^\d+(\.\d+)?$/; 
			$(".acpayment").blur(function(){
				if(!patrn.exec($(this).val()))
				{
			 
				$(this).parent().children("span").html("Should not be null");
					return false;
				}
				else if(eval($(this).val())<eval($(this).prev("input").val()))
				{
				 
					$(this).parent().children("span").html("Actual pay should larger than should pay");
					return false;
				
				}
				else
				{
				 
				$(this).parent().children("span").html("");
					//$(this).next("input").val(eval($(this).val())-eval($(this).prev("input").val()));
					$(this).next("input").val(accAdd(eval($(this).val()),-(eval($(this).prev("input").val()))));
				}
			});
			$("#ack1").click(function(){
					if($("#userid").val()==""){
					$("#showerr").show();
					$("#erreinfo").html("Cannot be null！");
							$("#userid").focus();
							return false;
					}
					});
			
				$(".Deletea").click(function(){
					var tmpid=$(this).attr("data-value");
					$.post("<%=path %>/deleteWater.do",
					{
						id:$(this).attr("data-value")
					},function(data,textStatus){
					if(data=="true"){
				
							$("#erreinfo").html("DELETE SUCESSFULLY！");
							$("tr:has(a[data-value="+tmpid+"])").remove();
							
							$("#showerr").show();
							$("#showerr").slideUp(3000);
						}else{
							$("#erreinfo").html("FAIL TO DELETE！");
							$("#showerr").show();
						}
						
					});
				});
				
				
				$(".noactive").click(function(){
				var num1=$(this).parent().parent().next().children("td").children("div").children("input:eq(0)").val();
				var num2=$(this).parent().parent().next().children("td").children("div").children("input:eq(1)").val();
				trhide=$(this).parent().parent().next();
				//alert(num1+"=="+num2);
				if(!patrn.exec(num2))
				{
					alert("CANNOT BE EMPTY AND NEGATIVE");
					return false;
				}
				//alert(eval(num2)+eval(num1));
				if(eval(num2)<eval(num1))
				{
					alert("ACTUALP PAY SHOULD GREATER THAN SHOULD PAY");
					return false;
				}
			 
					var tmp=$(this);
					var tmpid=$(this).attr("data-values");
						$.post("<%=path %>/reviewWaterInfo.do",
						{
							id:$(this).attr("data-values")
						},function(data,textStatus){
						if(data=="true"){
					
								$("#erreinfo").html("PAY SUSCESSFULLY！");
								tmp.html("PAID");
								$("#showerr").show();
								$("#showerr").slideUp(3000);
								$("[data-value="+tmpid+"]").hide();
								trhide.hide();
							}else
							{
							$("#erreinfo").html("FAIL TO PAY！");
							$("#showerr").show();
							}
							
						});
					 
			});
			});
	</script>
		
</body>

</html>
