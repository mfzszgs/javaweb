<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.beans.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>预览界面</title>
      <link rel="stylesheet" type="text/css" href="MyStyle.css"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
   <form method ="post" name = "form" >
    <%@ include file="Public/MyTitle.jsp"%>
    
    
    <div align="center" style='color: black; border: solid 1px black; width: 1024px; height: 400px; overflow: scroll; '>
	<%
  	DAO dao = new DAO();
  	String loginName = (String)session.getAttribute("loginName");/*通过loginName得到该用户的Id*/
	String[] arr = request.getParameterValues("choose");
	
	for(int i=0;i<arr.length;i++){
		int id = Integer.parseInt(arr[i]);
		DocBean doc = dao.getDoc(id).get(0);
		String fullText = dao.getDoc(id).get(0).getFullText();
        fullText = fullText.replace("\n","<br>");
        fullText = fullText.replace(" ","&nbsp;"); 
   	%>
	<p><strong><%=doc.getTitle()%></strong></p>
	<p>起草时间：<%=doc.getBuildTime()%></p>
	<p>起草人：<%=doc.getBuilder()%></p>
	<p>译文：<%=fullText %></p>
	<br>
	<hr>
	<br>
	<%
	}
   	%>
	</div>
	<br>
    <center>
     	<font color="blue"><a href="Editor.jsp" >返回主编首页</a></font>
     </center>
	<br>
    <%@ include file="Public/MyBottom.jsp"%>
    </form>
  </body>
</html>
