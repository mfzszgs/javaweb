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
	
	<title>登录成功</title>
	<link rel="stylesheet" type="text/css" href="MyStyle.css" />
	</head>
	
	<body>
		<form>
			<%@ include file="Public/MyTitle.jsp"%>
			<center><%request.setCharacterEncoding("UTF-8");%>
				<h2>
					欢迎<font color="red" size="6"><%=session.getAttribute("loginName")%></font>登录
				</h2>
			</center>
			<%@ include file="Public/MyBottom.jsp"%>
		</form>
	</body>
	
</html>
