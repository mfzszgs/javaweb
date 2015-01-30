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
<base href="<%=basePath%>">

<title>众包人员界面</title>
<link rel="stylesheet" type="text/css" href="MainStyle.css" />

<script language="JavaScript" type="text/JavaScript">
	/* 是否全选标记 */
	var checkedAll = false;

	/* 全选/取消全选
	 * formName 所在form的name值
	 * checkboxName checkbox的name值
	 * 注意：所有checkbox的name值都必须一样，这样才能达到全选的效果
	 */
	function selectAll(formName, checkboxName) {
		var form = document.all.item(formName);
		var elements = form.elements[checkboxName];
		for ( var i = 0; i < elements.length; i++) {
			var e = elements[i];
			if (checkedAll) {
				e.checked = false;
				form.alls.checked = false;
			} else {
				e.checked = true;
				form.alls.checked = true;
			}
		}
		if (checkedAll) {
			checkedAll = false;
		} else {
			checkedAll = true;
		}
	}
	/* 检查是否有checkbox被选中
	 * formName 所在form的name值
	 * checkboxName checkbox的name值
	 * 注意：所有checkbox的name值都必须一样，这样才能达到全选的效果
	 */
	function checkAll(formName, checkboxName) {
		var hasCheck = false;
		var form = document.all.item(formName);
		var elements = form.elements[checkboxName];
		for ( var i = 0; i < elements.length; i++) {
			var e = elements[i];
			if (e.checked) {
				hasCheck = true;
			}
		}
		return hasCheck;
	}

	/* 执行操作 */
	function do_action() {
		if (!checkAll("form3", "choose")) {
			alert("没有checkbox被选中，提示用户至少选择一个！");
		} else if (checkAll("form3", "choose")) {
			document.form3.submit();
		}
	}
</script>

<style type="text/css">
<!--
.STYLE21 {
	color: #004993
}

.STYLE24 {
	color: #330000
}

.STYLE25 {
	color: red
}
.STYLE28 {font-size: 14px; color: #999999; }
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
	<form method="post" action="" name="form" style="height: 0; color: #F00;">
		<p>
			<span class="STYLE21">当前用户：<%=session.getAttribute("loginName")%>&nbsp;&nbsp;
			</span>
			<%
				String loginName = session.getAttribute("loginName").toString();
				DAO dao = new DAO();
				int uid = dao.checkUserId(loginName);/* 获取userId */

				List<String> li = dao.getDocClass(0);/* 获取文档类别列表 */

				int curPages = m_pages.current_Pages(m_pages.strPage(request, "page"));
				m_pages.setPage_record(10);//设置每页显示10条
				int resultconts = 0;
				int totalPages = 0;
				Statement stmt = null;
				ResultSet rs = null;
				ResultSet rset = null;
				Connection con = Conn.getConnection();
				String sql = "select * from basicinfo where state = 1";
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
			<a
				href="LogoutServlet?loginName=<%=session.getAttribute("loginName")%>"
				class="STYLE21"> <u>注销</u>
			</a><span class="STYLE24"> <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="STYLE25">&nbsp;
					<a href="ProFile.jsp" class="STYLE25"><em><strong>
					<img src="images/book.png" alt="" style="height: 25px; width: 25px; "/></strong></em><strong style="color: #00F">已接包列表</strong></a></span>
			</label>
			</span>
		</p>
	</form>


	<form method="post" name="form2">
		<div class="search1">

			<div align="center">
				<span> <label>档案类别： <select name="selectDocClass">
							<%
								for (int i = 0; i < li.size(); i++) {
							%>
							<option value="<%=i + 1%>"><%=li.get(i)%></option>
							<%
								}
							%>
							
					</select>
				</label> <input name="keyword" type="text" maxlength="20" style="width: 196px; ">
				</span> <span> 
				<input name="search" type="button" value="搜索"
					onClick="form2.action='SearchServlet?jsp=Processer';form2.submit();" />
				</span>

			</div>
		</div>
	</form>






	<form action="ProChStaServlet" method="post" name="form3"><br><br><br><br>
		<div class="M_table">
			<table width="960" border="1" align="center" cellpadding="1"
				cellspacing="0" bordercolor="#CCCCCC" bgcolor="#EBF4FB">
				<tr bgcolor="#EBF4FB">
					<td width="309"><div align="center">
							<img src="images/ArchiveTitle.png" width="120" height="24" />
						</div></td>
					<td width="225" height="30" class="STYLE9"><div align="center"
							class="STYLE19">
							<img src="images/buildtime.png" width="120" height="24" />
						</div></td>
					<td width="163" class="STYLE9"><div align="center"
							class="STYLE19">
							<img src="images/danganleibie.png" width="120" height="24" />
						</div></td>
					<td width="49">
						<div>
							<span class="STYLE19"> <input type="checkbox" name="alls"
								onClick="selectAll('form3','choose')" value="全选">
							</span>						</div>					</td>
				</tr>
				<tr bgcolor="#EBF4FB">

					<%
						int i = 1;
					%>
					<%
						while (rset.next()) {
					%>
					<td><%=rset.getString("Title")%></td>
					<td height="33"><%=rset.getString("InputDate")%></td>
					<td><%=dao.getDocClass(rset.getInt("ClassID")).get(0)%></td>
					<td style="width: 38px; ">
					<input type="checkbox" name="choose" value="<%=rset.getInt("ID")%>">					</td>
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
				<a href="Processer.jsp?page=<%=curPages - 1%>">上一页</a>
				<%
					}
				%>
				<%
					if (curPages < totalPages) {
				%>
				<a href="Processer.jsp?page=<%=curPages + 1%>">下一页</a>
				<%
					}
				%>
			</p>
			<p align="center">

				<%
					if (resultconts == 0) {
				%>
				抱歉，没有可包的档案了！！！
				<%
					} else {
				%>
				<input type="button" name="confirm" value="申请接包" onClick="do_action();">
				<%
					}
				%>
			</p>
			<br>
			<p align="center" class="STYLE28"><span class="STYLE29"><em>*注释*&nbsp;</em></span><em>&nbsp;&nbsp;&nbsp;</em> <em>此列表显示全部可接包档案。&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;搜索 ：可分别按照档案类别或关键字进行检索。<a href="ProShow.jsp"></a></em><a href="ProShow.jsp">详细流程图</a></p>
			<!-- <p align="center" class="STYLE27">&nbsp;</p> -->
			
		</div>
		<p align="center">
			<%@ include file="Public/MyBottom.jsp"%>
		</p>
		<p>&nbsp;</p>
	</form>

</body>
</html>


