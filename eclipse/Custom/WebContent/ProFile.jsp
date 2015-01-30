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
.STYLE28 {font-size: 14px; color: #999999; }
.STYLE24 {
	color: #330000
}

.STYLE25 {
	color: red
}
.STYLE29 {color: #FF0000}
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
			<span class="STYLE21">当前用户：<%=session.getAttribute("loginName")%>&nbsp;&nbsp;
			</span> 
			<%
				
				String loginName = session.getAttribute("loginName").toString(); 
				DAO dao = new DAO();
				ProDAO prodao = new ProDAO();
				int uid = dao.checkUserId(loginName);
				session.setAttribute("uid", uid);/* 获得userId并设置到session中 */
				
				List<String> li = prodao.getDocState(0);/* 获得文档状态列表 */
				
				
				
				int curPages = m_pages.current_Pages(m_pages.strPage(request,"page"));
				m_pages.setPage_record(10);//设置每页显示10条
				Statement stmt = null;
				ResultSet rs = null;
				ResultSet rset = null;
				int resultconts = 0;
				int totalPages = 0;
				Connection con = Conn.getConnection();
				String sql = "select * from basicinfo where state in (2,3,4,5) and userid = "+uid+" ";
			
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
				class="STYLE21"> <u>注销</u>
			</a><span class="STYLE24"> <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE25">&nbsp;<a href="Processer.jsp"
						class="STYLE25"><em><strong><img src="images/bag.png" alt="" style="height: 25px; width: 25px; "/></strong></em><strong style="color: #00F">可接包列表</strong></a></span></label>
			</span> 
			
			
		</p>
	</form>


	<form method="post" name="form2">
		<div class="search1">
		
			<div align="center">
				<span>档案状态：
                <select name="selectDocState">
                 <%
					for (int i = 0; i < li.size(); i++) {
				%>
                  <option value="<%=i + 1%>"><%=li.get(i)%></option>
                 <%
					}
				%>
			
                </select> 
                <input name="keyword" type="text" maxlength="20"
					style="width: 196px; ">
				</span> 
				<span> 
				<input name="search" type="button" value="搜索" onClick="form2.action='SearchServlet?jsp=ProFile';form2.submit();"/>
			  </span> 
				<span class="STYLE4 STYLE22"> 
				<%-- <%
 					List<DocBean> docli = dao.getDoc(0);
 				%> 
 				共有<%=docli.size()%>条记录 --%>
				</span>
		  </div>
		
		</div>
	</form>



	<form><br><br><br><br>
		<div class="M_table">
			<table width="960" border="1" align="center" cellpadding="1"
				cellspacing="0" bordercolor="#CCCCCC" bgcolor="#EBF4FB">
				<tr>
				  <td width="287"><div align="center"><img src="images/ArchiveTitle.png" width="120" height="24"></div></td>
				  <td width="151"><div align="center"><img src="images/danganleibie.png" width="120" height="24"></div></td>
				  <td width="139"><div align="center"><img src="images/status.png" width="80" height="24"></div></td>
				  <td width="55"><div align="center"><img src="images/edit.png" width="48" height="24" hspace="10"></div></td>
				  <td width="56"><img src="images/cancle.png" width="48" height="24" hspace="9"></td>
				</tr>
				<tr>
					<%
						int i = 1;
					%>
					<%
						while (rset.next()) {
					%>
					<td><%=rset.getString("Title")%></td>
					<td><%=dao.getDocClass(rset.getInt("ClassID")).get(0)%></td>
					<td><%=prodao.getDocState(rset.getInt("State")).get(0)%></td>
					<td>
					<%if(rset.getInt("State")!=5){
					 %>
					<a href="ProMain.jsp?id=<%=rset.getInt("ID")%>">  
						<img src="images/change.png" alt="编辑" width="25" height="25" hspace="14">
					</a>
					<%}else{ %> <!-- 未通过的的文档，查看修改建议 --> 
					<a href="ProSuggestion.jsp?id=<%=rset.getInt("ID")%>">  
						<!-- <img src="images/change.png" alt="编辑" width="25" height="25" hspace="14"> -->
						查看意见
					</a>
					<%} %>
					</td>
					<td width="56">
					<a href="DelServlet?id=<%=rset.getInt("ID")%>&jsp=ProFile" onClick="del();"> 
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
		  <span>共有<%=resultconts %>条数据,共<%=totalPages %>页</span>
		  <p align="center">
		 
		  第<%=curPages%>页
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
		  <br>
			<p align="center" class="STYLE28"><span class="STYLE29"><em>*注释*</em>&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<em>列表显示全部可包档案。&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;搜索：可分别按照档案类别或关键字进行检索。<a href="ProShow.jsp"></a></em><a href="ProShow.jsp">详细流程图</a></p>
		  
	  </div>
		
			<p align="center">
				<%@ include file="Public/MyBottom.jsp"%>
			</p>
			<p>&nbsp;</p>
	</form>

</body>
</html>
