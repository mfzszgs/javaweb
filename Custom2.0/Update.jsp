<%@page import="com.beans.*"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*,com.beans.Conn,java.sql.*,com.filter.*"
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
	
	<title>开始编辑：</title>
	<link rel="stylesheet" type="text/css" href="MainStyle.css" />
	<style type="text/css">
<!--
.STYLE2 {
	font-size: 16px;
	font-weight: bold;
	color: #0000FF;
}
.STYLE5 {font-size: 14px; font-weight: bold; color: #0000FF; }
-->
    </style>
	</head>
	
	<body>
	<%@ include file="Public/MyTitle.jsp"%>
	<%  request.setCharacterEncoding("UTF-8"); %>
	
	<%  int id =Integer.parseInt(request.getParameter("id")); 
		DAO dao = new DAO();
		List<DocBean> bli = dao.getDoc(id);
		session.setAttribute("id", id);
	%>
	<form name="form" method="post" > <br><br>
	<div class="M_table">
	<table width="100%" border="1" cellpadding="1" cellspacing="0" style="width: 900px; ">
      <tr>
        <td colspan="2">上传：<input type="file" name="file" style="width: 600px; "></td>
      </tr>
      <tr>
        <td colspan="2">标题：<input name="docTitle" type="text" value ="<%=bli.get(0).getTitle()%>"  style="width: 600px; "></td>
      </tr>
      <tr>
        <td>类别：
        <select name="selectDocClass">
							<% 
								List<String> li = dao.getDocClass(0);
								for (int i = 0; i < li.size(); i++) {
									
									if(i+1 == bli.get(0).getClassId()){
										%>
										<option value="<%=i + 1%>" selected="selected"><%=li.get(i)%></option>
										<%
									}
							%>
							<option value="<%=i + 1%>"><%=li.get(i)%></option>
							<%
								}
							%>
					</select></td>
        <td>作者：<input type="text" name="textfield3" style="width: 350px; "/></td>
      </tr>
      <tr>
        <td>时间：<input type="text" name="textfield4" style=" width: 350px"/></td>
        <td>关键字：<input type="text" name="textfield5" style="width: 334px;"/></td>
      </tr>
      <tr>
        <td colspan="2"><input onclick="form.action='UploadUpdateServlet';form.submit();" type="submit" name="Submit" value="提   交" style="width: 60px;"></td>
      </tr>
      
    </table><br><br>
    </div>
	<p>&nbsp;      </p>
	  <p>
	    <%@ include file="Public/MyBottom.jsp"%>
      </p>
    </form>
	</body>
	
</html>