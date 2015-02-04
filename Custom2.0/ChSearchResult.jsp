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
    <span style="height: 30px">共搜索到<%=a.size() %>条数据</span><br><br><br>
    
   
		  <table width="960" border="1" align="center" cellpadding="1"
				cellspacing="0" bordercolor="#CCCCCC" bgcolor="#EBF4FB">
            <tr>
              <td width="31%"><div align="center"><img src="images/ArchiveTitle.png" width="120" height="24"></div></td>
              <td width="29%"><div align="center"><img src="images/danganleibie.png" width="120" height="24"></div></td>
              <td width="27%"><div align="center"><img src="images/status.png" width="80" height="24"></div></td>
              <td width="13%"><div align="center"><img src="images/check.png" width="60" height="28"></div></td>
            </tr>
    	<%
    		DAO dao = new DAO();
    		ProDAO prodao = new ProDAO();
    		 while(aIter.hasNext()){
    		docb = (DocBean) aIter.next();
    	  	docb.getTitle();
    	  	%>
    	  	<tr>
				<td width="366"><%=docb.getTitle()%></td>    	  	
    	  		<td width="176"><%=dao.getDocClass(docb.getClassId()).get(0)%></td>
    	  		<td><%=prodao.getDocState(docb.getState()).get(0)%></td>
    	  		<td><div align="center"><a 
              href="CheMain.jsp?id=<%=docb.getID()%>"><img src="images/checking.png" width="20" height="20"> </a> </div></td> 
   	  	    </tr>
    	<%  	
    	 }
    %>
    </table><br>
    	<center>
     	<font color="blue" ><a href="Checker.jsp" >返回校审页</a></font>
     	</center>
    </div>

    <%@ include file="Public/MyBottom.jsp"%>
    </form>
  </body>
</html>
