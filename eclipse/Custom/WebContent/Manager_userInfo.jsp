<%@ page language="java" import="java.util.*,com.beans.Conn,java.sql.*,com.filter.*" pageEncoding="UTF-8"%>
<%@page import="com.beans.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Manager_userInfo.jsp' starting page</title>
    
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
	<p>
		<jsp:useBean id="m_pages" scope="page" class="com.beans.Pagination">
		</jsp:useBean>
	</p>
		
		<!-- 1.显示所有人员（除了管理人员class=1）的信息
			 2.可以按类别进行检索 -->
			 
			 
			 <%
		DAO dao = new DAO();
		//List<String> li = dao.getDocClass(0);/* 获得档案类别列表 */
		List<UsersBean> userli = dao.getUser(0);/* 获得所有用户列表 */
		int curPages = m_pages.current_Pages(m_pages.strPage(request,"page"));
		m_pages.setPage_record(10);//设置每页显示10条
		int resultconts = userli.size();//取得总的数据数
		int totalPages = m_pages.getTotal_Pages(resultconts);//取出总页数
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet rset = null;
		Connection con = Conn.getConnection();
		System.out.println("总数据长度为:" + resultconts);
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery("select * from users where userclass!=1");//要执行的SQL语句
			rset = m_pages.getPageSet(rs, curPages);//获取指针的结果集参数是(结果集，页数)
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
			 
	<form method="post" name="form3">
		<div class="M_table">
			<p>
				<span class="STYLE21">&nbsp;&nbsp;&nbsp;用户：<%=session.getAttribute("loginName")%></span>
				<a href="LogoutServlet?loginName=<%=session.getAttribute("loginName")%>">注销</a>
			</p>
			<table width="832"  border="1" align="center" cellpadding="1" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#FFFFFF">
				<tr bgcolor="#FFFFFF">
					<td width="309">
						<div align="center"><strong>登录名</strong></div></td>
					<td width="225" height="30" class="STYLE9">
						<div align="center" class="STYLE19"><strong>姓名</strong></div></td>
					<td width="163" class="STYLE9">
						<div align="center" class="STYLE19"><strong>用户类别</strong></div></td>
					<td width="49">
						<div align="center"><strong>
						编辑</strong></div></td>
						<td width="50" class="STYLE9">
						<div align="center" class="STYLE19"><strong>
						删除</strong></div></td>
					
				</tr>
				<tr bgcolor="#FFFFFF">
					<%
						int i = 1;
					%>
					<%
						while (rset.next()) {
					%>
					<td><%=rset.getString("LoginName")%></td>
					<td height="33"><%=rset.getString("Name")%></td>
					<td><%=dao.getUserClass(rset.getInt("UserClass")).get(0)%></td>
					<td style="width: 38px; ">
					<a href="Manager_userInfo_detail.jsp?id=<%=rset.getInt("ID")%>"> 
						<img src="images/change.png" alt="编辑" width="25" height="25" hspace="10">
					</a></td>
					<td><a href="DelServlet?id=<%=rset.getInt("ID")%>&jsp=Manager_userInfo">
						<img src="images/dele.png" width="24" height="24" hspace="10">
					</a></td>
				</tr>

				<%
					i = i + 1;
						if (i > 10)
							break;
					}
					Conn.closeRs(rs);
					Conn.closeStmt(stmt);
					Conn.closeCon(con);
					Conn.closeRs(rset);
				%>
			</table>



			<p align="center">
				<%
					if (curPages > 1) {
				%>
				<a href="Manager_userInfo.jsp?page=<%=curPages - 1%>">上一页</a>
				<%
					}
				%>
				<%
					if (curPages < totalPages) {
				%>
				<a href="Manager_userInfo.jsp?page=<%=curPages + 1%>">下一页</a>
				<%
					}
				%>
			</p>

		</div>
	<p align="center">
		<font color="blue"><a href="Manager.jsp">返回管理员主页面</a></font>
			<%@ include file="Public/MyBottom.jsp"%>
		</p>
		<p>&nbsp;</p>
	</form>
  </body>
</html>
