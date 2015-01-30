<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'Manager.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css" href="MyStyle.css" />
<link rel="stylesheet" type="text/css" href="manager.css" />

<script type="text/javascript" src="jquery-1.11.1.js"></script>

</head>

<body>
<form>
	<p>
		<%@ include file="Public/MyTitle.jsp"%>
	</p>
	
	<div align="center"><br><br>
	<a href = "Manager_userInfo.jsp">人员信息管理</a><br><br>
	<a href = "Manager_userClass.jsp">人员类别管理</a><br><br>
	<a href = "Manager_docClass.jsp">档案类别管理</a><br><br>
	<a href = "Manager_newsClass.jsp">新闻类别管理</a><br><br>
	<a href = "Manager_userCheck.jsp">校审众包人员</a><br><br>
	</div>

	<p>
		<%@ include file="Public/MyBottom.jsp"%>
	</p>
	</form>
</body>
</html>
