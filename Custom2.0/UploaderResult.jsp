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
	
		${requestScope['upload.message']}
		<a href="Uploader.jsp">返回主界面</a>

	</center>
  	<%@ include file="Public/MyBottom.jsp"%>
  	</form> 
  </body>
</html>
