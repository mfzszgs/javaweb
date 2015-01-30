<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>登录失败</title>
	<link rel="stylesheet" type="text/css" href="MyStyle.css"/>
  </head>
  
  <body>
  	<form>
	  	 <%@ include file="Public/MyTitle.jsp"%>
	    <center>
	    <h2>对不起，您还没有通过审核</h2>
	   	 请返回<font color="blue" ><a href="homepage.jsp">首页</a></font>
	    </center>
	    <%@ include file="Public/MyBottom.jsp"%>
  	</form>
  </body>
</html>
