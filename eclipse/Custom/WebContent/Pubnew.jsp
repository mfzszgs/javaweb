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

<title>最新审核通过的文档</title>
<link rel="stylesheet" type="text/css" href="MainStyle.css" />


<style type="text/css">
<!--
.STYLE21 {
	color: #004993
}

.STYLE22 {
	font-size: 12px;
	color: #FF0000;
}
.STYLE27 {font-size: 14px}
.STYLE28 {font-size: 14px; color: #999999; }
.STYLE24 {
	color: #330000
}

.STYLE25 {
	color: red
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
		</jsp:useBean>
	</p>
	
	<%
				String loginName = session.getAttribute("loginName").toString();
				DAO dao = new DAO();
				ProDAO prodao = new ProDAO();

				int uid = dao.checkUserId(loginName);/* 获取userId */

				List<String> li = dao.getDocClass(0);/* 获取文档类别列表 */

				int curPages = m_pages.current_Pages(m_pages.strPage(request,
						"page"));
				m_pages.setPage_record(10);//设置每页显示10条
				int resultconts = 0;
				int totalPages = 0;
				Statement stmt = null;
				ResultSet rs = null;
				ResultSet rset = null;
				Connection con = Conn.getConnection();
				String sql = "select * from basicinfo where state = 4";
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

	<form><br><br><br><br>
		<div class="M_table">
			<table width="960" border="1" align="center" cellpadding="1"
				cellspacing="0" bordercolor="#CCCCCC" bgcolor="#EBF4FB">
				<tr>
				  <td width="307"><div align="center"><img src="images/ArchiveTitle.png" width="120" height="24"></div></td>
				  <td width="181"><div align="center"><img src="images/danganleibie.png" width="120" height="24"></div></td>
				  <td width="169"><div align="center"><img src="images/status.png" width="80" height="24"></div></td>
				  
				</tr>
				<tr>
					
					
					<%
						int i = 1;
					%>
					<%
						while (rset.next()) {
					%>
					<td><%=rset.getString("Title")%></td>
					<td><%=dao.getDocClass(rset.getInt("ClassID")).get(0) %></td>
					<td><%=prodao.getDocState(rset.getInt("State")).get(0)%></td>
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
				<a href="Pubnew.jsp?page=<%=curPages - 1%>">上一页</a>
				<%
					}
				%>
				<%
					if (curPages < totalPages) {
				%>
				<a href="Pubnew.jsp?page=<%=curPages + 1%>">下一页</a>
				<%
					}
				%> 
			</p>
		  <br>
			
		  
	  </div>
		
			<p align="center">
				<%@ include file="Public/MyBottom.jsp"%>
			</p>
			<p>&nbsp;</p>
	</form>

</body>
</html>
