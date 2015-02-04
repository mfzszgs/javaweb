<%@page import="com.beans.ProDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>校审结果</title>
    <link rel="stylesheet" type="text/css" href="MainStyle.css"/>
  </head>
  
  <body>
  	 <form action="Checker.jsp" method="post" name="form"> 
  	<%@ include file="Public/MyTitle.jsp"%>
	<center>
  	<%  ProDAO prodao = new ProDAO();
  		String name = request.getParameter("name");
  		int id = Integer.parseInt(request.getParameter("id"));
  		
  		//System.out.println("是否通过"+name);
  		//System.out.println("文档id号"+id);
  		
  		 if(name.equals("pass")){
			prodao.statexToy(id, 3, 4);
  		%>
  			<h2>通过审核！！！ </h2><br>
  			<font color="blue"><a href="Checker.jsp">返回上一页</a></font>
  		<%}
  		else if (name.equals("nopass")){
  			//prodao.updateDocSuggestion(id, suggestion);//添加修改意见
			prodao.statexToy(id, 3, 5);//更改文档状态%>
  			<h3>未通过审核,请给出意见：</h3><br>
  			<textarea name ="suggestion" rows="3" cols="30" style="width: 758px; height: 179px"></textarea><br>
  			<input type ="hidden" name="id" value="<%=id %>"><br>
  			<input type="submit" value ="提交"><br>
  		<%}%>
  		<br>
  		
	</center>
	
	
  	<%@ include file="Public/MyBottom.jsp"%>
  	</form> 
  </body>
</html>
