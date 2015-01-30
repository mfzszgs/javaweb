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
	
	<title>      </title>
	<link rel="stylesheet" type="text/css" href="MainStyle.css" />
	<style type="text/css">
<!--
.STYLE8 {font-size: 14px}
.STYLE10 {
	font-size: 12px;
	
}
.STYLE11 {
	font-size: 20px;
	color: #0099CC;
	font-weight: bold;
}
-->
    </style>
	</head>
	
	<body>
	<%@ include file="Public/MyTitle.jsp"%>
	<%  request.setCharacterEncoding("UTF-8"); %>
	
	<% 
		DAO dao = new DAO();
		PubDAO pubdao = new PubDAO();
		int id =Integer.parseInt(request.getParameter("id"));//获得该新闻的id号
		List<NewsBean> nli = pubdao.getNews(id);
		int uid = nli.get(0).getAuthorId();
		String loginName = dao.checkUserName(uid);
		
		
		session.setAttribute("id", id);
		session.setAttribute("uid",uid);
		
		
		
		List<String> li = pubdao.getNewCol(0);/*获得新闻栏目列表*/
	%>
	<form name="form" method="post" > 
	<div class="M_table">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="width: 900px; ">
       <!-- <tr><td colspan="3">&nbsp;</td></tr> -->
      <tr>
        <td colspan="3" align="center"><span class="STYLE11"><%=nli.get(0).getTitle()%></span></td>
      </tr>
     <tr>
        <td colspan="3" align="center"><span class="STYLE10"><%=nli.get(0).getInputDate()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=loginName%></span></td>
      </tr>
    
      <tr><td colspan="3">&nbsp;<hr></td></tr>
  
      <tr>
        <td colspan="3">
        
         <%--  <span class="STYLE8"><%=nli.get(0).getFullText()%></span> --%>
         <%
         	String fullText = nli.get(0).getFullText();
         	fullText = fullText.replace("\n","<br>");
         	fullText = fullText.replace(" ","&nbsp;");  
         %>
         
           <span class="STYLE8"><%=fullText%></span>
          
          </td>
      </tr>
      <tr><td colspan="3">&nbsp;</td></tr><tr><td colspan="3">&nbsp;</td></tr>
      
    </table>
    </div>
	<p>&nbsp;</p>
	  <p>
	    <%@ include file="Public/MyBottom.jsp"%>
      </p>
    </form>
	</body>
	
</html>