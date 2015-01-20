<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>众包人员业务流程图</title>
	<link rel="stylesheet" type="text/css" href="MyStyle.css"/>
  </head>
  
  <body>
  	<form>
	  	 <p>
	  	   <%@ include file="Public/MyTitle.jsp"%>
      </p>
	  	 <p align="center"><img src="images/proshow.jpg" width="550" height="613"></p>
	  	 <p>   
	  	   <%@ include file="Public/MyBottom.jsp"%>
              </p>
  	</form>
  </body>
</html>
