<%@page import="com.beans.DAO,java.io.File"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'Manager_userCheck_result.jsp' starting page</title>
     <link rel="stylesheet" type="text/css" href="MainStyle.css" />
  </head>
  
  <body>
  <form>
  	<%@ include file="Public/MyTitle.jsp"%>
  	<center>
	<%
		DAO dao = new DAO();
		//接受众包人员的id号和是否通过校审 
		String ifp = request.getParameter("name").toString();
		int id =Integer.parseInt(request.getParameter("id")) ;
		if(ifp.equals("pass")){
		dao.updateUserAuth(id);
	 %>
 		审核通过！<br><br>
 		<font color="blue"><a href="Manager_userCheck.jsp">进入待校审人员界面</a></font>	
	 <%}else if(ifp.equals("nopass")){
	 //删除文件，同时删除数据库里的字段
	 String doaUrl = dao.getUser(id).get(0).getdocUrl(); //根据id找到上传的文件名
	 ServletContext ctx = this.getServletContext();
	 String docPath = "uploadDoc";
	 docPath = ctx.getRealPath(docPath)+"\\"+doaUrl;//获取文件的存放路径
	 //System.out.println("文件的存放路径____"+docPath);                                                                                                                                                                                                                                  
	 File file = new File(docPath); 
	    if (file.isFile() && file.exists()) {  
	        file.delete();  
	    } 
	 dao.updateUserDocUrl(id);

	  %>
		 审核未通过！<br><br>
 		<font color="blue"><a href="Manager_userCheck.jsp">进入待校审人员界面</a></font>	
	 <%} %>
	 </center>
	  <%@ include file="Public/MyBottom.jsp"%>
	 </form>
	
  </body>
</html>
