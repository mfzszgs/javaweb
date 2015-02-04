package com.beans;
 
import java.sql.*;
public class Conn {
	private static Connection con;
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://localhost:3306/customsdb";
    /*private static final String URL = "jdbc:mysql://192.168.1.79:3306/customsdb";*/
    private static final String USER = "root";
	private static final String PASSWORD = "s";
	
	static{
		try {
			Class.forName(DRIVER);
			System.out.println("驱动加载！");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() {
			try {
				con = DriverManager.getConnection(URL, USER, PASSWORD);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return con;
	}
	
	public static void closeCon(Connection con){
		try {
			if(con!=null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void closeStmt(Statement stmt){
		try {
			if(stmt!=null)
				stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void closeRs(ResultSet rs){
		try {
			if(rs!=null)
				rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
