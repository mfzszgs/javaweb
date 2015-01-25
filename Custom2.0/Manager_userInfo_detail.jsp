<%@ page language="java" import="java.util.*,com.beans.*,java.sql.*,com.filter.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Manager_userInfo_detail.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="MainStyle.css" />
  </head>
  
  <body>
   <p>
		<%@ include file="Public/MyTitle.jsp"%>
	</p>
	<form>
	<center>
  	<% int id =Integer.parseInt(request.getParameter("id")); //获得用户id
		DAO dao = new DAO();
		List<UsersBean> userli = dao.getUser(id);
		int cid = userli.get(0).getUserClass();//获得用户类别id
		int sid = userli.get(0).getSexId();//获得性别id
		String sex = null;
		if(sid == 0){
			sex = "男";
		}else if(sid == 1){
			sex = "女";
		}
  	 %>
  	 <h2>UserClass:<%=dao.getUserClass(cid)%><br>
  	 email:<%=userli.get(0).getEmail()%><br>
  	 LoginName:<%=userli.get(0).getLoginName()%><br>
  	 Password:<%=userli.get(0).getPassword()%><br>
  	 Name:<%=userli.get(0).getName()%><br>
  	 sex:<%=sex%><br></h2>
  	 
  	 </center>
  	 <p align="center">
			<%@ include file="Public/MyBottom.jsp"%>
		</p>
		<p>&nbsp;</p>
		</form>
  </body>
</html>
