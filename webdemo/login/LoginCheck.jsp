<%@page contentType="text/html" pageEncoding="GBK"%>
<%@ page import="java.sql.*"%>
<%!
	public static final String DBDRIVER = "org.gjt.mm.mysql.Driver";
	public static final String DBURL = "jdbc:mysql://localhost:3306/firstdb";
	public static final String DBUSER = "root";
	public static final String DBPASS = "s";
%>
<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean flag = false;
		String name = null;
		try {
			Class.forName(DBDRIVER);
			conn = DriverManager.getConnection(DBURL, DBUSER, DBPASS);
			String sql = "SELECT name FROM user WHERE userid=? AND password=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "admin");
			pstmt.setString(2, "admin");
			rs = pstmt.executeQuery(); // ²éÑ¯i
%>
<%="Point"%>
<%
			if (rs.next()) { // Èç¹ûÓÐÊýŸÝ£¬Ôò¿ÉÒÔÖŽÐÐ
				flag = true; // ±íÊŸµÇÂœ³É¹Š
				name = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (Exception e) {
			}
		}
		if(flag){
			System.out.println("Success");
		}else{
			System.out.println("Fail");
		}
%>
