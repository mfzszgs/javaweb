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
 
  </head>
  
  <body>
  	<form >
    <%@ include file="Public/MyTitle.jsp"%>
   <div class="M_table">
     <%  
    	DocBean docb = (DocBean)request.getAttribute("docb"); 
   		LinkedList<DocBean> a=(LinkedList<DocBean>)request.getAttribute("SearchList");
    	ListIterator<DocBean> aIter=(ListIterator<DocBean>)request.getAttribute("aIter");
    %>
    <span style="height: 30px">共搜索到<%=a.size() %>条数据</span><br><br>
    
    
			<table width="960" border="1" align="center" cellpadding="1"
				cellspacing="0" bordercolor="#CCCCCC" bgcolor="#EBF4FB">
				<tr>
				  <td width="287"><div align="center"><img src="images/ArchiveTitle.png" width="120" height="24"></div></td>
				  <td width="151"><div align="center"><img src="images/danganleibie.png" width="120" height="24"></div></td>
				  <td width="139"><div align="center"><img src="images/status.png" width="80" height="24"></div></td>
				  <td width="55"><div align="center"><img src="images/edit.png" width="48" height="24" hspace="10"></div></td>
				  <td width="56"><img src="images/cancle.png" width="48" height="24" hspace="9"></td>
				</tr>
    	<%
    		DAO dao = new DAO();
  			ProDAO prodao = new ProDAO();
    	 while(aIter.hasNext()){
    		docb = (DocBean) aIter.next();
    	  	docb.getTitle();
    	  	%>
    	  	<tr>
				<td ><%=docb.getTitle()%></td>    	  	
    	  		<td ><%=dao.getDocClass(docb.getClassId()).get(0)%></td>
    	  		<td><%=prodao.getDocState(docb.getState()).get(0)%></td>
    	  		<td><a href="ProMain.jsp?id=<%=docb.getID()%>">  
					<img src="images/change.png" alt="编辑" width="25" height="25" hspace="14">
					</a></td>
    	  		<td><a href="DelServlet?id=<%=docb.getID()%>&jsp=ProFile"> 
						<img src="images/dele.png" width="23" height="23" hspace="18">
					</a></td>
    	  		 
   	  	    </tr>
    	<%  	
    	 }
    %>
    </table>
    	<center>
     	<br><font color="blue" ><a href="ProFile.jsp" >返回我的文档页</a></font>
     	</center>
    </div>

    <%@ include file="Public/MyBottom.jsp"%>
    </form>
  </body>
</html>
