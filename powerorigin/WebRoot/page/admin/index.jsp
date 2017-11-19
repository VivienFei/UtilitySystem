<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/frameset.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE>PowerAndWaterManagementSystem</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<META   HTTP-EQUIV= "Pragma"   CONTENT= "no-cache" >   
<META   HTTP-EQUIV= "Cache-Control"   CONTENT= "no-cache">   
<META   HTTP-EQUIV= "Expires"   CONTENT= "0">  
<META content="MSHTML 6.00.2900.3492" name=GENERATOR></HEAD>
<%   
response.setHeader("Pragma","No-cache");    
response.setHeader("Cache-Control","no-cache");    
response.setDateHeader("Expires", 0); 
%>   

<FRAMESET frameSpacing=0   cols=230,*>
<FRAME name=menu src="<%=path %>/page/admin/menu.jsp" frameBorder=0 scrolling="no" noresize/>
<FRAME name=main src="<%=path %>/page/admin/main.jsp" frameBorder=0 scrolling="no" noresize/>

<NOFRAMES> <p>This page requires frames, but your browser does not support them.</p>
    </NOFRAMES>
</FRAMESET>
</HTML>
