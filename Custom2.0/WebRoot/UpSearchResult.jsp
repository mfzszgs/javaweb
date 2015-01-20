<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.beans.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'SearchReasult.jsp' starting page</title>
    <link rel="stylesheet" type="text/css" href="MainStyle.css" />
 
    <style type="text/css">
<!--
.STYLE7 {
	font-family: "新宋体";
	font-size: 14px;
	font-weight: bold;
}
-->
    </style>
</head>
  
  <body>
  	<form >
    <%@ include file="Public/MyTitle.jsp"%>
    <div class="M_table">
     <%  
    	DocBean docb = (DocBean)request.getAttribute("docb"); 
   		LinkedList<DocBean> a = (LinkedList<DocBean>)request.getAttribute("SearchList");
    	ListIterator<DocBean> aIter=(ListIterator<DocBean>)request.getAttribute("aIter");
    %>
    <span style="height: 30px">共搜索到<%=a.size() %>条数据</span><br><br>

			<table width="960" border="1" align="center" cellpadding="1"
				cellspacing="0" bordercolor="#CCCCCC" bgcolor="#EBF4FB">
				<tr >
    	  	<td width="309">
	    	  	<div align="center">
	    	  	<img src="images/ArchiveTitle.png" width="120" height="24"/></div></td>
    	  	<td width="225" height="30" class="STYLE9">
	    	  	<div align="center" class="STYLE19">
	    	  	<img src="images/buildtime.png" width="120" height="24"></div></td>
			<td width="163" class="STYLE9">
				<div align="center" class="STYLE19">
				<img src="images/danganleibie.png" width="120" height="24"></div></td>
			<td width="49"><div align="center">
				<img src="images/edit.png" width="48" height="24"></div></td>
				<td width="50" class="STYLE9"><div align="center"
							class="STYLE19 STYLE23 STYLE7">删 除</div></td>
   	    </tr>
    	<%
    		DAO dao = new DAO();
  
    	 while(aIter.hasNext()){
    		docb = (DocBean) aIter.next();
    	  	docb.getTitle();
    	  	
    	  	%>
    	  	<tr>
				<td><%=docb.getTitle()%></td>    	  	
    	  		<td><%=docb.getInputDate()%></td> 
    	  		<td><%=dao.getDocClass(docb.getClassId()).get(0)%></td>
    	  		<td style="width: 38px; ">
    	  		<a href="Update.jsp?id=<%=docb.getID()%>"> 
    	  			<img src="images/change.png" alt="编辑" width="25" height="25" hspace="10">
				</a>
				</td>
				<td>
				<a href="DelServlet?id=<%=docb.getID()%>&jsp=Uploader">
					<img src="images/dele.png" width="24" height="24" hspace="15">
				</a></td>
   	  	    </tr>
    	<%  	
    	 }
    %>
    </table>
    	<center>
     	<br><font color="blue" ><a href="Uploader.jsp" >返回上一页</a></font>
     	</center>
    </div>

    <%@ include file="Public/MyBottom.jsp"%>
    </form>
  </body>
</html>
