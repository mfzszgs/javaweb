<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'UploaderResult.jsp' starting page</title>
   	<link rel="stylesheet" type="text/css" href="MyStyle.css"/>

  </head>
  
  <body>
  
  	 <form name="form"> 
  	<%@ include file="Public/MyTitle.jsp"%>
	<center>
		<br>
		<h3>上交成功，请等候管理员审核是否通过！</h3>
		<br>
		<a href="homepage.jsp">返回主页</a>
	</center>
	<br>
  	<%@ include file="Public/MyBottom.jsp"%>
  	</form> 
  </body>
</html>
