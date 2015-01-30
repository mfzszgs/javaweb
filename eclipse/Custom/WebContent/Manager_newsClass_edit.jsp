<%@ page language="java" import="java.util.*,com.beans.*,java.sql.*,com.filter.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Manager_newsClass.jsp' starting page</title>
    
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
  <form action="Manager_newsClassServlet" method="post">
  <%
  	PubDAO pubdao = new PubDAO();
  	int newsClassId = 0;
	newsClassId	= Integer.parseInt(request.getParameter("id"));
	//System.out.println("userClassId:"+userClassId);
  	String className = pubdao.getNewsClass(newsClassId).get(0);
  	//System.out.println("className:"+className);
  	session.setAttribute("id", newsClassId);
   %><br><br>
   <center>
  	请输入类别:<input type="text" value ="<%=className%>" name="newsclass" >
  	<input type ="submit" value = "修改">
  	</center><br><br>
  	<p>
		<%@ include file="Public/MyBottom.jsp"%>
	</p>
  	</form>
  </body>
</html>
