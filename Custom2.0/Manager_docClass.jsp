<%@ page language="java" import="java.util.*,com.beans.*,java.sql.*,com.filter.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Manager_docClass.jsp' starting page</title>
    
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
	<form>
	<%	
		DAO dao = new DAO();
		List<String> dcli = dao.getDocClass(0);
	 %>

	 <table align="center"  width="300" border="1" cellpadding="1" cellspacing="0">
	 	<tr>
	 <td>
	 	档案类别名
	 </td>
	 <td>
	 	编辑
	 </td>
	 <td>
		 删除
	 </td>
	 </tr>
	 <%for(int i=0;i<dcli.size();i++){ %>
		 <tr>
			 <td>
			 	<%= dcli.get(i) %>
			 </td>
			 <td>
			 	<a href ="Manager_docClass_edit.jsp?id=<%=i+1%>">编辑</a>
			 </td>
			 <td>
			 	删除
			 </td>
		 </tr>
	 <%} %>
	 </table>
	 
	<p align="center">
		<font color="blue"><a href="Manager.jsp">返回管理员主页面</a></font>
			<%@ include file="Public/MyBottom.jsp"%>
		</p>
	</form>
	
	
  </body>
</html>
