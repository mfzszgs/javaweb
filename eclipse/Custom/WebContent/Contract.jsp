<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>联系我们</title>
	<link rel="stylesheet" type="text/css" href="MyStyle.css"/>
  </head>
  
  <body>
  	<form>
	  	 <p>
	  	   <%@ include file="Public/MyTitle.jsp"%>
      </p>
	  	 <p align="center"><img src="images/Address.png" width="276" height="77"> </p>
	  	 <p align="center"><img src="images/PN.png" width="187" height="76"></p>
	  	 
	    <%@ include file="Public/MyBottom.jsp"%>
  	</form>
  </body>
</html>
