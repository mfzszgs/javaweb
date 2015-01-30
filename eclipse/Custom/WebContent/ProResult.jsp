<%@page import="com.beans.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>结果</title>
   	<link rel="stylesheet" type="text/css" href="MyStyle.css" />
  </head>
  
  <body>
  
  	<form name="form">
  	<%@ include file="Public/MyTitle.jsp"%>
	<center>
	<%
		int id =Integer.parseInt(request.getParameter("id"));
		ProDAO prodao = new ProDAO();
		boolean flag = prodao.statexToy(id, 2, 3);
		if(flag){
	%>
  		<h2>提交成功！！！</h2><br>
  	<%}else{%>
  		<h2>提交失败！！！</h2><br>
  	<%}%>
  		<br>
  		<font color="blue" ><a href="ProFile.jsp">返回我的档案</a></font>
	</center>
  	<%@ include file="Public/MyBottom.jsp"%>
  	</form>
  </body>
</html>
