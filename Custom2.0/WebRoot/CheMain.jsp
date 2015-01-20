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

<style type="text/css">
<!--
.STYLE7 {
	color: black;
}

.STYLE12 {
	color: #333333
}

.STYLE13 {
	color: #333333;
	font-family: "宋体";
}
-->
</style>
</head>

<body>
	<form name="form" method="post">
		<p>
			<%@ include file="Public/MyTitle.jsp"%>
		</p>

		<%
			int id = Integer.parseInt(request.getParameter("id"));
			DAO dao = new DAO();
			List<DocBean> bli = dao.getDoc(id);
		%>
		<%
	
		String virtPath = request.getServletPath();//虚拟路径
		System.out.println("虚拟路径："+virtPath);
		System.out.println("当前WEB应用的物理路径："+application.getRealPath("/"));
		String rawUrl = bli.get(0).getRawUrl();//得到当前档案的rawUrl
		String savepath =  "uploads";
		System.out.println("savepath是----"+savepath);
		String url = savepath+"/"+rawUrl;
		System.out.println("url是----"+url);
		
		
		
	%>
         <iframe src="<%=url%>" width="510" height="550"></iframe>
			<div class="biaoge" style="width:500px;height:310px;">
				<table width="100%" height="310" border="1" cellpadding="1" cellspacing="0">
					<tr>
						<td colspan="2"><span class="STYLE12">标题：<%=bli.get(0).getTitle()%></span></td>
					</tr>
					<tr>
						<td width=33%><span class="STYLE12">关键词：<%=bli.get(0).getKeyWords()%></span></td>
						<td><span class="STYLE12">关键人：<%=bli.get(0).getKeyPersons()%></span>
						
						</td>
					</tr>
					<tr>
						<td class="STYLE12">起草日期：<%=bli.get(0).getBuildTime()%></td>
						<td class="STYLE12">起草人：<%=bli.get(0).getBuilder()%></td>
					</tr>
					<tr>
						<td colspan="2" class="STYLE12">摘要：<%=bli.get(0).getDocAbstract()%></td>
					</tr>
					<tr>
						<td colspan="2" width=100% class="STYLE7" style="height: 170px; ">
							<div class="STYLE7" style="height:170px; overflow-y:scroll; border:0 solid;">
								原文：<br><%=bli.get(0).getFullText()%>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" width=100% class="STYLE7" style="height: 170px; ">
							<div class="STYLE7" style="height:170px; overflow-y:scroll; border:0 solid;">
								译文：<br><%=bli.get(0).getTranslateText()%>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="height:25px;">
						  <div align="center">
						    <p align="center"><a href="Checker.jsp?id=<%=request.getParameter("id")%>">
						      返回</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					          <a href="CheResult.jsp?id=<%=request.getParameter("id")%>&&name=pass">
					            通过</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					          <a href="CheResult.jsp?id=<%=request.getParameter("id")%>&&name=nopass">
					          不通过</a> </p>
						  </div></td>
				  </tr>
				</table>
			</div>
		</div>
		<p align="center">&nbsp;</p>
		<p>&nbsp;</p>
		<p align="center">
			<%@ include file="Public/MyBottom.jsp"%>
		</p>

	</form>

</body>
</html>



