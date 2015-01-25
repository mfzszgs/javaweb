<%@page import="com.beans.*"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java"
	import="java.util.*,com.beans.Conn,java.sql.*,com.filter.*"
	pageEncoding="UTF-8"%>
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

<title>预览页面</title>
<link rel="stylesheet" type="text/css" href="MainStyle.css" />
</head>

<body>
	<form name="form" method="post">
		<p>
			<%@ include file="Public/MyTitle.jsp"%>
		</p>

		<%
			int id = Integer.parseInt(request.getParameter("id"));//获得用户Id
			System.out.println("众包人员的Id是" + id);
			DAO dao = new DAO();
			List<UsersBean> uli = dao.getUser(id);
		%>
		<%
			String virtPath = request.getServletPath();//虚拟路径
			System.out.println("虚拟路径：" + virtPath);
			System.out.println("当前WEB应用的物理路径：" + application.getRealPath("/"));
			String docUrl = uli.get(0).getdocUrl();//得到众包人员的docUrl
			System.out.println("材料名是：" + docUrl);
			String savepath = "uploadDoc";
			System.out.println("savepath是----" + savepath);
			String url = savepath + "/" + docUrl;
			System.out.println("url是----" + url);
		%>
		<center><iframe src="<%=url%>" width="900" height="550"></iframe></center>

  			<br><br>

		<center>
			<a href="Manager_userCheck.jsp<%-- ?id=<%=request.getParameter("id")%> --%>"><strong>
				返回			</strong></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
				href="Manager_userCheck_result.jsp?id=<%=request.getParameter("id")%>&&name=pass"><strong>
				通过
			    </strong></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
				href="Manager_userCheck_result.jsp?id=<%=request.getParameter("id")%>&&name=nopass"><strong>
				不通过
			    </strong></a>
		</center>
		<p>&nbsp;</p>
		
		<p align="center">
			<%@ include file="Public/MyBottom.jsp"%>
		</p>

	</form>

</body>
</html>



