<%@page import="com.beans.*"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java"
	import="java.util.*,com.beans.Conn,java.sql.*,com.filter.*,com.tools.*"
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
    <title>校审众包人员</title>
	<link rel="stylesheet" type="text/css" href="MainStyle.css"/>
	<style type="text/css">
<!--
.STYLE21 {
	color: #004993
}
-->
    </style>
</head>
  
  <body>
  <p>
		<%@ include file="Public/MyTitle.jsp"%>
	</p>
	  	<p>
				<jsp:useBean id="m_pages" scope="page" class="com.beans.Pagination">
				</jsp:useBean></p> 
	  	
	  	<form method="post" action="" name="form" style="height: 0;">
	  	<p>
			<span class="STYLE21">当前用户：<%=session.getAttribute("loginName")%>&nbsp;&nbsp;&nbsp;&nbsp;
			</span> 
			<%	String loginName = session.getAttribute("loginName").toString(); 
				DAO dao = new DAO();
				ProDAO prodao = new ProDAO();
				ChDAO chdao = new ChDAO();
				int uid = dao.checkUserId(loginName);
				session.setAttribute("uid", uid);/* 获得userId并设置到session中 */
				
				List<UsersBean> li = chdao.getProId_Name();/* 获得众包人员的名字和ID列表 */
				List<String> Cli = dao.getDocClass(0);/* 获取文档类别列表 */
			
				
				int curPages = m_pages.current_Pages(m_pages.strPage(request,"page"));
				m_pages.setPage_record(10);//设置每页显示10条
				Statement stmt = null;
				ResultSet rs = null;
				ResultSet rset = null;
				int resultconts = 0;
				int totalPages = 0;
				Connection con = Conn.getConnection();
				String sql = "select * from users where Authority = 0 and UserClass = 3";
				if (!con.isClosed())
					System.out.println("Succeeded connecting to the Database!");
				try {
					stmt = con.createStatement();
					rs = stmt.executeQuery(sql);//要执行的SQL语句
					rs.last();
					resultconts = rs.getRow();//取得总的数据数
					rs.beforeFirst();
					totalPages = m_pages.getTotal_Pages(resultconts);//取出总页数
					rset = m_pages.getPageSet(rs, curPages);//获取指针的结果集参数是(结果集，页数)
				} catch (SQLException e) {
					e.printStackTrace();
				}	

			%>
			<a href="LogoutServlet?loginName=<%=session.getAttribute("loginName")%>"
				class="STYLE21"> <u>注销</u></a>
		</p>
		</form>		
				
		<form method="post" name="form3">
		<p>&nbsp;</p>
		<div class="M_table">
		<center>
		  <table width="960" border="1" align="center" cellpadding="1"
				cellspacing="0" bordercolor="#CCCCCC" bgcolor="#EBF4FB">
            <tr>
              <td width="31%"><div align="center"><strong>用户名</strong></div></td>
              <td width="29%"><div align="center"><strong>姓名</strong></div></td>
              <td width="13%"><div align="center"><strong>查看资料</strong></div></td>
            </tr>
            <tr>
            <%
						int i = 1;
					%>
					<%
						while (rset.next()) {
					%>
              <td height="32"><center><%=rset.getString("LoginName")%></center></td>
              <td><center><%=rset.getString("Name")%></center></td>
              <td><div align="center"><a href="CheDocMain.jsp?id=<%=rset.getInt("ID")%>"><img src="images/checking.png" width="20" height="20"> </a> </div></td>
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
		</center>
			
	 </div>
	 <p>&nbsp;</p>
	 <p align="center">
				<%
					if (curPages > 1) {
				%>
				<a href="Examine.jsp?page=<%=curPages - 1%>">上一页</a>
				<%
					}
				%>
				<%
					if (curPages < totalPages) {
				%>
				<a href="Examine.jsp?page=<%=curPages + 1%>">下一页</a>
				<%
					}
				%>
			</p>
			
		<p align="center">
		<font color="blue"><a href="Manager.jsp">返回管理员主页面</a></font>
			<%@ include file="Public/MyBottom.jsp"%>
		</p>
		<p>&nbsp;</p>
	</form>
  </body>
</html>
