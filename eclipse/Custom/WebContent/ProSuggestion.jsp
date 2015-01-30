<%@page import="com.beans.*"%>
<%@page import="java.io.File"%>
<%@page import="java.lang.*"%>

<%@page import="java.sql.ResultSet"%>
<%@page language="java"
	import="java.util.*,com.beans.Conn,java.sql.*,com.filter.*"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ProSuggestion.jsp' starting page</title>
   	<link rel="stylesheet" type="text/css" href="MyStyle.css"/>

  </head>
  
  <body>
  <%@ include file="Public/MyTitle.jsp"%>
  	 <form name="form"> 
  	
	<center>
		<%  int id =Integer.parseInt(request.getParameter("id"));
			DAO dao = new DAO();
			List<DocBean> bli = dao.getDoc(id);
		%>
		<h3>修改意见：</h3>
		<br><%=bli.get(0).getSuggestion()%>
		
        <br><br>
		<a href="ProFile.jsp">返回主界面</a><br>

	</center>
  	<%@ include file="Public/MyBottom.jsp"%>
  	</form> 
  </body>
</html>
