<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>��¼ʧ��</title>
	<link rel="stylesheet" type="text/css" href="MyStyle.css"/>
  </head>
  
  <body>
  	<form>
	  	 <%@ include file="Public/MyTitle.jsp"%>
	    <center>
	    <h2>��¼ʧ�ܣ���</h2>
	   	 �뷵��<font color="blue" ><a href="HomePage.jsp">��ҳ</a></font>
	   	 ���µ�¼
	    </center>
	    <%@ include file="Public/MyBottom.jsp"%>
  	</form>
  </body>
</html>
