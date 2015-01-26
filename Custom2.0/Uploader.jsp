<%@page import="com.beans.*"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*,com.beans.Conn,java.sql.*,com.filter.*"
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
<title>档案人员</title>
<link rel="stylesheet" type="text/css" href="MainStyle.css" />
<script type="text/javascript">
	function del(){
	 alert("确认删除？");
	} 
</script>



<style type="text/css">
<!--
.STYLE21 {
	color: #004993
}

.STYLE22 {
	font-size: 12px;
	color: #FF0000;
}
.STYLE23 {
	font-family: Geneva, Arial, Helvetica, sans-serif;
	font-weight: bold;
	font-size: 14px;
}
-->
</style>
</head>
<%request.setCharacterEncoding("UTF-8"); %>
<body>
   
	<p>
		<%@ include file="Public/MyTitle.jsp"%>
	</p>
	
	<p>
		<jsp:useBean id="m_pages" scope="page" class="com.beans.Pagination">
		</jsp:useBean>
	</p>
	<%
		DAO dao = new DAO();
		List<String> li = dao.getDocClass(0);/* 获得档案类别列表 */
		
		List<DocBean> docli = dao.getDoc(0);/* 获得所有档案列表 */
		
		int curPages = m_pages.current_Pages(m_pages.strPage(request,"page"));
		m_pages.setPage_record(10);//设置每页显示10条
		int resultconts = docli.size();//取得总的数据数
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
			rs = stmt
					.executeQuery("select * from basicinfo order by InputDate desc");//要执行的SQL语句
			rset = m_pages.getPageSet(rs, curPages);//获取指针的结果集参数是(结果集，页数)
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>



	<form method="post"  enctype="multipart/form-data" action="UploadServlet" name="form" style="height: 5px; ">
		<table width="83%" border="0" align="right" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#EBF4FB">
			<tr>
				<td width="200" style="width: 212px; ">编辑档案标题： <label><input
						type="text" name="docTitle" style="width: 149px; "> </label></td>
				<td width="197" style="width: 145px; ">选择档案类别： <label>
						<select name="selectDocClass">
							<%
								for (int i = 0; i < li.size(); i++) {
							%>
							<option value="<%=i + 1%>"><%=li.get(i)%></option>
							<%
								}
							%>
					</select>
				</label></td>
				<td width="174" style="width: 136px; "><label> <input
						type="file" name="file" style="width: 110px; ">
				</label></td>
				<td width="64" style="width: 79px; "><label> <input type="submit" value="上传">
				</label></td>
			</tr>
		</table>
		<p>
			<span class="STYLE21">&nbsp;&nbsp;&nbsp;用户：<%=session.getAttribute("loginName")%></span>
		
			<a href="LogoutServlet?loginName=<%=session.getAttribute("loginName")%>">注销
			</a>
		</p>

	</form>


	<form method="post" name="form2">
		<div class="search">
			<div align="center">
				<span> <img src="images/search1.png"  height="43"
			style="width: 553px; ">
				<input name="keyword" type="text" maxlength="20"
					style="width: 210px; ">
				</span> <span> 
				<input name="search" type="button" value="搜索"
					onclick="form2.action='SearchServlet?jsp=Uploader';form2.submit();" />
				</span> 
				<span class="STYLE4 STYLE22"> 
					共有<%=docli.size()%>条记录
				</span>
		  </div>
		</div>
	</form>



	<form method="post" name="form3">
		<div class="M_table">
			<table width="960" border="1" align="center" cellpadding="1"
				cellspacing="0" bordercolor="#CCCCCC" bgcolor="#EBF4FB">
				<tr>
					<td width="309"><div align="center"><img src="images/ArchiveTitle.png" width="120" height="24"></div></td>
					<td width="225" height="30" class="STYLE9"><div align="center"
							class="STYLE19"><img src="images/buildtime.png" width="120" height="24"></div></td>
					<td width="163" class="STYLE9"><div align="center"
							class="STYLE19"><img src="images/danganleibie.png" width="120" height="24"></div></td>
					<td width="49"><div align="center"><img src="images/edit.png" width="48" height="24"></div></td>
					<td width="50" class="STYLE9"><div align="center"
							class="STYLE19 STYLE23">删 除</div></td>
				</tr>
				<tr>

					<%
						int i = 1;
					%>
					<%
						while (rset.next()) {
					%>
					<td><%=rset.getString("Title")%></td>
					<td height="33"><%=rset.getString("InputDate")%></td>
					<td><%=dao.getDocClass(rset.getInt("ClassID")).get(0)%></td>
					<td style="width: 38px; "><a
						href="Update.jsp?id=<%=rset.getInt("ID")%>"> <img
							src="images/change.png" alt="编辑" width="25" height="25"
							hspace="10">
					</a></td>
					<td><a href="DelServlet?id=<%=rset.getInt("ID")%>&jsp=Uploader" onClick="del();">
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
				<a href="Uploader.jsp?page=<%=curPages - 1%>">上一页</a>
				<%
					}
				%>
				<%
					if (curPages < totalPages) {
				%>
				<a href="Uploader.jsp?page=<%=curPages + 1%>">下一页</a>
				<%
					}
				%>
			</p>

		</div>
		<p align="center">
			<%@ include file="Public/MyBottom.jsp"%>
		</p>
		<p>&nbsp;</p>
	</form>



</body>
</html>
