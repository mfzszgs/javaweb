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

<title>我的文档</title>
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
.STYLE24 {
	color: #330000
}

.STYLE25 {
	color: red
}
.STYLE29 {
	font-size: 14px;
	font-style: italic;
}
.STYLE30 {font-weight: bold}
.STYLE31 {color: #0000FF}
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
	<form method="post" action="" name="form" style="height: 0;">
		<p>
			<span class="STYLE21">当前用户：<%=session.getAttribute("loginName")%>&nbsp;&nbsp;&nbsp;&nbsp;			</span> 
			<%
				
				String loginName = session.getAttribute("loginName").toString(); 
				DAO dao = new DAO();
				ProDAO prodao = new ProDAO();
				PubDAO pubdao = new PubDAO();
				int uid = dao.checkUserId(loginName);
				session.setAttribute("uid", uid);/* 获得userId并设置到session中 */
				
				List<String> li = pubdao.getNewCol(0);/* 获得新闻栏目列表 */
				
				
				
				int curPages = m_pages.current_Pages(m_pages.strPage(request,"page"));
				m_pages.setPage_record(10);//设置每页显示10条
				Statement stmt = null;
				ResultSet rs = null;
				ResultSet rset = null;
				int resultconts = 0;
				int totalPages = 0;
				Connection con = Conn.getConnection();
				String sql = "select * from news where authorid = "+ uid+"";
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
				class="STYLE21"> <u>注销</u>			</a><span class="STYLE24"> <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
					class="STYLE25">&nbsp;<span class="STYLE30"><span class="STYLE31"><a href="NewAdd.jsp" class="STYLE25">添加新闻</a></span></span></span></label>
			</span>		</p>
	</form>

	<form method="post" name="form2">
		<div class="search1">
		
			<div align="center">
				<span>栏目：
               <select name="selectNewCol">
							<%
								for (int i = 0; i < li.size(); i++) {
							%>
							<option value="<%=i + 1%>"><%=li.get(i)%></option>
							<%
								}
							%>
							
					</select>
                <input name="keyword" type="text" maxlength="20" style="width: 216px; ">
				</span> 
				<span> 
				<input name="search" type="button" value="搜索" onClick="form2.action='SearchServlet?jsp=Publisher';form2.submit();"/>
			  	</span> 
			  
				<span class="STYLE4 STYLE22"> 

				</span>
		  </div>
		
		</div>
	</form>



	<form><br><br><br><br>
	  <div class="M_table">
			<table width="960" border="1" align="center" cellpadding="1"
				cellspacing="0" bordercolor="#CCCCCC" bgcolor="#EBF4FB">
				<tr>
				  <td width="287"><div align="center"><strong>新闻标题</strong></div></td>
				  <td width="151"><div align="center"><strong>栏目名称</strong></div></td>
				  <td width="139"><div align="center"><strong>发布时间</strong></div></td>
				  <td width="55"><div align="center"><strong>编辑</strong></div></td>
				  <td width="56"><div align="center"><strong>删除</strong></div></td>
				</tr>
				<tr>
					<%
						int i = 1;
					%>
					<%
						while (rset.next()) {
					%>
					
					<td><%=rset.getString("Title")%></td>
					<td><%=pubdao.getNewCol(rset.getInt("ColumnID")).get(0)%></td>
					<td><%=rset.getString("InputDate") %></td>
					<td><a href="NewEdit.jsp?id=<%=rset.getInt("ID")%>">  
					<img src="images/change.png" alt="编辑" width="25" height="25" hspace="14">
					</a></td>
					<td width="56">
					<a href="DelServlet?id=<%=rset.getInt("ID")%>&jsp=Publisher"> 
						<img src="images/dele.png" width="23" height="23" hspace="18">
					</a>					
					</td>
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
				<a href="ProFile.jsp?page=<%=curPages - 1%>">上一页</a>
				<%
					}
				%>
				<%
					if (curPages < totalPages) {
				%>
				<a href="ProFile.jsp?page=<%=curPages + 1%>">下一页</a>
				<%
					}
				%>
		</p>
		  <div align="right"><br>
              <a href="Pubnew.jsp" class="STYLE29">查看已通过审核的新档案列表</a>
		   
	        </div>
	  </div>
		
			<p align="center">
				<%@ include file="Public/MyBottom.jsp"%>
			</p>
			<p>&nbsp;</p>
	</form>

</body>
</html>
