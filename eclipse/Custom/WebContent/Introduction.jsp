<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Æ½Ì¨¼ò½é</title>
	<link rel="stylesheet" type="text/css" href="MyStyle.css"/>
  </head>
  
  <body>
  	<form>
	  	 <%@ include file="Public/MyTitle.jsp"%>
	    
	    <h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="images/logo1.png" width="140" height="45"></h2>
	    <p align="center"><img src="images/lishu1.png" width="650" height="370">
	                      <img src="images/lishu2.png" width="650" height="400"></p>
	    <%@ include file="Public/MyBottom.jsp"%>
  	</form>
  </body>
</html>
