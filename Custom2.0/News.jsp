<%@ page language="java" import="java.util.*,com.beans.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>最新动态</title>
	<link rel="stylesheet" type="text/css" href="MyStyle.css"/>
  <meta http-equiv="Content-Type" content="text/html; charset=gb2312"><style type="text/css">
<!--
body {
	margin-left: 0px;
}
-->
</style></head>
  
  <body>
  <%
			PubDAO pubdao = new PubDAO();
			
			List<NewsBean> nli = pubdao.getNews(0);

		 %>
  	<form>
	  	 <div class="new">
	  	   <%@ include file="Public/MyTitle.jsp"%>
      
      
   &nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="images/newss.png"><img src="images/neww.png" alt="" style="height: 100px; width: 100px; " /> 
	  	<%for(int i=0;i<5;i++) {%>
					<dl>
						<dt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="NewsView.jsp?id=<%=nli.get(i).getID()%>"><%=nli.get(i).getTitle()%></a></dt>
					</dl>
					<%} %>
					<%@ include file="Public/MyBottom.jsp"%>
     </div>
	    
	    
  	</form>
  	
  </body>
</html>
