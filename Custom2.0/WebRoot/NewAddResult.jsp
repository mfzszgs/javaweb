<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'AddNewReasult.jsp' starting page</title>
	<link rel="stylesheet" type="text/css" href="MyStyle.css" />

  </head>
  
  <body>
    <form name="form"> 
  	<%@ include file="Public/MyTitle.jsp"%>
	<center>
  	<% String addnewResult = session.getAttribute("addnewResult").toString();
  		boolean flag = Boolean.parseBoolean(addnewResult);
  		if(flag){%>
  			<h2> 发布成功！！！ </h2> <br>
  		<%}else{%>
  			<h2>发布失败！！！</h2><br>
  	<%}%>
  		<br>
  		<font color="blue"><a href="Publisher.jsp">返回新闻首页</a></font>
	</center>
  	<%@ include file="Public/MyBottom.jsp"%>
  	</form> 
  </body>
</html>
