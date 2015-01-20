<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>建设中</title>
	<link rel="stylesheet" type="text/css" href="MyStyle.css"/>
  </head>
  
  <body>
  	<form>
	  	 <%@ include file="Public/MyTitle.jsp"%>
	    <center>
	    <h2>项目建设中.. </h2>
	   	 
	    </center>
	    <%@ include file="Public/MyBottom.jsp"%>
  	</form>
  </body>
</html>
