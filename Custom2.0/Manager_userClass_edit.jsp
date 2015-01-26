<%@ page language="java" import="java.util.*,com.beans.*,java.sql.*,com.filter.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Manager_userClass.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
<link rel="stylesheet" type="text/css" href="MainStyle.css" />
	

  </head>
  
  <body>
   <p>
		<%@ include file="Public/MyTitle.jsp"%>
	</p>
  <form action="Manager_userClassServlet" method="post">
  <%
  	DAO dao = new DAO();
	int userClassId	= Integer.parseInt(request.getParameter("id"));
	//System.out.println("userClassId:"+userClassId);
  	String className = dao.getUserClass(userClassId).get(0);
  	//System.out.println("className:"+className);
  	session.setAttribute("id", userClassId);
   %><br><br>
   <center>
  	请输入类别:<input type="text" value ="<%=className%>" name="userclass" >
  	<input type ="submit" value = "修改">
  	</center><br><br>
  	<p>
		<%@ include file="Public/MyBottom.jsp"%>
	</p>
  	</form>
  </body>
</html>
