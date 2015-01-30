<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'RegistrationResult.jsp' starting page</title>
    <link rel="stylesheet" type="text/css" href="MainStyle.css" />
  </head>
  
  <body>
  
  <form action="UploadDocServlet" method="post" enctype="multipart/form-data">
  	<%@ include file="Public/MyTitle.jsp"%>
       <% String r = session.getAttribute("registrationResult").toString();
       	  System.out.println("-------传递之后的用户ID："+r);
       	  int result = Integer.parseInt(r); 
       %>
       <% if (result== 0){%>
			<center>
				尊敬的<font color="red" size="6"><%=session.getAttribute("registerName")%></font>您已注册成功<br>
				<!-- session还需要传来用户注册的类别，从而判断该跳入相对应的主页面 -->
				<font color="blue" ><a href="homepage.jsp">进入主页</a></font>	
			</center>
       <%}
       	else if(result==1){%><!-- 这种情况好像不会出现 -->
       			<h2>
					抱歉，注册失败
				</h2>
       	<%}
       	else if(result==2){%>
       			<center>
					<font color="red" size="6"><%=session.getAttribute("registerName")%></font>
					的用户名已经被别人注册，请更换用户名！！！<br><br>
					<font color="blue" size="4"><a href="Registration.jsp">返回注册页面</a></font>
				</center>
       	<%}
       	else if(result==3){%><!-- 该用户为众包人员，要向管理人员提交材料，校审其资格 -->
       		<br>
       		<table border="0" bordercolor="#7093DB" cellpadding="0" cellspacing="0" align="center">
       		<tr>
       		<td colspan="2">尊敬的&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="5"><%=session.getAttribute("registerName")%></font><br><br>您还未通过审核，请提交材料</td>
       		</tr>
       		<tr>
       		<td><br><input type="file" name = "file"></td></tr>
       		<tr>
       		<td><br><input type="submit" value = "上  传" style="width: 65px; "></td>
       		</tr>
       		</table>
       		<br>
       		<br>
       	<center>
			<font color="blue" ><a href="homepage.jsp">返回主页</a></font>	
		</center>
			<br>
       	<%}
       	%>
	<%@ include file="Public/MyBottom.jsp"%>
  </form>
  </body>
  
</html>
