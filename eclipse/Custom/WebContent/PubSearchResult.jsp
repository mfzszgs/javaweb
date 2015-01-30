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

<title>搜索文档</title>
<link rel="stylesheet" type="text/css" href="MainStyle.css" />
</head>

<body>
     <p>
		<%@ include file="Public/MyTitle.jsp"%>
	</p>
	
	<p>
		<jsp:useBean id="m_pages" scope="page" class="com.beans.Pagination">
		</jsp:useBean>
	</p>
  
  
   <form>
	  <div class="M_table">
	  
	  	<%  
    	NewsBean newb = (NewsBean)request.getAttribute("newb"); 
   		LinkedList<NewsBean> a=(LinkedList<NewsBean>)request.getAttribute("SearchList");
    	ListIterator<NewsBean> aIter=(ListIterator<NewsBean>)request.getAttribute("aIter");
    	%>
    	<span style="height: 30px">共搜索到<%=a.size() %>条数据</span><br><br><br>
			<table width="960" border="1" align="center" cellpadding="1"
				cellspacing="0" bordercolor="#CCCCCC" bgcolor="#EBF4FB">
				<tr>
				  <td width="287"><div align="center"><strong>新闻标题</strong></div></td>
				  <td width="151"><div align="center"><strong>栏目名称</strong></div></td>
				  <td width="139"><div align="center"><strong>发布时间</strong></div></td>
				  <td width="55"><div align="center"><strong>编辑</strong></div></td>
				  <td width="56"><div align="center"><strong>删除</strong></div></td>
				</tr>
				<%
    			DAO dao = new DAO();
  				ProDAO prodao = new ProDAO();
  				PubDAO pubdao = new PubDAO();
    	 	while(aIter.hasNext()){
    			newb = (NewsBean) aIter.next();
    	  	%>
				<tr>
					<td><%=newb.getTitle()%></td>
					<td><%=pubdao.getNewCol(newb.getColumnId()).get(0)%></td>
					<td><%=newb.getInputDate()%></td>
					<td><a href="AddNew.jsp">  
					<img src="images/change.png" alt="编辑" width="25" height="25" hspace="14">
					</a></td>
					<td width="56">
					<a href="#"> 
						<img src="images/dele.png" width="23" height="23" hspace="18">
					</a>					
					</td>
				</tr>
				<%
				}
				%>
		  </table>
		  
		 
		  
	  </div>
		
			<p align="center">
				<%@ include file="Public/MyBottom.jsp"%>
			</p>
			<p>&nbsp;</p>
	</form>

  </body>
</html>
